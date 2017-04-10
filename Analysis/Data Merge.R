#Merge education and GDP data sets by country code.

Education_GDP <- merge(Education, GDP, by="CountryCode")

#224 of the Country Codes are found in both the Education and GDP data sets.