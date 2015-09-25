### Getting and Cleaning Data - Course Project - run_Analysis.R 
### Script to create tidy data from dataset in 'Human Activity Recognition Using Smartphone Data Set
### https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#
### Load package 'reshape2' to perform data frame manipulations
### Based on this Stack Overflow Q&A post, package 'reshape2' is more efficient than tidyr
#
library(reshape2)
#
### This script assumes that the dataset is downloaded and unzipped in the current working directory
#
### Load activity labels & features
#
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")
#
### 2. Extracts only the measurements on the mean and standard deviation for each measurement
### Extract only feature names that represent mean and standard deviation values using grep
### Uses descriptive variable (feature) names to name the features in the data set
### Manipulate feature names to be more descriptive using gsub
#
featuresWanted <- grep(".*mean.*|.*std.*", features[,2])
featuresWanted.names <- features[featuresWanted,2]
featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)
featuresWanted.names <- gsub("^(t)","time",featuresWanted.names)
featuresWanted.names <- gsub("^(f)","freq",featuresWanted.names)
featuresWanted.names <- gsub("([Gg]ravity)","Gravity",featuresWanted.names)
featuresWanted.names <- gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",featuresWanted.names)
featuresWanted.names <- gsub("[Gg]yro","Gyro",featuresWanted.names)
featuresWanted.names <- gsub("AccMag","AccMagnitude",featuresWanted.names)
featuresWanted.names <- gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",featuresWanted.names)
featuresWanted.names <- gsub("JerkMag","JerkMagnitude",featuresWanted.names)
featuresWanted.names <- gsub("GyroMag","GyroMagnitude",featuresWanted.names)
#
### Load the train and test datasets
#
traindata <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresWanted]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
traindata <- cbind(trainSubjects, trainActivities, traindata)
#
testdata <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresWanted]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
testdata <- cbind(testSubjects, testActivities, testdata)
#
### 1. Merges the training and the test sets to create one data set.
### Merge traindata and testdata and add features names that are more descriptive
#
mergedData <- rbind(traindata, testdata)
#
### 4. Appropriately labels the data set with descriptive variable names. 
#
colnames(mergedData) <- c("subject", "activity", featuresWanted.names)
#
### 3. Uses descriptive activity names to name the activities in the data set
### Convert activities & subjects into factors
mergedData$activity <- factor(mergedData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
mergedData$subject <- as.factor(mergedData$subject)
#
### Melt merged data with 'Subject' and 'Activity' as IDs
#
mergedData.melted <- melt(mergedData, id = c("subject", "activity"))
#
### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
###         for each activity and each subject.
### Cast the merged data with the average of all variables
#
mergedData.mean <- dcast(mergedData.melted, subject + activity ~ variable, mean)
#
### Write the resulting tidy data into a text file called 'tidydata.txt' in current working directory
#
write.table(mergedData.mean, "tidydata.txt", row.names = FALSE, quote = FALSE)