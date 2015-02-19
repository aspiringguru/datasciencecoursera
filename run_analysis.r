## author : BM Taylor
## Getting and Cleaning Data : project Feb 2015.

## read in data
setwd("H:/2015/coursera/data_science/getting & cleaning data/project")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ","Dataset.zip", mode="wb")
unzip("Dataset.zip")
setwd("H:/2015/coursera/data_science/getting & cleaning data/project/UCI HAR Dataset")
## 

## Part 1. Merge the training and the test sets to create one data set.
setwd("H:/2015/coursera/data_science/getting & cleaning data/project/UCI HAR Dataset")
subject_train <- read.table("train/subject_train.txt") ## vector contains ID's of volunteers - training, 7352 rows
X_train <- read.table("train/X_train.txt")             ## matrix contains 7352 rows x 561 columns
y_train <- read.table("train/y_train.txt")                 ## vector contains ID's of activities recorded. 7352 rows
## combine subject_train, X_train, y_train to form matrix 7352 rows x 563 columns.
## additional two columns will be 'volunteerID' & 'activityID'.
## trainData = X_train + subject_train + y_train
trainData <- cbind(X_train, subject_train, y_train)
dim(trainData) ## [1] 7352  563

subject_test <- read.table("test/subject_test.txt")    ## vector contains ID's of volunteers - testing,  2947 rows
X_test <- read.table("test/X_test.txt")                ## matrix contains 2947 rows x 561 columns
y_test <- read.table("test/y_test.txt")                ## vector contains ID's of activities recorded. 2947 rows
## combine subject_test, X_test, y_test to form matrix 2947 rows x 563 columns.
## additional two columns will be 'volunteerID' & 'activityID'.
## testData = X_test + subject_test + y_test
testData <- cbind(X_test, subject_test, y_test)
dim(testData) ## [1] 2947  563

## now combine both 'train' and 'test' data sets, ie: subject_test + subject_train
trainNtest <- rbind(trainData, testData)
##  dim(trainNtest) ## [1] 10299   563  ## 7352+2947 = 10299


## assign column names using the names found in features.txt
features <- read.table("features.txt")
names(trainNtest) <- c(as.character(features$V2), "volunteerID", "activityID")
##  names(trainNtest)

## 2. Extract only the measurements on the mean and standard deviation for each measurement. 
##    use pattern matching to identify columns with 'mean' or 'std' in the column name.
##    refer week 4, lecture 
stdNmeanCols <- c(grep("std\\(\\)", names(trainNtest)), grep("mean\\(\\)", names(trainNtest)))
##    we also need to add columns for "volunteerID" & "activityID". since we know these are columns 562 & 563.
stdNmeanCols <- c(stdNmeanCols, 562, 563)
length(stdNmeanCols) ## [1] 68
trainNtest.meanNstd <- trainNtest[,stdNmeanCols]
dim(trainNtest.meanNstd) ## [1] 10299    68

## 3. Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("activity_labels.txt")
##    activity_labels$V2 contains descriptions of the activities. 
##    currently storing activity_labels$V1 in trainNtest$activityID (trainNtest[,563])
trainNtest.meanNstd$activityID <- factor(trainNtest.meanNstd$activityID, labels=as.character(activity_labels$V2))
##    trainNtest.meanNstd$activityID is now a factor variable.


## 4. Appropriately labels the data set with descriptive variable names. 
##    in the absence of better definitions, keeping the existing variable names 
##    resulting from names(trainNtest) <- c(as.character(features$V2)
##    
##    Summary of changes.
##    1. convert to lowercase, 2. separate words with '.'  
##    3. change abbrevations to full words.  4. strip () from names
names(trainNtest.meanNstd) <- gsub("\\(\\)", "", names(trainNtest.meanNstd))
##    features_info.txt : tells us "These time domain signals (prefix 't' to denote time)"
##    thus rename columns starting with 't' as 'time.' [will use '.' as word separator in column names]
##    lecture 4-2 "04_02_regularExpressions.pdf" explained metacharacters, '^' 
##    NB: sub replaces first occurrence only, gsub replaces all occurrences. 
names(trainNtest.meanNstd) <- sub("^t","time.",names(trainNtest.meanNstd),)
##    features_info.txt : Note the 'f' to indicate frequency domain signals
names(trainNtest.meanNstd) <- sub("^f","frequency.",names(trainNtest.meanNstd),)
##    Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm 
##      (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag)
names(trainNtest.meanNstd) <- gsub("Mag","magnitude.",names(trainNtest.meanNstd),)
##    the body linear acceleration and angular velocity were derived in time to obtain Jerk signals 
##    (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals 
##    were calculated using the Euclidean norm 
##    (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag)
names(trainNtest.meanNstd) <- gsub("Acc","acceleration.",names(trainNtest.meanNstd),)
names(trainNtest.meanNstd) <- gsub("Body","body.",names(trainNtest.meanNstd),)
names(trainNtest.meanNstd) <- gsub("Gravity","gravity.",names(trainNtest.meanNstd),)
names(trainNtest.meanNstd) <- gsub("Jerk","jerk.",names(trainNtest.meanNstd),)
names(trainNtest.meanNstd) <- gsub("Gyro","gyro.",names(trainNtest.meanNstd),)
names(trainNtest.meanNstd) <- gsub("-std-","std.",names(trainNtest.meanNstd),)
names(trainNtest.meanNstd) <- gsub("-mean-","mean.",names(trainNtest.meanNstd),)
## final cleanup to remove '-'
names(trainNtest.meanNstd) <- gsub("-",".",names(trainNtest.meanNstd),)
## next substitution is a response to the '..', messy response to bad coding above, rework this when time.
names(trainNtest.meanNstd) <- sub("\\.\\.",".",names(trainNtest.meanNstd),)

names(trainNtest.meanNstd)

## 5. From the data set in step 4, creates a second, independent tidy data set 
##    with the average of each variable for each activity and each subject.
##    this is possibly a table function.
##    desired result will look like this.
##    "volunteerID", "activityID", then 68 columns showing the means of the 68 variables selected in section 2 above.
##    where the combinations of "volunteerID" & "activityID" are unique.
##    refer lecture 3-4 "03_04_reshapingData.pdf", pages 4 & 5.
library(reshape2)
trainNtest.meanNstd.melted <- melt(trainNtest.meanNstd, id.vars= c("volunteerID", "activityID") )
## names(trainNtest.meanNstd.melted)  ##[1] "volunteerID" "activityID"  "variable"    "value"  
## columns "variable" & "value" are created by melt.
tidyData <- dcast(trainNtest.meanNstd.melted, volunteerID+activityID ~ variable, mean)
## quick inspection of the resulting data.
##  names(tidyData)
##  head(tidyData[1:5], 10) ## for example, first 5 columns, 10 rows.

##    write table to text file as required for submission.
##    set working directory to not write in the unzipped data directgory.
setwd("H:/2015/coursera/data_science/getting & cleaning data/project")
write.table(tidyData, "tidyData.txt", row.name=FALSE)
