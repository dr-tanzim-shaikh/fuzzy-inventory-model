# fuzzy_model_cost_function.R
# Project: fuzzy-inventory-model
# Purpose: Implement the fuzzy model total cost function using GMIR
# and compare computed results with the reported fuzzy model values.

# ------------------------------------------------------------
# 1. Create output folders
# ------------------------------------------------------------

dir.create("outputs", showWarnings = FALSE)
dir.create("outputs/tables", recursive = TRUE, showWarnings = FALSE)

# ------------------------------------------------------------
# 2. Fixed parameter values
# ------------------------------------------------------------

s <- 4
gamma <- 0.02
lambda <- 4
tm <- 0.45

# ------------------------------------------------------------
# 3. Fuzzy parameter values used in MATLAB code
# ------------------------------------------------------------

fuzzy_parameters <- data.frame(
  alpha = c(1200, 1300, 1400, 1600, 1700, 1800),
  beta = c(2.1, 2.2, 2.3, 2.5, 2.6, 2.7),
  Hc = c(0.05, 0.10, 0.15, 0.25, 0.30, 0.35),
  Dc = c(2, 3, 4, 6, 7, 8),
  Pc = c(1.5, 2.0, 2.5, 3.5, 4.0, 4.5),
  A = c(50, 100, 150, 250, 300, 350),
  Sc = c(4, 5, 6, 8, 9, 10)
)

gmir_weights <- c(1, 3, 2, 2, 3, 1) / 12

# ------------------------------------------------------------
# 4. Cost function for one fuzzy component
# ------------------------------------------------------------

component_cost <- function(t1, T, alpha, beta, Hc, Dc, Pc, A, Sc) {
  q1_component <- (alpha * tm) / (s^beta) +
    (
      alpha * exp(-gamma * tm^lambda) *
        (
          t1 - tm +
            (gamma * (t1^(lambda + 1) - tm^(lambda + 1))) / (lambda + 1)
        )
    ) /
      (s^beta)

  purchase_part <- Pc * (
    (alpha * tm) / (s^beta) -
      (alpha * (T - t1)^2) / (2 * s^beta) +
      (
        alpha * exp(-gamma * tm^lambda) *
          (
            t1 - tm +
              (gamma * (t1^(lambda + 1) - tm^(lambda + 1))) /
                (lambda + 1)
          )
      ) /
        (s^beta)
  )

  holding_part <- Hc * (
    tm * q1_component -
      (alpha * tm^2) / (2 * s^beta) +
      (alpha * (t1 - tm)^2) / (2 * s^beta) -
      (gamma * t1 * tm * (t1^lambda - tm^lambda)) / (lambda + 1) +
      (
        gamma * lambda * (t1^(lambda + 2) - tm^(lambda + 2))
      ) /
        ((lambda + 1) * (lambda + 2))
  )

  shortage_part <- (Sc * alpha * (T - t1)^2) / (2 * s^beta)

  deterioration_part <- (
    Dc * alpha * gamma * lambda *
      (
        tm^(lambda + 1) / (lambda + 1) -
          (t1 * tm^lambda) / lambda +
          t1^(lambda + 1) / (lambda * (lambda + 1))
      )
  ) /
    (s^beta)

  total_cost <- (
    A +
      purchase_part +
      holding_part +
      shortage_part +
      deterioration_part
  ) /
    T

  return(total_cost)
}

# ------------------------------------------------------------
# 5. GMIR fuzzy total cost function
# ------------------------------------------------------------

fuzzy_total_cost <- function(x) {
  t1 <- x[1]
  T <- x[2]

  costs <- mapply(
    component_cost,
    alpha = fuzzy_parameters$alpha,
    beta = fuzzy_parameters$beta,
    Hc = fuzzy_parameters$Hc,
    Dc = fuzzy_parameters$Dc,
    Pc = fuzzy_parameters$Pc,
    A = fuzzy_parameters$A,
    Sc = fuzzy_parameters$Sc,
    MoreArgs = list(t1 = t1, T = T)
  )

  total <- sum(gmir_weights * costs)

  return(total)
}

# ------------------------------------------------------------
# 6. Numerical derivatives
# ------------------------------------------------------------

numerical_gradient <- function(fn, x, h = 1e-6) {
  grad <- numeric(length(x))

  for (i in seq_along(x)) {
    x_forward <- x
    x_backward <- x

    x_forward[i] <- x_forward[i] + h
    x_backward[i] <- x_backward[i] - h

    grad[i] <- (fn(x_forward) - fn(x_backward)) / (2 * h)
  }

  return(grad)
}

numerical_hessian <- function(fn, x, h = 1e-4) {
  n <- length(x)
  H <- matrix(0, nrow = n, ncol = n)

  for (i in 1:n) {
    for (j in 1:n) {
      x1 <- x
      x2 <- x
      x3 <- x
      x4 <- x

      x1[i] <- x1[i] + h
      x1[j] <- x1[j] + h

      x2[i] <- x2[i] + h
      x2[j] <- x2[j] - h

      x3[i] <- x3[i] - h
      x3[j] <- x3[j] + h

      x4[i] <- x4[i] - h
      x4[j] <- x4[j] - h

      H[i, j] <- (fn(x1) - fn(x2) - fn(x3) + fn(x4)) / (4 * h^2)
    }
  }

  return(H)
}

# ------------------------------------------------------------
# 7. Newton iteration matching MATLAB structure
# ------------------------------------------------------------

X <- c(0.1, 0.55)
iterations <- 3

iteration_history <- data.frame(
  iteration = integer(),
  t1 = numeric(),
  T = numeric(),
  fuzzy_total_cost = numeric()
)

for (i in 1:iterations) {
  grad <- numerical_gradient(fuzzy_total_cost, X)
  Hess <- numerical_hessian(fuzzy_total_cost, X)

  step <- solve(Hess, grad)
  X <- X - step

  iteration_history <- rbind(
    iteration_history,
    data.frame(
      iteration = i,
      t1 = X[1],
      T = X[2],
      fuzzy_total_cost = fuzzy_total_cost(X)
    )
  )
}

# ------------------------------------------------------------
# 8. Final computed and reported values
# ------------------------------------------------------------

computed_result <- data.frame(
  t1 = X[1],
  T = X[2],
  fuzzy_total_cost = fuzzy_total_cost(X)
)

reported_result <- data.frame(
  t1 = 0.9854,
  T = 1.7527,
  fuzzy_total_cost = 239.4447
)

comparison <- data.frame(
  quantity = c("t1", "T", "fuzzy_total_cost"),
  reported = as.numeric(reported_result[1, ]),
  computed = as.numeric(computed_result[1, ]),
  difference = as.numeric(computed_result[1, ]) -
    as.numeric(reported_result[1, ])
)

# ------------------------------------------------------------
# 9. Save outputs
# ------------------------------------------------------------

write.csv(
  iteration_history,
  "outputs/tables/fuzzy_model_newton_iterations.csv",
  row.names = FALSE
)

write.csv(
  computed_result,
  "outputs/tables/fuzzy_model_computed_result.csv",
  row.names = FALSE
)

write.csv(
  comparison,
  "outputs/tables/fuzzy_model_reported_vs_computed.csv",
  row.names = FALSE
)

# ------------------------------------------------------------
# 10. Print confirmation
# ------------------------------------------------------------

cat("Fuzzy model cost function executed successfully.\n")
cat("Computed t1:", round(computed_result$t1, 4), "\n")
cat("Computed T:", round(computed_result$T, 4), "\n")
cat("Computed fuzzy total cost:", round(computed_result$fuzzy_total_cost, 4), "\n")
cat("CSV files saved in outputs/tables/\n")
