# Crisp Model Results Summary

## Purpose

This file summarizes the R implementation of the crisp inventory model cost function.

The R script used is:

`code/crisp_model_cost_function.R`

## Source

The implementation is based on:

- the published crisp model formulation in Shaikh and Gite (2024)
- the MATLAB code used for the crisp model computation

## Important Computational Note

The published crisp numerical example reports `tm = 1.25`, but the MATLAB code uses `tm = 0.45`.

The value `tm = 0.45` is used in the R implementation because it is consistent with the model timeline:

`tm < t1 < T`

## Reported vs Computed Results

The comparison is stored in:

`outputs/tables/crisp_model_reported_vs_computed.csv`

The R implementation reproduces the reported crisp model results closely.

| Quantity | Reported | Computed | Difference |
|---|---:|---:|---:|
| t1 | 0.9680 | 0.96798 | -0.000019 |
| T | 1.7437 | 1.74370 | -0.000002 |
| Total cost | 245.1534 | 245.1533 | -0.000108 |
| q1 | 52.2783 | 52.2772 | -0.001102 |
| q2 | 16.1996 | 16.2004 | 0.000764 |
| Q | 68.4779 | 68.4776 | -0.000338 |

## Conclusion

The crisp model cost function has been successfully implemented in R.

The computed values are very close to the reported paper values, with only minor numerical differences due to computational approximation.
