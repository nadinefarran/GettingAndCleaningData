library(data.table)
library(dplyr)

##run_analysis.R does the following
##1.Merges the training and the test sets to create one data set.
##2.Extracts only the measurements on the mean and standard deviation for each measurement.
##3.Uses descriptive activity names to name the activities in the data set
##4.Appropriately labels the data set with descriptive variable names.
##5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

###1.**Download the file and unzip
if(!file.exists("./UCI_HAR_Dataset")){dir.create("./UCI_HAR_Dataset")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./UCI_HAR_Dataset/Dataset.zip")
unzip(zipfile="./UCI_HAR_Dataset/Dataset.zip",exdir="./UCI_HAR_Dataset")

### Read data from the unziped folder
### Get values for "Activity" Variable from  "y_train.txt" and  "y_test.txt"
### Get values for "Features" Variable from  "x_train.txt" and  "x_test.txt"
### Get values for "Subject"  Variable from  "subject_train.txt" and  "subject_test.txt"
### "features.txt" holds names for "Features" Variable  while "activity_labels.txt" holds levels for "Activity" Variable

###test folder
y_test <- read.table("./UCI_HAR_Dataset/UCI HAR Dataset/test/y_test.txt",header = FALSE)
x_test <- read.table("./UCI_HAR_Dataset/UCI HAR Dataset/test/X_test.txt",header = FALSE)
subject_test <- read.table("./UCI_HAR_Dataset/UCI HAR Dataset/test/subject_test.txt",header = FALSE)

###train folder
y_train <- read.table("./UCI_HAR_Dataset/UCI HAR Dataset/train/y_train.txt",header = FALSE)
x_train <- read.table("./UCI_HAR_Dataset/UCI HAR Dataset/train/X_train.txt",header = FALSE)
subject_train <- read.table("./UCI_HAR_Dataset/UCI HAR Dataset/train/subject_train.txt",header = FALSE)

###features names and activity levels
features <- read.table("./UCI_HAR_Dataset/UCI HAR Dataset/features.txt", header = FALSE)
names(features) <- c('feature_id', 'feature_name')
activities <- read.table("./UCI_HAR_Dataset/UCI HAR Dataset/activity_labels.txt", header = FALSE)
names(activities) <- c('activity_id', 'activity_name') 

##1.Merges the training and the test sets to create one data set.
### rbind y_test and y_train, rbind x_test and x_train, rbind subject_test and subject_train. Give suitable names to variables
###x
x <- rbind(x_train, x_test)
names(x)<- features$feature_name
###y
y <- rbind(y_train, y_test)
names(y)<-c("activity")
###subject
subject <- rbind(subject_train, subject_test)
names(subject)<-c("subject")
###create one data set
allData <- cbind(x, subject, y)

##2.Extracts only the measurements on the mean and standard deviation for each measurement.
sub_features<-features$feature_name[grep("mean\\(\\)|std\\(\\)", features$feature_name, ignore.case=TRUE)]
names <- c(as.character(sub_features), "subject", "activity" )
allData <-subset(allData, select=names)

##3.Uses descriptive activity names to name the activities in the data set.
allData$activity<-factor(allData$activity);
allData$activity<-factor(allData$activity,labels=as.character(activities$activity_name)) 

##4.Appropriately labels the data set with descriptive variable names.
names(allData)<-gsub("^t", "time", names(allData))
names(allData)<-gsub("^f", "frequency", names(allData))
names(allData)<-gsub("Acc", "Accelerometer", names(allData))
names(allData)<-gsub("Gyro", "Gyroscope", names(allData))
names(allData)<-gsub("Mag", "Magnitude", names(allData))
names(allData)<-gsub("BodyBody", "Body", names(allData))
###names(allData)

##5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
newDataset<-aggregate(. ~subject + activity, allData, mean)
newDataset<-newDataset[order(newDataset$subject,newDataset$activity),]
write.table(newDataset, file = "tidydata.txt",row.name=FALSE)

