# White Wine Quality Analysis
This project focuses on analyzing and visualizing the relationship between volatile acidity, residual sugar, pH, and wine quality in a white wine dataset. The dataset is filtered to only include relevant variables, and a new boolean variable (good) is introduced to classify wines as good (quality > 5) or bad.

## Data Description:
The dataset includes variables related to wine quality, such as volatile acidity, residual sugar, pH level, and quality scores (0-10). A new binary variable, good, was created to distinguish high-quality wines from lower-quality ones.

## Technologies Used:
R with libraries: 
- tidyverse
- ggplot2
- ggrepel
- foreign

## Summary:
Through histograms, boxplots, QQ-plots, and summary statistics, the project analyzes differences in volatile acidity and residual sugar between good and bad wines. While residual sugar shows notable outliers in good wines, volatile acidity remains similar between the two groups. Overall, the analysis highlights slight differences in wine quality based on these variables.
