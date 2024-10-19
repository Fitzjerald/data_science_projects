library(tidyverse) # to be able to use data visual.tools
library(foreign) #reading data in diff.formats
library(ggplot2) # plot
library(ggrepel) #ggrepel provides geoms for ggplot2 

winequality <- read.csv("winequality-white.csv", sep = ";")

#define new df with necessary variables
winequality.white <- winequality[,c("volatile.acidity", "residual.sugar", "pH", "quality")] %>%
  mutate(good = (quality > 5))#add new column with properties

#plot histograms
ggplot(winequality.white, aes(x = residual.sugar, alpha = good)) +
  geom_histogram(binwidth = 10, color = "black")

#define the matrix for summary statistics
t <- matrix(nrow = 6, ncol = 2)#number of sum.stat elem.

for (i in 1:2) {
  d <- filter(winequality.white, good == (i-1))$residual.sugar
  t[1, i] <- mean(d)
  t[2, i] <- median(d)
  t[3, i] <- sd(d)
  t[4, i] <- IQR(d)
  t[5, i] <- min(d)
  t[6, i] <- max(d)
}

rownames(t) <- c("mean", "median", "sd", "IQR", "min", "max")
colnames(t) <- c("bad", "good")

t

ggplot(winequality.white, aes(x = good, y = residual.sugar, color = good, fill = good)) +
  geom_boxplot(alpha = 0.5)

ggplot(winequality.white, aes(x = good, y = volatile.acidity, color = good, fill = good)) +
  geom_boxplot(alpha = 0.5)

ggplot(winequality.white, aes(x = volatile.acidity, alpha = good)) +
  geom_histogram(binwidth = 0.3, color = "black")

ggplot(filter(winequality.white, good == 0), aes(sample = volatile.acidity)) +
  stat_qq() +
  stat_qq_line() +
  labs(title = "Bad Wines")

ggplot(filter(winequality.white, good == 1), aes(sample = volatile.acidity)) +
  stat_qq() +
  stat_qq_line() +
  labs(title = "Good Wines")

z <- matrix(nrow = 6, ncol = 2)

for (i in 1:2) {
  dz <- filter(winequality.white, good == (i-1))$volatile.acidity
  z[1, i] <- mean(dz)
  z[2, i] <- median(dz)
  z[3, i] <- sd(dz)
  z[4, i] <- IQR(dz)
  z[5, i] <- min(dz)
  z[6, i] <- max(dz)
}

rownames(z) <- c("mean", "median", "sd", "IQR", "min", "max")
colnames(z) <- c("bad", "good")

z

x1 <- filter(winequality.white, good == 0)
x2 <- filter(winequality.white, good == 1)

"Empirical Cumulative Distribution Function"
plot(ecdf(x1$volatile.acidity), main = "Bad Wines", pch = 20)
plot(ecdf(x2$volatile.acidity), main = "Good Wines", pch = 20)