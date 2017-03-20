# Getting and Cleaning Data Course Project

The class project for [Getting and Cleaning Data](https://www.coursera.org/course/getdata) was to read in the ["Human Activity Recognition Using Smartphones" data set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), perform an analysis on the data set, and output a tidy data set.

This README.me file describes the steps taken in the script "run_analysis.R " to complete the course objectives.

## Preparation of data

### Download and Unzip data set

In this section of the script all data for the project are downloaded and unzipped.

### Read data files and create Data Tables

In this section of the script all data files needed for the analysis are loaded into Data Tables

### Assigning column names in Data Tables created above

This section of the script assigns column names in Data Tables created in step 2


## Data analysis

This section of the scripts performs following actions described in course objectives:

### 1. Merge the training and the test sets to create one data set

Merging first training data, then test data and finally training and test data together

### 2. Extracts only the measurements on the Mean and Standard Deviation for each measurement

In addition to columns that contain "mean()" and "std()" strings we are adding columns "activityId" and "subjectId" to be used later

### 3. Uses descriptive activity names to name the activities in the data set

We install and load "dplyr" package first and then add descriptive names to Activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)

### 4. Appropriately labels the data set with descriptive variable names

We remove parentheses in column names and add descriptive column names where needed

### 5. Create tidy data set with the average of each variable for each activity and each subject

From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each Activity and each Subject. Finally, we write final data set in file "tidyData.txt" for upload.
