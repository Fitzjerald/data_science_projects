# Data analysis stock prices
In this data project i focused on exploratory data analysis of stock prices. This project is not meant to be a robust financial analysis or be taken as financial advice. I focused on bank stocks and see how they progressed throughout the financial crisis all the way to early 2016.

I needed to get data using pandas datareader. I got stock information for the following banks:

- Bank of America
- CitiGroup
- Goldman Sachs
- JPMorgan Chase
- Morgan Stanley
- Wells Fargo

There are some basic and advanced questions for us:

- What is the max Close price for each bank's stock throughout the time period?
- What dates each bank stock had the best and worst single day returns?
- Which stock could we classify as the riskiest over the entire time period?
- Which would we classify as the riskiest for the year 2015?
- Where i used the data from "yahoo finance":

Technologies used:
- pandas_datareader for up to date remote data access for pandas
- pandas, numpy for working with dataframes
- datetime for manipulating dates and times
- seaborn, matplotlib.pyplot for data visualization
