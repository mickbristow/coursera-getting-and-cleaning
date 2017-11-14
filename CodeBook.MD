## Getting and Cleaning Data Project

Michael Bristow

### Data Source
Data used in this project can be found at [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

[Source data for project](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


### Description of R script actions

### Requirement 1. Merge the training and the test sets to create one data set.
Tasks
- check if data directory exists, create if not
- download data file
- unzip data file

Read each of the following files
- features.txt
- activity_labels.txt
- subject_train.txt
- x_train.txt
- y_train.txt
- subject_test.txt
- x_test.txt
- y_test.txt

Correct column names and create one data set.

## Requirement 2. Extract only the measurements on the mean and standard deviation for each measurement. 
Use a LOGICAL vector to extract the mean + std columns

## Requirement 3. Use descriptive activity names to name the activities in the data set
Merge data subset with the activityType table to include the descriptive activity names

## Requirement 4. Appropriately label the data set with descriptive activity names.
Substitue more approapriate label names using the gsub function

## Requirement 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
Create a new .txt file containing average of each activity by subject
