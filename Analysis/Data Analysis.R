#Sort merged data set in ascending order by GDP.

Education_GDP <- Education_GDP[order(Education_GDP$GDP),] 

#St. Kitts and Nevis is the 13th country in the Education_GDP data set sorted ascending by GDP.

#Average GDP rankings for the "High income: OECD" and "High income:nonOECD" groups

summary(subset(Education_GDP, Education_GDP$Income.Group == "High income: nonOECD")$Ranking)

#The average GDP ranking for High income:nonOECD countries is 91.91.  

summary(subset(Education_GDP, Education_GDP$Income.Group == "High income: OECD")$Ranking)

#The average GDP ranking for High income:OECD countries is 32.97.  

#Density plot of GDP by income group

install.packages("ggplot2")
library(ggplot2)

Education_GDP_Countries_Only <- subset(Education_GDP, Education_GDP$Ranking != "NA") #Creating data frame that only includes specific countries on each row, not aggregate 
#groups
qplot(GDP, data=Education_GDP_Countries_Only, geom="density", fill=Income.Group, alpha=I(.5), 
      main="Distribution of GDP by Income Group", xlab="GDP", ylab="Density", xlim = c(0,1000000), ylim = c(0,0.00001))

#From the plot above, countries in the Lower Middle Income group are more likely to have a GDP of less than $100 billion than other income groups.  High Income: OECD countries 
#are generally the most likely to have a GDP greater than $125 billion.  However, Lower Middle Income countries are more likely to have a GDP between approximately $850 billion
#and $900 billion than other income groups.  Also, High Income:nonOECD countries are more likely to have a GDP of less than $100 billion than Upper middle income countries.  

#Summary statistics for GDP by each of the five income groups.

summary(subset(Education_GDP, Education_GDP$Income.Group == "High income: nonOECD")$GDP)
summary(subset(Education_GDP, Education_GDP$Income.Group == "High income: OECD")$GDP)
summary(subset(Education_GDP, Education_GDP$Income.Group == "Low income")$GDP)
summary(subset(Education_GDP, Education_GDP$Income.Group == "Lower middle income")$GDP)
summary(subset(Education_GDP, Education_GDP$Income.Group == "Upper middle income")$GDP)

#Not surprisingly, High Income: OECD countries have the highest median GDP at $486.5 billion while Low Income countries have the lowest median GDP at $7.843 billion.  High 
#Income: OECD countries have a lower median GDP of $28.37 billion than the $42.94 billion median GDP of Upper Middle Income countries.  

#Cut the GDP rankings into 5 separate quintile groups in a variable called "Ranking_Quintile_Cat".

Education_GDP_Countries_Only$Ranking_Quintile <- cut(Education_GDP_Countries_Only$Ranking, quantile(Education_GDP_Countries_Only$Ranking, c(0,0.2,0.4,0.6,0.8,1)))
Education_GDP_Countries_Only$Ranking_Quintile_Cat[Education_GDP_Countries_Only$Economy == "United States"] <- 1
Education_GDP_Countries_Only$Ranking_Quintile_Cat[Education_GDP_Countries_Only$Ranking_Quintile == "(1,38.6]"] <- 1
Education_GDP_Countries_Only$Ranking_Quintile_Cat[Education_GDP_Countries_Only$Ranking_Quintile == "(38.6,76.2]"] <- 2
Education_GDP_Countries_Only$Ranking_Quintile_Cat[Education_GDP_Countries_Only$Ranking_Quintile == "(76.2,114]"] <- 3
Education_GDP_Countries_Only$Ranking_Quintile_Cat[Education_GDP_Countries_Only$Ranking_Quintile == "(114,152]"] <- 4
Education_GDP_Countries_Only$Ranking_Quintile_Cat[Education_GDP_Countries_Only$Ranking_Quintile == "(152,190]"] <- 5

#Create a contingency table of income group by GDP ranking quintile.

Income_by_Ranking <- table(Education_GDP_Countries_Only$Income.Group, Education_GDP_Countries_Only$Ranking_Quintile_Cat)

#There are 5 Lower Middle Income countries that are in the highest GDP ranking quintile (the top 38 countries by GDP).