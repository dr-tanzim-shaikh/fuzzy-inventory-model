# crisp_model_cost_function.R
# Project: fuzzy-inventory-model
# Purpose: Implement the crisp cost function from the MATLAB code
# and reproduce the reported crisp numerical result.

# ------------------------------------------------------------
# 1. Create output folders
# ------------------------------------------------------------

dir.create("outputs", showWarnings = FALSE)
dir.create("outputs/tables", recursive = TRUE, showWarnings = FALSE)

# ------------------------------------------------------------
# 2. Parameter values
# ------------------------------------------------------------

alpha <- 1500
s <- 4
beta <- 2.4
gamma <- 0.02
lambda <- 4
tm <- 0.45

Hc <- 0.2
Dc <- 5
Pc <- 3
A <- 200
Sc <- 7

# ------------------------------------------------------------
# 3. Crisp cost function
# ------------------------------------------------------------

crisp_model_values <- function(t1, T) {
  q1 <- (((alpha / (s^beta)) * exp(-gamma * (tm^lambda))) *
    (
      t1 - tm +
        ((gamma / (lambda + 1)) *
          ((t1^(lambda + 1)) - (tm^(lambda + 1))))
    )) +
    ((alpha / (s^beta)) * tm)

  q2_matlab <- -(alpha / (2 * (s^beta))) * ((T - t1)^2)
  q2_backorder <- -q2_matlab

  holding_cost <- Hc * (
    ((q1 * tm) - ((alpha / (s^beta)) * ((tm^2) / 2))) +
      (
        (alpha / (s^beta)) * (((t1 - tm)^2) / 2) +
          (
            ((gamma * lambda) / ((lambda + 1) * (lambda + 2))) *
              ((t1^(lambda + 2)) - (tm^(lambda + 2)))
          ) -
          (
            ((gamma / (lambda + 1)) * t1 * tm) *
              ((t1^lambda) - (tm^lambda))
          )
      )
  )

  deterioration_cost <- (
    (Dc * gamma * lambda * (alpha / (s^beta))) *
      (
        ((t1^(lambda + 1)) / (lambda * (lambda + 1))) -
          (t1 * (tm^lambda) / lambda) +
          ((tm^(lambda + 1)) / (lambda + 1))
      )
  )

  purchase_cost <- Pc * (q1 + q2_matlab)

  shortage_cost <- Sc * (alpha / (2 * (s^beta))) * ((T - t1)^2)

  ordering_cost <- A

  total_cost <- (1 / T) * (
    purchase_cost +
      deterioration_cost +
      holding_cost +
      ordering_cost +
      shortage_cost
  )

  Q <- q1 + q2_backorder

  return(list(
    t1 = t1,
    T = T,
    total_cost = total_cost,
    q1 = q1,
    q2 = q2_backorder,
    Q = Q,
    purchase_cost = purchase_cost,
    holding_cost = holding_cost,
    deterioration_cost = deterioration_cost,
    shortage_cost = shortage_cost,
    ordering_cost = ordering_cost
  ))
}

cost_function <- function(x) {
  crisp_model_values(x[1], x[2])$total_cost
}

# ------------------------------------------------------------
# 4. Numerical derivatives for Newton method
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
# 5. Newton iteration matching MATLAB structure
# ------------------------------------------------------------

X <- c(0.1, 0.55)
iterations <- 3

iteration_history <- data.frame(
  iteration = integer(),
  t1 = numeric(),
  T = numeric(),
  total_cost = numeric()
)

for (i in 1:iterations) {
  grad <- numerical_gradient(cost_function, X)
  Hess <- numerical_hessian(cost_function, X)

  step <- solve(Hess, grad)
  X <- X - step

  current_values <- crisp_model_values(X[1], X[2])

  iteration_history <- rbind(
    iteration_history,
    data.frame(
      iteration = i,
      t1 = current_values$t1,
      T = current_values$T,
      total_cost = current_values$total_cost
    )
  )
}

# ------------------------------------------------------------
# 6. Final computed values
# ------------------------------------------------------------

computed <- crisp_model_values(X[1], X[2])

computed_result <- data.frame(
  t1 = computed$t1,
  T = computed$T,
  total_cost = computed$total_cost,
  q1 = computed$q1,
  q2 = computed$q2,
  Q = computed$Q,
  purchase_cost = computed$purchase_cost,
  holding_cost = computed$holding_cost,
  deterioration_cost = computed$deterioration_cost,
  shortage_cost = computed$shortage_cost,
  ordering_cost = computed$ordering_cost
)

reported_result <- data.frame(
  t1 = 0.9680,
  T = 1.7437,
  total_cost = 245.1534,
  q1 = 52.2783,
  q2 = 16.1996,
  Q = 68.4779
)

comparison <- data.frame(
  quantity = c("t1", "T", "total_cost", "q1", "q2", "Q"),
  reported = as.numeric(reported_result[1, ]),
  computed = as.numeric(computed_result[1, c(
    "t1",
    "T",
    "total_cost",
    "q1",
    "q2",
    "Q"
  )]),
  difference = as.numeric(computed_result[1, c(
    "t1",
    "T",
    "total_cost",
    "q1",
    "q2",
    "Q"
  )]) -
    as.numeric(reported_result[1, ])
)

# ------------------------------------------------------------
# 7. Save outputs
# ------------------------------------------------------------

write.csv(
  iteration_history,
  "outputs/tables/crisp_model_newton_iterations.csv",
  row.names = FALSE
)

write.csv(
  computed_result,
  "outputs/tables/crisp_model_computed_result.csv",
  row.names = FALSE
)

write.csv(
  comparison,
  "outputs/tables/crisp_model_reported_vs_computed.csv",
  row.names = FALSE
)

# ------------------------------------------------------------
# 8. Print confirmation
# ------------------------------------------------------------

cat("Crisp model cost function executed successfully.\n")
cat("Computed t1:", round(computed$t1, 4), "\n")
cat("Computed T:", round(computed$T, 4), "\n")
cat("Computed total cost:", round(computed$total_cost, 4), "\n")
cat("Computed q1:", round(computed$q1, 4), "\n")
cat("Computed q2:", round(computed$q2, 4), "\n")
cat("Computed Q:", round(computed$Q, 4), "\n")
cat("CSV files saved in outputs/tables/\n")
