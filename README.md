## GCD_Course_Project
## This file provides a detailed description of  the overview of the project and how the 
## run_Analysis.R script works.
##
## The goal of this project is to create tidy data from source data for later use.
## Source Data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
##
## Instructions to get tidy data from source data
##
## The script assumes that the source data file was already downloaded to the current working directory and
## unzipped. (Per course project discussion board and course project instructions).
##
## The script uses 'reshape2' package for data set manipulation - melt, dcast etc. Per the Stack Overflow 
## Q&A post - http://stackoverflow.com/questions/24880835/how-to-melt-and-cast-dataframes-using-dplyr, 
## 'reshape2' package is more efficient than 'tidyr' package.
##
## 1. Load reshape2 package
## 2. Load activity labels & features
## 3. Extract only feature names that represent mean and standard deviation values using grep
## 4. Manipulate feature names to be more descriptive using gsub
## 5. Load the train and test datasets
## 6. Merge traindata and testdata 
## 7. Add features names that are more descriptive from the manipulated feature names in 4.
## 8. Add descriptive activity labels and convert columns 'Activities' and 'Subjects' as Factors
## 9. Melt merged data with 'Subject' and 'Activity' as IDs
## 10. Cast the merged data with the average of all variables using dcast
## 11. Write the resulting data table into a text file called 'tidydata.txt' and save in working directory.