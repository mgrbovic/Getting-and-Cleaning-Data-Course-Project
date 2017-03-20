## Code Book

This code book will describe the variables, the data and transformations or work that performed to clean up the data.

### Explanation of data collection

30 volunteers performed 6 different activities while wearing a smartphone. The smartphone captured various data about their movements.

### Explanation of data files

#### Files with data for - 561 Features
* `X_train.txt`: 7352 observations of the 561 features, for 21 of the 30 volunteers.
* `X_test.txt`: 2947 observations of the 561 features, for 9 of the 30 volunteers.

#### Files with data for - Activities
* `y_train.txt`: A vector of 7352 integers, denoting the ID of the activity related to each of the observations in `X_train.txt`.
* `y_test.txt`: A vector of 2947 integers, denoting the ID of the activity related to each of the observations in `X_test.txt`.

#### Files with data for - Subjects (which of 30 volunteers carried out the experiment)
* `subject_train.txt`: A vector of 7352 integers, denoting the ID of the volunteer related to each of the observations in `X_train.txt`.
* `subject_test.txt`: A vector of 2947 integers, denoting the ID of the volunteer related to each of the observations in `X_test.txt`.

#### Files with data for - Labels (column names in Features files & Activity files)
* `features.txt`: Names of the 561 features (variables)
* `activity_labels.txt`: Names and IDs for each of the 6 activities (1 WALKING, 2 WALKING_UPSTAIRS, 3 WALKING_DOWNSTAIRS 4 SITTING, 5 STANDING, 6 LAYING)

The data files in the "Inertial Signals" folders (raw signal data) were ignored were not used for analysis

### Explanation of other files

* `README.txt`: contains more information about the files.
* `features_info.txt``: contains more information about the features.

### Work performed to clean up the data

First of all, the relevant data files were downloaded and read into data tables and appropriate column headers were added.

1. Training and test sets were combined into a single data table
2. All feature columns were removed that did not contain the exact string "mean()" or "std()" as well as "activityId" and "subjectId" to be used later
3. New column which descriptive names of activities has been added to the data table
4. Parentheses in column names are removed and descriptive column names have been added where needed
5. From the data set in step 4, we creates a second, independent tidy data set with the average of each variable for each activity and each subject

Finally tidy data set has been exported to txt file called write.table() using row.name=FALSE.


