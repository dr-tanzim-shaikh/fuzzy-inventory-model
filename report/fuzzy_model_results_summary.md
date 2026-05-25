# Fuzzy Model Results Summary

## Purpose

This file summarizes the R implementation of the fuzzy inventory model cost function.

The R script used is:

`code/fuzzy_model_cost_function.R`

## Source

The implementation is based on:

- the published fuzzy model formulation in Shaikh and Gite (2024)
- the MATLAB code used for fuzzy model computation

## Important Computational Note

The published paper reports the fuzzy demand coefficient as:

`eta = (1200, 1300, 1400, 1500, 1600, 1700, 1800)`

However, the MATLAB code uses six values for the hexagonal fuzzy computation:

`eta = (1200, 1300, 1400, 1600, 1700, 1800)`

The R implementation follows the MATLAB computational structure.

## Reported vs Computed Results

The comparison is stored in:

`outputs/tables/fuzzy_model_reported_vs_computed.csv`

| Quantity | Reported | Computed | Difference |
|---|---:|---:|---:|
| t1 | 0.9854 | 0.98538 | -0.000017 |
| T | 1.7527 | 1.75267 | -0.000031 |
| Fuzzy total cost | 239.4447 | 239.44596 | 0.001258 |

## Conclusion

The fuzzy model cost function has been successfully implemented in R.

The computed values closely reproduce the reported fuzzy model values, with only a very small numerical difference in the fuzzy total cost.
