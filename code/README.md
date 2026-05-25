# Code Folder

This folder contains R scripts used for the fuzzy inventory model project.

## Files

- `sensitivity_analysis_data.R` — enters sensitivity-analysis data, saves CSV tables, and generates PNG plots
- `crisp_model_cost_function.R` — implements the crisp model cost function and compares computed results with the reported paper values

## How to Run

From the main repository folder, run:

```r
source("code/sensitivity_analysis_data.R")
source("code/crisp_model_cost_function.R")
```

## Outputs Generated

Running `sensitivity_analysis_data.R` creates:

- sensitivity-analysis CSV tables in `outputs/tables/`
- sensitivity-analysis PNG plots in `outputs/plots/`

Running `crisp_model_cost_function.R` creates:

- `crisp_model_newton_iterations.csv`
- `crisp_model_computed_result.csv`
- `crisp_model_reported_vs_computed.csv`
