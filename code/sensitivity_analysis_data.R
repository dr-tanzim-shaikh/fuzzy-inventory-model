# sensitivity_analysis_data.R
# Project: fuzzy-inventory-model
# Purpose: Enter sensitivity analysis data from Shaikh & Gite (2024),
# save CSV tables, and create basic plots.
#
# Source:
# Shaikh, T. S., & Gite, S. P. (2024).
# Fuzzy Inventory Model under Selling Price Dependent Demand and Variable
# Deterioration with Fully Backlogged Shortages.
# American Journal of Operations Research, 14, 87–103.
# https://doi.org/10.4236/ajor.2024.142005

# ------------------------------------------------------------
# 1. Create output folders
# ------------------------------------------------------------

dir.create("outputs", showWarnings = FALSE)
dir.create("outputs/tables", recursive = TRUE, showWarnings = FALSE)
dir.create("outputs/plots", recursive = TRUE, showWarnings = FALSE)

# ------------------------------------------------------------
# 2. Sensitivity analysis data
# ------------------------------------------------------------

eta_data <- data.frame(
  eta = c(1300, 1400, 1500, 1600, 1700),
  t1 = c(1.0131, 1.0056, 0.9978, 0.9898, 0.9815),
  T = c(1.7725, 1.7646, 1.7566, 1.7482, 1.7396),
  GC_t1_T = c(221.2310, 229.8855, 238.5196, 247.1468, 255.7565),
  q1 = c(49.2151, 52.6022, 55.9155, 59.1577, 62.3203),
  q2 = c(13.9560, 15.0137, 16.0777, 17.1314, 18.1877),
  Q = c(63.1711, 67.6159, 71.9931, 76.2891, 80.5080)
)

beta_data <- data.frame(
  beta = c(2.2, 2.3, 2.4, 2.5, 2.6),
  t1 = c(0.8989, 0.9284, 0.9517, 0.9704, 0.9856),
  T = c(1.6803, 1.7108, 1.7348, 1.7541, 1.7699),
  GC_t1_T = c(295.5123, 271.5838, 250.6481, 232.3465, 216.3574),
  q1 = c(64.0014, 57.5650, 51.3864, 45.6253, 40.3502),
  q2 = c(21.6908, 18.9313, 16.5102, 14.3950, 12.5508),
  Q = c(85.6922, 76.4963, 67.8966, 60.0202, 52.9009)
)

gamma_data <- data.frame(
  gamma = c(0.005, 0.01, 0.02, 0.03, 0.04),
  t1 = c(0.9994, 0.9947, 0.9854, 0.9764, 0.9676),
  T = c(1.7599, 1.7574, 1.7527, 1.7480, 1.7436),
  GC_t1_T = c(238.6083, 238.9000, 239.4447, 239.9594, 240.4329),
  q1 = c(53.9185, 53.7094, 53.2897, 52.8778, 52.4691),
  q2 = c(15.5880, 15.6783, 15.8680, 16.0464, 16.2299),
  Q = c(69.5065, 69.3877, 69.1577, 68.9242, 68.6990)
)

lambda_data <- data.frame(
  lambda = c(2, 3, 4, 5, 6),
  t1 = c(0.9652, 0.9760, 0.9854, 0.9924, 0.9971),
  T = c(1.7418, 1.7477, 1.7527, 1.7563, 1.7587),
  GC_t1_T = c(239.9190, 239.6896, 239.4447, 239.2420, 239.0864),
  q1 = c(52.2052, 52.7919, 53.2897, 53.6538, 53.8932),
  q2 = c(16.2550, 16.0505, 15.8680, 15.7277, 15.6331),
  Q = c(68.4602, 68.8424, 69.1577, 69.3815, 69.5264)
)

tm_data <- data.frame(
  tm = c(0.25, 0.35, 0.45, 0.55, 0.65),
  t1 = c(0.9838, 0.9842, 0.9854, 0.9877, 0.9917),
  T = c(1.7522, 1.7523, 1.7527, 1.7534, 1.7547),
  GC_t1_T = c(239.5591, 239.5239, 239.4447, 239.3150, 239.1251),
  q1 = c(53.2263, 53.2401, 53.2897, 53.3895, 53.5722),
  q2 = c(15.9135, 15.9011, 15.8680, 15.8019, 15.6907),
  Q = c(69.1398, 69.1412, 69.1577, 69.1914, 69.2629)
)

# ------------------------------------------------------------
# 3. Save CSV tables
# ------------------------------------------------------------

write.csv(eta_data, "outputs/tables/sensitivity_eta.csv", row.names = FALSE)
write.csv(beta_data, "outputs/tables/sensitivity_beta.csv", row.names = FALSE)
write.csv(gamma_data, "outputs/tables/sensitivity_gamma.csv", row.names = FALSE)
write.csv(lambda_data, "outputs/tables/sensitivity_lambda.csv", row.names = FALSE)
write.csv(tm_data, "outputs/tables/sensitivity_tm.csv", row.names = FALSE)

# ------------------------------------------------------------
# 4. Plotting function
# ------------------------------------------------------------

create_plots <- function(data, parameter_name) {
  
  x <- data[[parameter_name]]
  
  # Plot 1: t1 and T
  png(
    filename = paste0("outputs/plots/", parameter_name, "_t1_T.png"),
    width = 800,
    height = 600
  )
  
  matplot(
    x,
    data[, c("t1", "T")],
    type = "b",
    pch = 19,
    lty = 1,
    xlab = parameter_name,
    ylab = "Time",
    main = paste("Effect of", parameter_name, "on t1 and T")
  )
  
  legend(
    "topright",
    legend = c("t1", "T"),
    lty = 1,
    pch = 19,
    bty = "n"
  )
  
  dev.off()
  
  # Plot 2: GC(t1, T) and Q
  png(
    filename = paste0("outputs/plots/", parameter_name, "_GC_Q.png"),
    width = 800,
    height = 600
  )
  
  matplot(
    x,
    data[, c("GC_t1_T", "Q")],
    type = "b",
    pch = 19,
    lty = 1,
    xlab = parameter_name,
    ylab = "Value",
    main = paste("Effect of", parameter_name, "on GC(t1,T) and Q")
  )
  
  legend(
    "topright",
    legend = c("GC(t1,T)", "Q"),
    lty = 1,
    pch = 19,
    bty = "n"
  )
  
  dev.off()
}

# ------------------------------------------------------------
# 5. Create plots
# ------------------------------------------------------------

create_plots(eta_data, "eta")
create_plots(beta_data, "beta")
create_plots(gamma_data, "gamma")
create_plots(lambda_data, "lambda")
create_plots(tm_data, "tm")

# ------------------------------------------------------------
# 6. Confirmation message
# ------------------------------------------------------------

cat("Sensitivity analysis CSV files saved in outputs/tables/\n")
cat("Sensitivity analysis plots saved in outputs/plots/\n")
cat("Script completed successfully.\n")
