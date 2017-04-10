#GDP data cleaning

install.packages("plyr")
library(plyr)

GDP_Clean <- (GDP$X.1 <- GDP$X.2 <- GDP$X.3 <- GDP$X.4 <- GDP$X.5 <- GDP$X.6 <-NULL) #Delete extraneous variables.
GDP <- rename(GDP, c(X="CountryCode", US.dollars.="GDP")) #Rename variables to more meaningful names.
GDP <- subset(GDP, CountryCode!="") #Delete cases whose country code is missing.

GDP$GDP <- as.numeric(gsub(",", "", as.character(GDP$GDP))) #Convert GDP to numeric variable.
GDP$Ranking <- as.numeric(gsub(",", "", as.character(GDP$Ranking))) #Convert Ranking to numeric variable.