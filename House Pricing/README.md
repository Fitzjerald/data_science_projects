# Project: Estimating House Prices in King County Using Linear Models

## Objective
The main goal of this project is to analyze the relationship between house features and their prices and to develop predictive models for house prices in King County, Seattle, USA. Additionally, we aim to compare different models and improve prediction accuracy by introducing transformations and interactions between variables.

## Data Description
The dataset contains house sale records from May 2014 to May 2015 in King County, Seattle, USA. The key features used in this analysis are:
- `price`: House sale price (dependent variable)
- `bedrooms`: Number of bedrooms
- `bathrooms`: Number of bathrooms per bedroom
- `sqft_living`: Square footage of the house
- `floors`: Total number of floors
- `view`: Whether the house has been viewed (binary: 1 for viewed, 0 otherwise)
- `condition`: Condition of the house (1 to 5 scale)
- `grade`: Quality of the house (1 to 13 scale)
- `yr_built`: Year the house was built

## Data Preprocessing and Exploration

### 1. Data Selection and Formatting
- Selected the relevant variables from the dataset.
- Converted the `view` column into a binary format.
- Modified the `bathrooms` variable to represent bathrooms per bedroom.
- Filtered out rows where houses had 0 bedrooms.

### 2. Exploratory Data Analysis (EDA)
- Conducted a quick review of the dataset structure and variable types.
- Identified some anomalies (e.g., houses with 0 bedrooms) which were removed to avoid issues in modeling.
- Visualized the distribution of house prices using boxplots and histograms, revealing the presence of outliers.

### 3. Dealing with Skewness in the Response Variable
- The `price` data was heavily skewed, with many large outliers.
- Applied a **log transformation** (`log(price)`) to normalize the distribution.
- Compared QQ-plots and histograms of the raw `price` and its logarithmic transformation. The log-transformed price was much closer to a normal distribution.

## Linear Modeling

### 4. Fitting the First Linear Model
- Developed a linear model with `price` as the dependent variable using the following independent variables: bedrooms, bathrooms, sqft_living, floors, view, condition, grade, and yr_built.
- Results:
  - All variables were significant.
  - Some relationships were counterintuitive, e.g., newer houses and houses with more bedrooms appeared to have lower prices.
  - R² = 0.63, meaning the model explained 63% of the variance in house prices.

### 5. Fitting the Second Model with `log(price)`
- To address the non-normality of the residuals in the first model, we refitted the model using `log(price)` as the response variable.
- Results:
  - The relationships between covariates and house prices were more plausible. For example, more bedrooms now led to higher prices.
  - R² increased to 0.64, indicating a better fit than the first model.

### 6. Visualizing Covariate Effects
- Plotted covariates (e.g., bedrooms, bathrooms, sqft_living, etc.) against `log(price)` to visually interpret their impact on house prices.
- Most covariates showed reasonable relationships with house prices, though some (e.g., floors, bedrooms) had fewer observations at extreme values, making the interpretation less reliable for those values.

## Model Improvement

### 7. Fitting an Extended Model
- Added **quadratic terms** for `yr_built` and `sqft_living` to capture potential non-linear relationships.
- Both squared terms were highly significant, and the R² value improved slightly.
- Bedrooms became less significant in this extended model compared to the previous ones.

### 8. Model Evaluation and Prediction
- Split the dataset into **training (50%)** and **test (50%)** sets.
- Fitted both the second model (`log(price)`) and the extended model on the training set.
- Predicted house prices on the test set using both models and calculated **Mean Squared Error (MSE)** for both.
- The **extended model with squared terms** produced a lower prediction error, indicating better predictive performance.

### 9. Final Model
- Further extended the model by adding **logarithmic transformations** of `yr_built²` and `sqft_living²`.
- The final model achieved the best fit with an **R² of 0.656** and the lowest prediction error (MSE = 0.09376).

## Key Findings
- **Log transformation** of the response variable improved model fit and interpretability.
- The **square footage of the house** (`sqft_living`) had a strong positive effect on house prices.
- The **year built** variable had a non-linear relationship with house prices, captured by adding squared and logarithmic terms.
- Including **non-linear terms** and **log transformations** in the model improved the prediction accuracy significantly.

## Conclusion
This project demonstrates the importance of handling skewed data in regression modeling, particularly for variables like house prices that often have large outliers. Log-transforming the price and incorporating non-linear terms for covariates led to better predictions and improved model performance. The final model explained approximately **65% of the variance** in house prices, making it a reasonably good fit for this type of real estate data.
