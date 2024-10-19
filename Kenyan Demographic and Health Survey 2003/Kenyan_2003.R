library(tidyverse) # to be able to use data visual.tools
library(foreign) #reading data in diff.formats
library(ggrepel) #ggrepel provides geoms for ggplot2 

childrenfinal <- read.dta("childrenfinal.dta") # read the data
head(childrenfinal,2) #quick look at the dataset with 2 rows
# names() allows us to show the column names from our dataset
# substring() allows us to get first letters from each column name
s <- substring(names(childrenfinal),1,1) # show dataset columns with only 1st letters
s

# define a list with letters, where columns from dataset must be dropped
dropped <- c("s","v","m")

#we modify our df without columns
#which names start with s,v and m
childrenfinal <- childrenfinal[, !(s %in% dropped)]
# The function above from the right side allows us
# To select us columns without s,v and m in the beginnig of names

head(childrenfinal)#quick look at the modifed df
substring(names(childrenfinal),1, 1)#to be sure that we dropped necessary columns
#define a list with names, which want to have in our df
nec.vars <- c("hypage","ruralfacto","breastfeeding", "birthweight", 
              "yearsofedu", "female", "zstunt", "zweight", "zwast", "adm2")

#we make same procedure as above
#but without ! in the right side
#it means that we leave only necessary columns in the df
childrenfinal <- childrenfinal[, (names(childrenfinal) %in% nec.vars)]
head(childrenfinal,2)
str(childrenfinal)#quick review of variable types in df
#one approach it to index with the $ sign and the as.factor function

#convert gender column into factor 
childrenfinal$female <- as.factor(childrenfinal$female)

#convert territory column into factor 
childrenfinal$ruralfacto <- as.factor(childrenfinal$ruralfacto)

#convert provinces column into factor 
childrenfinal$adm2 <- as.factor(childrenfinal$adm2)

plt <- ggplot(data = childrenfinal)
plt + geom_point(aes(x = hypage, y = zstunt))+
  geom_smooth(aes(x = hypage, y = zstunt ),se = F)+
  labs(x = "Hypothetical age (Months)",y = "Z-score")#add labels
#Plot male and female smooth lines
#with filter(), where female == 0 is for male data
ggplot() +
  geom_smooth(data = filter(childrenfinal, female == 0),
              aes(x = hypage, y = zstunt, colour = "male" ),se = F) +
  geom_smooth(data = filter(childrenfinal, female == 1), 
              aes(x = hypage, y = zstunt, colour = "female"), se = F)+
  labs(x = "Hypothetical age (Months)",y = "Z-score")+
  scale_colour_manual(name="gender", values=c("red","darkblue"))#set legend
#Plot urban and rural smooth lines
#with filter(), where ruralfacto == 1 is the data for rural children
ggplot() +
  geom_smooth(data = filter(childrenfinal, ruralfacto == 0),
              aes(x = hypage, y = zstunt, colour = "urban" ),se = F) +
  geom_smooth(data = filter(childrenfinal, ruralfacto == 1), 
              aes(x = hypage, y = zstunt, colour = "rural"), se = F)+
  labs(x = "Hypothetical age (Months)",y = "Z-score")+
  scale_colour_manual(name="living territory", values=c("green","yellow"))