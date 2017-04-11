#Dan Freeman
#Apirl 10, 2017
#MSDS 6306 Doing Data Science
#Case Study 1

#This file sources syntax from other .R files that import, clean, merge and
#analyze the data.


# Packages Needed
#install.packages("plyr")
#install.packages("ggplot2")
library(plyr)
library(ggplot2)

#REMEMBER TO SET YOUR WORKING DIRECTORY!
setwd("C:/Users/Dan Freeman/Documents/Southern Methodist University - MS in Data Science/Spring 2017 Courses/MSDS 6306 Doing Data Science/Case Study 1")

#Import the data.
source("./Analysis/Data Imports.R ")

#Clean the data.
source("./Analysis/Data Cleaning.R ")

#Merge the data.
source("./Analysis/Data Merge.R ")

#Analyze the data.
source("./Analysis/Data Analysis.R ")