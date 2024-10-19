# Hypothesis Testing on US 2016 Presidential Votes
This project focuses on analyzing the relationship between diversity indices and voting patterns in the 2016 US presidential election across 159 counties in Georgia. The goal is to compare diversity indices between counties that voted for Clinton versus Trump and test whether the diversity index has a mean of 50.
## Data Description:
The dataset contains variables such as county names, diversity index, percentage of votes for Clinton, and percentage of votes for Trump. A new categorical variable vote was created to indicate which candidate won in each county.

## Technologies Used:
R with Libraries:
- tidyverse
- ggplot2
- ggrepel
- foreign

## Summary:
Using QQ-plots, Welch's t-test, and the Wilcoxon test, the project explores differences in diversity indices between Clinton and Trump voters. Results show significant differences between the two groups. Additionally, a hypothesis test was conducted to determine if the diversity index has a mean of 50, leading to the conclusion that non-normality affects the accuracy of t-tests, while the Wilcoxon test provides more reliable results.
