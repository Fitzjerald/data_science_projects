library(tidyverse) # to be able to use data visual.tools
library(foreign) #reading data in diff.formats
library(ggplot2) # for plots
library(ggrepel) #ggrepel provides geoms for ggplot2 

#the procedure for df selection and modification as in 2 ex.
vot <- read.csv("Votes.csv")
votes <- vot[,c("County", "Diversity.Index", "Percent.Clinton", "Percent.Trump")] %>%
  mutate(vote = ifelse(Percent.Clinton > Percent.Trump, "Clinton", "Trump"))

#For Clinton
ggplot(filter(votes, vote == "Clinton"), aes(sample = Diversity.Index)) +
  stat_qq() +
  stat_qq_line() +
  labs(title = "Clinton Voters")

#For Trump
ggplot(filter(votes, vote == "Trump"), aes(sample = Diversity.Index)) +
  stat_qq() +
  stat_qq_line() +
  labs(title = "Trump Voters")

clinton <- filter(votes, vote == "Clinton")
trump <- filter(votes, vote == "Trump")
var.test(clinton$Diversity.Index, trump$Diversity.Index)

t.test(clinton$Diversity.Index, trump$Diversity.Index, var.equal = FALSE)
wilcox.test(clinton$Diversity.Index, trump$Diversity.Index)

ggplot(votes, aes(sample = Diversity.Index)) +
  stat_qq() +
  stat_qq_line() +
  labs(title = "Diversity Index")

t.test(votes$Diversity.Index, mu = 50)
wilcox.test(votes$Diversity.Index, mu = 50)