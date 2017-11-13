#setwd("C:\\Users\\micha\\coursera-getting-and-cleaning")

#check if data dorectory exists
if(!file.exists("./data")){
  dir.create("./data")
  }

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#only download if not alreasy downloaded
if (!file.exists("./data/RawData.zip")){
  download.file(fileUrl,destfile="./data/RawData.zip")
}

#only unzip if not previously unzipped
if(!file.exists("./data/UCI HAR Dataset")){
  unzip(zipfile="./data/RawData.zip",exdir="./data")
}

#read the required files
#=======================

#read the training files
xtrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subjecttrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

#read the testing files
xtest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subjecttest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

#read feature file
features <- read.table('./data/UCI HAR Dataset/features.txt')

#read activity file:
activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')

##correct column names and labels
colnames(xtrain) <- features[,2] 
colnames(ytrain) <-"activityId"
colnames(subjecttrain) <- "subjectId"

colnames(xtest) <- features[,2] 
colnames(ytest) <- "activityId"
colnames(subjecttest) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

###REQUIREMENT ONE
###===============
##combine all together
#by roiw first
subjectdata <- rbind(subjecttrain, subjecttest)
activitydata<- rbind(ytrain, ytest)
featuresdata<- rbind(xtrain, xtest)

#by column for single data set
tempbind <- cbind(subjectdata, activitydata)
cleanData <- cbind(featuresdata, tempbind)

###REQUIREMENT TWO
###===============
#extraxt mean and std deviation
#find columns that contain "mean" in description
#Mean <- grep("mean()", names(Master), value = FALSE, fixed = TRUE)
meancols <- grep("mean()", names(cleanData))
stdcols <- grep("std()", names(cleanData))
#meanstdData <- cleanData()

