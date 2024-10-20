# Comparison of global wheat prices with wheat flour Producer Price Index

## Scope

The objective of this project is to investigate the relationship between the Wheat Flour Producer Price Index and the Global Wheat Prices. We hypothesize that higher global wheat prices lead to a higher producer price index for wheat flour.

## Data Description

The two time series data used in this project are:
1. **Global Price of Wheat (PWHEAMTUSDM)** - Denoted as `X`.
2. **Producer Price Index by Commodity: Processed Foods and Feeds: Wheat Flour (WPU02120301)** - Denoted as `Y`.

The data is sourced from the [Federal Reserve Bank of St. Louis website](https://fred.stlouisfed.org/). The time series are seasonally adjusted and span **31 years**, from the **1st quarter of 1990 to the 4th quarter of 2020**, with a total of **123 quarterly observations**.

## Methods

### Visual Exploration
- Both the original and logarithmic transformations of `X` and `Y` are visualized.
- A linear trend is applied to both variables, but residual plots and autocorrelations show non-stationarity.

### Periodograms and Stationarity
- The periodograms reveal a steep rise at low frequencies, further indicating non-stationarity.
- To achieve stationarity, differencing is applied to both time series.

### Cross-correlation and Pre-whitening
- The cross-correlations between the differenced series are examined. Pre-whitening with a 2nd order ARMA model is performed to remove autocorrelations.
- Empirical squared coherence is computed for two different smoothings, showing a linear relationship between the series at all frequencies.

### Cointegration Analysis
- A unit-root test is performed to test for stationarity, followed by a cointegration test to examine the long-term relationship between the two series.

## Tools and Libraries
**R** with Packages:
- tseries
- urca

## Summary

- The original time series of wheat prices and the wheat flour price index show similar patterns, confirming the hypothesis of a relationship.
- After differencing, the time series become stationary, and further analysis reveals significant cross-correlations at certain lags.
- Cointegration analysis indicates a long-term relationship between the two series, supporting the claim that global wheat prices affect the producer price index of wheat flour.

### Key Figures
- **Figure 1**: Time series of the original and logarithmized data for both variables.
- **Figure 2**: Linear trend analysis and residual plots showing non-stationarity.
- **Figure 3**: Periodograms indicating non-stationarity.
- **Figure 4**: Differenced series showing stationarity and periodograms for differenced data.
- **Figure 5**: Cross-correlation analysis of differenced series.
- **Figure 6**: Pre-whitening analysis.
- **Figure 7**: Autocorrelation and cross-correlation of residuals.
- **Figure 8**: Empirical squared coherence and phase spectrum.
- **Figure 9**: Parametric estimation using AR models.

## Conclusion

The analysis shows that while both the Wheat Flour Producer Price Index and Global Wheat Prices are non-stationary in their raw form, they exhibit a strong cointegrated relationship. This confirms the hypothesis that global wheat prices significantly influence the wheat flour producer price index over time.

