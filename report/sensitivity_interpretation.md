# Sensitivity Analysis Interpretation

## Purpose

This file gives a short interpretation of the sensitivity-analysis results generated from the source paper data.

The aim is not only to display tables and plots, but also to explain what the numerical changes mean for the inventory model.

## Interpretation by Parameter

### 1. Demand scale parameter eta

As eta increases, the total order quantity Q increases. This is expected because a higher demand scale increases the required inventory level.

The total cost GC(t1,T) also increases with eta, indicating that higher demand leads to higher overall inventory-system cost.

### 2. Selling price sensitivity parameter beta

As beta increases, the total order quantity Q decreases. This suggests that stronger price sensitivity reduces demand and therefore reduces the required order quantity.

The total cost GC(t1,T) also decreases as beta increases.

### 3. Deterioration parameter gamma

As gamma increases, the total order quantity Q slightly decreases, while GC(t1,T) slightly increases.

This indicates that stronger deterioration increases system cost even when order quantity is adjusted downward.

### 4. Weibull deterioration parameter lambda

As lambda increases, Q increases slightly, while GC(t1,T) decreases slightly.

The effect is moderate compared with eta and beta.

### 5. Time at which deterioration starts tm

As tm increases, deterioration begins later. The total cost GC(t1,T) decreases slightly, while Q increases slightly.

This is practically reasonable because delaying deterioration improves the usable inventory period.

## Overall Observation

The most visible effects are associated with eta and beta.

The demand-related parameters have stronger influence on order quantity and total cost than the deterioration-related parameters in the reported sensitivity analysis.

## Current Limitation

This file interprets the reported sensitivity-analysis data from the paper. The next step is to implement the crisp cost function and reproduce the numerical example computationally.
