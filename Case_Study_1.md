# Case Study 1
Dan Freeman  
April 10, 2017  

# Introduction

The main purpose of this analysis is to show how the distribution of GDP level changes with respect to a country's income classification (Low Income, Lower Middle Income, 
Upper Middle Income, High Income:nonOECD and High Income:OECD).  Two data sources at the national level from the World Bank were used in this analysis: GDP rankings
(available at http://data.worldbank.org/data-catalog/GDP-ranking-table) and Education Statistics (available at http://data.worldbank.org/data-catalog/ed-stats).  These data 
sets were first imported into R and then cleaned and merged before analysis could begin.  Using R to provide summary statistics, a density plot and table, our hope is to 
illustrate the relatonship between GDP and income group and to spot any relevant trends in the data.
 
# Packages Needed

```r
#install.packages("plyr")
#install.packages("ggplot2")
library(plyr)
library(ggplot2)
```

# REMEMBER TO SET YOUR WORKING DIRECTORY!

```r
setwd("C:/Users/Dan Freeman/Documents/Southern Methodist University - MS in Data Science/Spring 2017 Courses/MSDS 6306 Doing Data Science/Case Study 1")
```

# Education and GDP Data Imports


```r
Education <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", header=TRUE, sep=",")
GDP <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", skip=3, header=TRUE, sep=",")
```

# GDP Data Cleaning

```r
GDP_Clean <- (GDP$X.1 <- GDP$X.2 <- GDP$X.3 <- GDP$X.4 <- GDP$X.5 <- GDP$X.6 <-NULL) #Delete extraneous variables.
GDP <- rename(GDP, c(X="CountryCode", US.dollars.="GDP")) #Rename variables to more meaningful names.
GDP <- subset(GDP, CountryCode!="") #Delete cases whose country code is missing.

GDP$GDP <- as.numeric(gsub(",", "", as.character(GDP$GDP))) #Convert GDP to numeric variable.
```

```
## Warning: NAs introduced by coercion
```

```r
GDP$Ranking <- as.numeric(gsub(",", "", as.character(GDP$Ranking))) #Convert Ranking to numeric variable.
```

# Education and GDP Data Merging by Country Code

```r
Education_GDP <- merge(Education, GDP, by="CountryCode")
```
224 of the Country Codes are found in both the Education and GDP data sets.

# Merged Data Set Sorted in Ascending Order by GDP

```r
Education_GDP <- Education_GDP[order(Education_GDP$GDP),]
```
St. Kitts and Nevis is the 13th country in the Education_GDP data set sorted ascending by GDP.

 

```r
summary(subset(Education_GDP, Education_GDP$Income.Group == "High income: nonOECD")$Ranking)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##   19.00   58.50   94.00   91.91  125.00  161.00      14
```

The average GDP ranking for High income:nonOECD countries is 91.91.


```r
summary(subset(Education_GDP, Education_GDP$Income.Group == "High income: OECD")$Ranking)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    1.00   12.25   24.50   32.97   45.75  122.00
```

The average GDP ranking for High income:OECD countries is 32.97. 

# Density Plot of GDP by Income Group

```r
Education_GDP_Countries_Only <- subset(Education_GDP, Education_GDP$Ranking != "NA") #Creating data frame that only includes specific countries on each row, not aggregate groups
qplot(GDP, data=Education_GDP_Countries_Only, geom="density", fill=Income.Group, alpha=I(.5), 
main="Distribution of GDP by Income Group", xlab="GDP", ylab="Density", xlim = c(0,1000000), ylim = c(0,0.00001))
```

```
## Warning: Removed 15 rows containing non-finite values (stat_density).
```

![](Case_Study_1_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

From the plot above, countries in the Lower Middle Income group are more likely to have a GDP of less than $100 billion than other income groups.  High Income: OECD countries are generally the most likely to have a GDP greater than $125 billion.  However, Lower Middle Income countries are more likely to have a GDP between approximately $850 billion and $900 billion than other income groups.  Also, High Income:nonOECD countries are more likely to have a GDP of less than $100 billion than Upper middle income countries.

# Summary Statistics for GDP by Each of the Five Income Groups.

```r
summary(subset(Education_GDP, Education_GDP$Income.Group == "High income: nonOECD")$GDP)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##    2584   12840   28370  104300  131200  711000      14
```

```r
summary(subset(Education_GDP, Education_GDP$Income.Group == "High income: OECD")$GDP)
```

```
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
##    13580   211100   486500  1484000  1480000 16240000
```

```r
summary(subset(Education_GDP, Education_GDP$Income.Group == "Low income")$GDP)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##     596    3814    7843   14410   17200  116400       3
```

```r
summary(subset(Education_GDP, Education_GDP$Income.Group == "Lower middle income")$GDP)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##      40    2549   24270  256700   81450 8227000       2
```

```r
summary(subset(Education_GDP, Education_GDP$Income.Group == "Upper middle income")$GDP)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##     228    9613   42940  231800  205800 2253000       2
```
Not surprisingly, High Income: OECD countries have the highest median GDP at $486.5 billion while Low Income countries have the lowest median GDP at $7.843 billion.  High Income: OECD countries have a lower median GDP of $28.37 billion than the $42.94 billion median GDP of Upper Middle Income countries.  

# GDP Rankings Cut into Five Separate Quintile Groups in a Variable Called "Ranking_Quintile_Cat"

```r
Education_GDP_Countries_Only$Ranking_Quintile <- cut(Education_GDP_Countries_Only$Ranking, quantile(Education_GDP_Countries_Only$Ranking, c(0,0.2,0.4,0.6,0.8,1)))
Education_GDP_Countries_Only$Ranking_Quintile_Cat[Education_GDP_Countries_Only$Economy == "United States"] <- 1
Education_GDP_Countries_Only$Ranking_Quintile_Cat[Education_GDP_Countries_Only$Ranking_Quintile == "(1,38.6]"] <- 1
Education_GDP_Countries_Only$Ranking_Quintile_Cat[Education_GDP_Countries_Only$Ranking_Quintile == "(38.6,76.2]"] <- 2
Education_GDP_Countries_Only$Ranking_Quintile_Cat[Education_GDP_Countries_Only$Ranking_Quintile == "(76.2,114]"] <- 3
Education_GDP_Countries_Only$Ranking_Quintile_Cat[Education_GDP_Countries_Only$Ranking_Quintile == "(114,152]"] <- 4
Education_GDP_Countries_Only$Ranking_Quintile_Cat[Education_GDP_Countries_Only$Ranking_Quintile == "(152,190]"] <- 5
```

# Contingency Table of Income Group by GDP Ranking Quintile.

```r
Income_by_Ranking <- table(Education_GDP_Countries_Only$Income.Group, Education_GDP_Countries_Only$Ranking_Quintile_Cat)
```

There are five (5) Lower Middle Income countries that are in the highest GDP ranking quintile (the top 38 countries by GDP).

# Conclusion

As seen from the analyses above, as one would expect, a nation's GDP tends to be positively related with the income level of its inhabitants.  However, there are a couple of exceptions to this rule.  First, Lower Middle Income countries, which normally have GDP's lower than $100 billion, occupy a higher proportion of nations with GDP's between approximately $850 billion and $900 billion than any other income group.  This fact is borne out in both the density plot of GDP level by income group and the contingency table
of income group by GDP ranking quintile.  Second, a large proportion of High Income:nonOECD countries have a GDP of less than $100 billion, greater than that of Upper Middle Income countries and second only to Lower Middle Income nations.  This is corroborated by the fact that High Income:nonOECD countries have a lower median GDP than Upper Middle Income countries.
