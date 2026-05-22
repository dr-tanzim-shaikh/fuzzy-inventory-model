# Parameter Table

## Crisp Model Parameters

| Parameter | Meaning | Value |
|---|---|---:|
| η | Demand coefficient | 1500 |
| β | Demand constant | 2.4 |
| s | Selling price per unit | 4 |
| γ | Weibull scale parameter | 0.02 |
| λ | Weibull shape parameter | 4 |
| tm | Time before deterioration begins | 1.25 |
| CPC | Purchase cost per unit | 3 |
| CDC | Deterioration cost per unit | 5 |
| CHC | Holding cost per unit | 0.2 |
| COC | Ordering cost per order | 200 |
| CSC | Shortage cost per unit | 7 |

**Data note:** In the source paper’s crisp numerical example, `CPC` appears twice. The second value is interpreted here as shortage cost `C_SC` based on the notation used in the model.

## Crisp Model Reported Results

| Output | Value |
|---|---:|
| t1 | 0.9680 |
| T | 1.7437 |
| C(t1, T) | 245.1534 |
| q1 | 52.2783 |
| q2 | 16.1996 |
| Q | 68.4779 |

## Fuzzy Model Parameters

| Parameter | Fuzzy values |
|---|---|
| CHC | (0.05, 0.10, 0.15, 0.25, 0.30, 0.35) |
| CDC | (2, 3, 4, 6, 7, 8) |
| COC | (50, 100, 150, 250, 300, 350) |
| CSC | (4, 5, 6, 8, 9, 10) |
| CPC | (1.5, 2.0, 2.5, 3.5, 4.0, 4.5) |
| β | (2.1, 2.2, 2.3, 2.5, 2.6, 2.7) |
| η | (1200, 1300, 1400, 1500, 1600, 1700, 1800) |

**Data note:** The source paper defines hexagonal fuzzy numbers using six values. However, the numerical example reports η̃ with seven values. This repository records η̃ exactly as reported in the paper and flags it for careful handling in later computational implementation.

## Fuzzy Model Reported Results

| Output | Value |
|---|---:|
| t1 | 0.9854 |
| T | 1.7527 |
| GC(t1, T) | 239.4447 |
| q1 | 53.2897 |
| q2 | 15.8680 |
| Q | 69.1577 |

## Important Data Notes

1. The source paper describes the fuzzy model using hexagonal fuzzy numbers.
2. Most fuzzy parameters are given with six values.
3. The demand coefficient η is reported with seven values in the numerical example.
4. The crisp numerical example lists CPC twice; the second value appears to correspond to shortage cost CSC based on the notation.
5. These issues will be documented and handled carefully in the computational implementation.
