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
#find columns that contain "mean" or "std" in description
colNames <- colnames(cleanData)
wantedCols <- (grepl("activityId" , colNames) | 
                   grepl("subjectId" , colNames) | 
                   grepl("mean.." , colNames) | 
                   grepl("std.." , colNames))

setForMeanAndStd <- cleanData[ , wantedCols == TRUE]

###REQUIREMENT THREE
###=================
#Uses descriptive activity names to name the activities in the data set
setWithActivityNames <- merge(setForMeanAndStd, activityLabels,
                              by='activityId',
                              all.x=TRUE)


###REQUIREMENT FOUR
###================
#Appropriately labels the data set with descriptive variable names

colNames <- colnames(setWithActivityNames)
for (i in 1:length(colNames)) 
{
  #print(i)
  #print(colNames[i])
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
  #print(colNames[i])
}
colnames(setWithActivityNames) = colNames

###REQUIREMENT FIVE
###================
#From the data set in step 4, creates a second, independent tidy data set with the average 
#of each variable for each activity and each subject
secTidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]

write.table(secTidySet, file = "Tidy.txt", row.names = FALSE)
