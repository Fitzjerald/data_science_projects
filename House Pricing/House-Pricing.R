#Neccessary libraries
library(tidyverse) # to be able to use data visual.tools
library(viridis) #to make plots easier to read
library(ggplot2) # to make plots
library(ggrepel) #ggrepel provides geoms for ggplot2
library(gridExtra) #notably to arrange multiple grid-based plots on a page

# read the data with specified columns
kc.house <- read.csv("kc_house_data.csv")[ ,c('price', 'bedrooms', 'bathrooms',
                                              'sqft_living', 'floors', 'view', 
                                              'condition', 'grade', 'yr_built')] 
head(kc.house,2) #quick look at the dataset with 2 rows

#we convert column values into boolean type,
#if we have views more than 0, so it will take true value
#but the true value we will write in num format
kc.house <- kc.house %>% mutate(view = as.numeric(view > 0))

#change the bathrooms column through ratio
kc.house <- kc.house %>% mutate(bathrooms = as.numeric(bathrooms/bedrooms))

#quick review of variable types in df
filter(kc.house, bedrooms == 0)

kc.house <- kc.house %>% filter(bedrooms != 0)#delete rows without bedrooms
str(kc.house)#quick review on the dataset

#Estimate lin model with the response variable price
mod <- lm(price ~ bedrooms + bathrooms + sqft_living + floors + view 
          + condition + grade + yr_built, data = kc.house)
summary(mod)

qqnorm(mod$residuals, main = "residuals QQ plot")
qqline(mod$residuals, col = "yellow")

#plotting the distribution of price
ggplot(kc.house, aes(y = price)) +
  geom_boxplot() +
  theme(axis.text.x=element_blank(), axis.ticks.x = element_blank()) +
  labs(title = "price boxplot")

#generating new variable log(price)
kc.house <- kc.house %>% mutate(lprice = log(price))
str(kc.house) # quick review

#qqplot of price
q.price <- ggplot(kc.house, aes(sample=price)) +
  geom_qq()+
  geom_qq_line(col = "blue")+
  labs(title = "price")

#qqplot of log(price)
q.lprice <- ggplot(kc.house, aes(sample = lprice))+
  geom_qq()+
  geom_qq_line(col = "red")+
  labs(title = "log(price)" )

#plots side by side
grid.arrange(q.price, q.lprice, ncol = 2)

#histogram of price
hist.price <- ggplot(kc.house, aes(x = price)) + 
  geom_histogram(color="darkblue", fill="lightblue") +
  geom_vline(aes(xintercept=mean(price)), linetype="dashed")+
  labs(x = "price",y = "Count")

#histogram of log(price)
hist.lprice <- ggplot(kc.house, aes(x = lprice)) +
  geom_histogram(color="darkred", fill="red") +
  geom_vline(aes(xintercept=mean(lprice)), linetype="dashed") +
  labs(x = "log(price)",y = "Count")

#plots side by side
grid.arrange(hist.price, hist.lprice, ncol = 2)

#estimating new model using log(price) as dependent variable
lmod <- lm(lprice  ~ bedrooms + bathrooms + sqft_living + floors + view 
           + condition + grade + yr_built, data = kc.house)
summary(lmod)

#qqplot of residuals
qqnorm(lmod$residuals)
qqline(lmod$residuals, col = "green")

ggplot(kc.house, aes(x = as.factor(bedrooms), y = lprice)) +
  geom_boxplot() +
  xlab("bedrooms")

ggplot(kc.house, aes(x = bathrooms, y = lprice)) +
  geom_point(alpha = 1/3) +
  geom_smooth(method = "lm")

ggplot(kc.house, aes(x = sqft_living, y = lprice)) +
  geom_point(alpha = 1/3) +
  geom_smooth(method = "lm")

ggplot(kc.house, aes(x = as.factor(floors), y = lprice)) +
  geom_boxplot() +
  xlab("floors")

ggplot(kc.house, aes(x = as.factor(view), y = lprice)) +
  geom_boxplot() +
  xlab("view")

ggplot(kc.house, aes(x = as.factor(condition), y = lprice)) +
  geom_boxplot() +
  xlab("condition")

ggplot(kc.house, aes(x = as.factor(grade), y = lprice)) +
  geom_boxplot() +
  xlab("grade")

ggplot(kc.house, aes(x = yr_built, y = lprice)) +
  geom_point(alpha = 1/3) +
  geom_smooth(method = "lm")

#adding new variables to the dataframe
#I add yr and sqvrt to df too,they will help to extend the 3rd model
#Further explanition of this choice will be below
#Where we will extend the third model
kc.house <- kc.house %>% mutate(yr_built2 = yr_built^2, 
                                sqft_living2 = sqft_living^2, 
                                sqvrt = log(sqft_living^2), 
                                yr = log(yr_built^2))

#calculating new model
lmod2 <- lm(lprice ~ bedrooms + bathrooms + sqft_living + floors 
            + view + condition + grade + yr_built 
            + yr_built2 + sqft_living2, data = kc.house)
summary(lmod2)

"lmod: r_squared"
summary(lmod)$adj.r.squared

"lmod2: r_squared"
summary(lmod2)$adj.r.squared

#randomly selecting the 10800 indices from the dataset to be part of the training dataset
train_ind <- sample(seq_len(nrow(kc.house)), size = 0.5*nrow(kc.house))

train <- kc.house[train_ind, ]#fill the train set
test <- kc.house[-train_ind, ]#fill the test set

#training model from b)
train_lmod <- lm(lprice ~ bedrooms + bathrooms + sqft_living 
                 + floors + view + condition + grade 
                 + yr_built, data = train)

#predicting model from b)
pred_lmod <- predict(train_lmod, test) #model from b)
pred_lmod[1:10]#quick review

#training model from c)
train_lmod2 <- lm(lprice ~ bedrooms + bathrooms + sqft_living 
                  + floors + view + condition + grade 
                  + yr_built + yr_built2 
                  + sqft_living2, data = train)

#predicting model from c)
pred_lmod2 <- predict(train_lmod2, test)
pred_lmod2[1:10]#quick review

#MSE of the model from b)
mean((test$lprice - pred_lmod)^2)

#MSE of the model from c)
mean((test$lprice - pred_lmod2)^2)

#we look at the new model
lmod3 <- lm(lprice ~ bedrooms + bathrooms  + yr_built
            + floors + view + grade + condition
            + yr_built2 + sqft_living2 + sqft_living +
              yr+sqvrt, data = kc.house)
summary(lmod3)

train_lmod3 <- lm(lprice ~ bedrooms + bathrooms + yr_built
                  + floors + view + grade + condition
                  + yr_built2 + sqft_living2 + sqft_living +
                    yr+sqvrt, data = train)

pred_lmod3 <- predict(train_lmod3, test)

#MSE of the model
mean((test$lprice - pred_lmod3)^2)