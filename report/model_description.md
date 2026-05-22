# Model Description

## Project Title

Computational Implementation and Sensitivity Analysis of a Fuzzy Inventory Model under Selling Price Dependent Demand and Variable Deterioration

## Source Paper

This project is based on the published paper:

Shaikh, T. S., & Gite, S. P. (2024). *Fuzzy Inventory Model under Selling Price Dependent Demand and Variable Deterioration with Fully Backlogged Shortages*. American Journal of Operations Research, 14, 87–103. https://doi.org/10.4236/ajor.2024.142005

## Background

Inventory systems involving deteriorating items are important in sectors such as food, medicine, agricultural products, and other perishable goods. In many real-world systems, deterioration does not begin immediately. Items may retain their quality for a fixed period and then begin to deteriorate.

This project considers an inventory model where demand depends on selling price, deterioration begins after a specified time, and shortages are allowed with full backlogging.

## Problem Studied

The model studies how to determine the optimal inventory cycle and ordering quantity when:

- demand depends on selling price,
- deterioration follows a two-parameter Weibull distribution,
- shortages are allowed,
- shortages are fully backlogged,
- selected parameters are treated as fuzzy numbers,
- total inventory cost is minimized.

## Main Model Features

- Selling-price-dependent demand
- Non-instantaneous deterioration
- Two-parameter Weibull deterioration rate
- Fully backlogged shortages
- Crisp and fuzzy model comparison
- Hexagonal fuzzy numbers
- Graded Mean Integration Representation Method
- Sensitivity analysis of key parameters

## Demand Function

The demand rate is assumed to depend on selling price:

D(s) = η / s^β

where:

- η = demand coefficient
- β = demand constant
- s = selling price per unit

## Deterioration Function

The deterioration rate follows a two-parameter Weibull distribution:

θ(t) = γλt^(λ−1)

where:

- γ = scale parameter
- λ = shape parameter

## Inventory Intervals

The inventory cycle is divided into three intervals:

1. [0, tm] — no deterioration period
2. [tm, t1] — demand and deterioration period
3. [t1, T] — shortage period with full backlogging

## Decision Variables

- t1: time at which inventory level becomes zero
- T: total cycle length

## Output Quantities

- q1: initial inventory quantity
- q2: backordered quantity
- Q: total ordering quantity
- C(t1, T): total inventory cost in the crisp model
- GC(t1, T): defuzzified total cost in the fuzzy model

## Numerical Work Planned

This repository will implement the numerical example and sensitivity analysis from the source paper.

Planned computational tasks:

1. Create parameter tables for the crisp and fuzzy models.
2. Implement the demand function.
3. Implement the deterioration function.
4. Reproduce the crisp numerical example.
5. Reproduce the fuzzy numerical example.
6. Recreate the sensitivity analysis tables.
7. Generate plots for changes in:
   - η
   - β
   - γ
   - λ
   - tm
8. Prepare a short technical report explaining the numerical results.

## Notes

This repository is intended as a reproducible computational companion to the published model. It does not replace the original paper. The original paper should be cited when using or referring to this work.
