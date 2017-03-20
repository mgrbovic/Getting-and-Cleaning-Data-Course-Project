##########################################################################################
#Getting and Cleaning Data Course Project
##########################################################################################

##########################################################################################
#Download and Unzip data set
##########################################################################################

#Set Working Directory
setwd("C:/_MIROSLAV/POSAO/Coursera/MyRdirectory/UCI HAR Dataset/")

#Download zip file from Internet:
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
downloadedFileName <- "Dataset.zip"
download.file(URL, downloadedFileName)

#Unzip Dataset.zip
unzip(zipfile="./Dataset.zip")

#Install and Load required package
install.packages("data.table")
library(data.table)


##########################################################################################
#Read data files and create Data Tables
##########################################################################################

#Read files with data for - 561 Features
featuresTrain <- read.table("./train/X_train.txt", header=FALSE)
featuresTest  <- read.table("./test/X_test.txt", header=FALSE)

#Read files with data for - Activities
#(which activity provided data: 1. walking, 2. walking_upstairs, 3. walking_downstairs, 4. sitting, 5. standing, 6. laying)
activitiesTrain <- read.table("./train/y_train.txt", header=FALSE)
activitiesTest  <- read.table("./test/y_test.txt", header=FALSE)

#Read files with data for - Subjects (which of 30 volunteers carried out the experiment)
subjectTrain <-read.table("./train/subject_train.txt", header=FALSE)
subjectTest  <-read.table("./test/subject_test.txt", header=FALSE)

#Read files with data for - Labels (column names in Features files & Activity files)
featuresLabel <- read.table("./features.txt",header=FALSE)
activityLabel <- read.table("./activity_labels.txt",header=FALSE)

##########################################################################################
#Assigning column names in Data Tables created above
##########################################################################################

#Column names in Data Table with - 561 Features
colnames(featuresTrain) <- featuresLabel[,2]
colnames(featuresTest)  <- featuresLabel[,2]

#Column names in Data Table with - Activities
colnames(activitiesTrain) <- "activityId"
colnames(activitiesTest) <- "activityId"

#Column names in Data Table with - Subjects
colnames(subjectTest) <- "subjectId"
colnames(subjectTrain) <- "subjectId"

#Column names in Data Table with - Labels
colnames(activityLabel) <- c("activityId","activityType")



##########################################################################################
#1. Merge the training and the test sets to create one data set
##########################################################################################


#Merging Training data
trainDataMerged <- cbind(activitiesTrain,subjectTrain,featuresTrain)

#Merging Test data
testDataMerged <- cbind(activitiesTest,subjectTest,featuresTest)

#Merging Training data and Test data
DataMerged <- rbind(trainDataMerged,testDataMerged)



##########################################################################################
#2. Extracts only the measurements on the Mean and Standard Deviation for each measurement
##########################################################################################

#In addition to columns "Mean()" and "SD" we are adding columns "activityId" and "subjectId" to be used later
DataMergedMeanSD <- DataMerged[,grepl("activityId|subjectId|mean\\(\\)|std\\(\\)",colnames(DataMerged))]



##########################################################################################
#3. Uses descriptive activity names to name the activities in the data set
##########################################################################################

#Install and Load required package
install.packages("dplyr")
library(dplyr)

#Joing data table "DataMergedMeanSD" with data table "activityLabel" in which we have "activityTyp" matched to "activityId"
DataMergedMeanSDActivity <- join(DataMergedMeanSD, activityLabel, by = "activityId", match = "first")

# Excluding column 1 ("activityId") which containsredundant information about Activity id
DataMergedMeanSDActivity <- DataMergedMeanSDActivity[,-1]

##########################################################################################
#4. Appropriately labels the data set with descriptive variable names
##########################################################################################

#Remove parentheses in column names
names(DataMergedMeanSDActivity) <- gsub("\\(|\\)", "", names(DataMergedMeanSDActivity), perl  = TRUE)


#Add descriptive column names
names(DataMergedMeanSDActivity) <- gsub("^t", "Time", names(DataMergedMeanSDActivity))
names(DataMergedMeanSDActivity) <- gsub("^f", "Frequency", names(DataMergedMeanSDActivity))

names(DataMergedMeanSDActivity) <- gsub("Acc", "Acceleration", names(DataMergedMeanSDActivity))
names(DataMergedMeanSDActivity) <- gsub("Gyro", "AngularVelocity", names(DataMergedMeanSDActivity))

names(DataMergedMeanSDActivity) <- gsub("BodyBody", "Body", names(DataMergedMeanSDActivity))

names(DataMergedMeanSDActivity) <- gsub("mean", "Mean", names(DataMergedMeanSDActivity))
names(DataMergedMeanSDActivity) <- gsub("std", "SD", names(DataMergedMeanSDActivity))

names(DataMergedMeanSDActivity) <- gsub("Mag", "Magnitude", names(DataMergedMeanSDActivity))

##########################################################################################
#5. From the data set in step 4, creates a second, independent tidy data set
#   with the average of each variable for each activity and each subject
#Please upload your data set as a txt file created with write.table() using row.name=FALSE
##########################################################################################


#Creating  independent tidy data set with the average of each variable for activity and subject
DataAvgPerActivitySubject <- ddply(DataMergedMeanSDActivity, c("subjectId","activityType"), numcolwise(mean))

#Writing final data set in file for upload
write.table(DataAvgPerActivitySubject, file="tidyData.txt", row.names = FALSE)

