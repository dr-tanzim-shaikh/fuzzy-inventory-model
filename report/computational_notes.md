# Computational Notes

## Purpose

This file records technical decisions made while converting the published inventory model and MATLAB code into reproducible R code.

## Source Files Used

- Published paper: Shaikh and Gite (2024), American Journal of Operations Research
- MATLAB code used for crisp and fuzzy model computation

## Important Discrepancy: Crisp Model `tm`

In the published crisp numerical example, the value of `tm` is reported as:

`tm = 1.25`

The reported optimal value is:

`t1 = 0.9680`

This creates a timeline inconsistency because the model formulation assumes the intervals:

- `[0, tm]`
- `[tm, t1]`
- `[t1, T]`

Therefore, the model structure requires:

`tm < t1 < T`

However, if `tm = 1.25` and `t1 = 0.9680`, then `tm > t1`, which contradicts the model formulation.

The MATLAB code used for the crisp model instead uses:

`tm = 0.45`

This value is consistent with the model timeline because:

`0.45 < 0.9680 < 1.7437`

## Computational Decision

For the R implementation of the crisp model, the MATLAB-code value will be used:

`tm = 0.45`

The published value `tm = 1.25` will be treated as a likely typographical or documentation error in the crisp numerical example.

## Next Computational Task

Implement the crisp cost function in R and compare the computed result with the reported optimal values.
