# Sensitivity Analysis Summary

## Purpose

This file summarizes the sensitivity analysis outputs generated from the R script:

`code/sensitivity_analysis_data.R`

The script entered the sensitivity analysis data from the source paper and generated CSV tables and basic plots.

## Source Paper

Shaikh, T. S., & Gite, S. P. (2024).  
Fuzzy Inventory Model under Selling Price Dependent Demand and Variable Deterioration with Fully Backlogged Shortages.  
American Journal of Operations Research, 14, 87–103.  
DOI: https://doi.org/10.4236/ajor.2024.142005

## Parameters Studied

The sensitivity analysis considers the following parameters:

| Parameter | Description |
|---|---|
| eta | Demand scale parameter |
| beta | Selling price sensitivity parameter |
| gamma | Deterioration-related parameter |
| lambda | Weibull deterioration parameter |
| tm | Time at which deterioration starts |

## Generated CSV Tables

The CSV outputs are stored in:

`outputs/tables/`

Files:

- `sensitivity_eta.csv`
- `sensitivity_beta.csv`
- `sensitivity_gamma.csv`
- `sensitivity_lambda.csv`
- `sensitivity_tm.csv`

## Generated Plots

The plot outputs are stored in:

`outputs/plots/`

For each parameter, two plots were generated:

1. Effect on `t1` and `T`
2. Effect on `GC(t1,T)` and `Q`

## Current Status

The repository now contains:

- conceptual model documentation,
- parameter documentation,
- R code for sensitivity analysis,
- generated CSV tables,
- generated plot images.

## Next Planned Work

The next stage is to improve the interpretation of the sensitivity analysis results and connect the numerical changes to the inventory model behaviour.
