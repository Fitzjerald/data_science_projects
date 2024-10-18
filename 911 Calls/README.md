# 911 Calls project
For this project i've analyzed some 911 call data from [Kaggle](https://www.kaggle.com/datasets/mchirico/montcoalert) for period from 2015-2016. The data contains the following fields:

- **lat :** String variable, Latitude
- **lng: ** String variable, Longitude
- **desc:** String variable, Description of the Emergency Call
- **zip:** String variable, Zipcode
- **title:** String variable, Title
- **timeStamp:** String variable, YYYY-MM-DD HH:MM:SS
- **twp:** String variable, Township
- **addr:** String variable, Address
- **e:** String variable, Dummy variable (always 1)

There are some basic and advanced questions for us:

- What are the top 5 townships for 911 calls?
- What are the top 5 zipcodes for 911 calls?
- How many unique title codes are there?
- What is the most common Reason for a 911 call?
- What is the relationship between date (days of week, months, hours) and number of calls

Technologies used:
- numpy, pandas for working with dataframes
- matplotlib.pyplot, seaborn for data visualization
