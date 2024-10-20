# Analysis of Currency Exchange Rates

## Scope
This project aimed to analyze currency exchange rate volatility over time using Python and implement time series forecasting techniques to predict future volatility based on historical patterns.

## Data
The dataset used, updated daily, contains foreign exchange rates and can be accessed at [Kaggle](https://www.kaggle.com/datasets/ruchi798/currency-exchange-rates) (version as of July 7, 2023). 

## Tools
Python with libraries:
- pandas
- numpy
- seaborn
- matplotlib
- statsmodels
- sklearn

## Summary
### Maximum Change Observation
The currency with the maximum daily percentage change was the **Malaysian Ringgit (MYR)** with a change of **492372.45%** on **2022-09-22**.

### Identifying High Volatility Periods
Rolling standard deviation was calculated for each currency to identify periods of high volatility. A line plot of volatility over time for the top 10 currencies was created.

### Correlation Analysis
Correlation analysis using Pearson's coefficient showed that some currencies (e.g., BYR, IRR, STD, VND, ZMK) had a correlation of 1, indicating identical price movements, likely due to shared structural elements.

### Forecasting
Time series forecasting was conducted using the ARIMA model:

- RMSE values indicated that currencies like **IRR, SLL, and VND** had low RMSE, suggesting accurate forecasts. In contrast, currencies like **LBP** and **GNF** had higher RMSE values, indicating poorer forecasting performance.


