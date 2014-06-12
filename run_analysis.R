## Download and unzip the data.
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip";
download.file(url=url, destfile = "project.zip", mode="wb");
unzip(zipfile = "project.zip");

## Save the current working directory.  We will return to this later when we output the tidy dataset
home = getwd();

## After unziping, the contents of the zipfile are placed in the "UCI HAR Dataset" subfolder.  
## Set that folder as the working directory
setwd("./UCI HAR Dataset");

## Read in the column names for the X data files.  These variable names are stored under "features.txt" from the original data
colNames <- read.delim("features.txt", sep=" ", header=FALSE, col.names = c("col.num", "variable.name"),
                       stringsAsFactors=FALSE);
colNames <- colNames$variable.name;

## Load the measurement "X" data from the training and test sets, then combine them into X.
w <- rep(16, length(colNames));
X.test <- read.fwf(file="./test/X_test.txt", widths=w, colClasses="numeric", buffersize=100);
X.train <- read.fwf(file="./train/X_train.txt", widths=w, colClasses="numeric", buffersize=100);
X <- rbind(X.test, X.train);

## Remove the individual sets from memory
remove("X.test","X.train");



## Add column names to X and keep only those columns that calculate 
## the mean or standard deviation of a measurement by searching for those terms with grep
names(X) = colNames;
idx.keep <- grep(x=colNames,pattern="mean()",fixed=TRUE);
idx.keep <-c(idx.keep,grep(x=colNames,pattern="std()", fixed=TRUE));
X <- X[,idx.keep];

## For each row in the measurement X data, there is an indicator for the type of activity.  Load the test and training
## data, then combine them.
activity.test <- read.table(file="./test/y_test.txt", header=FALSE, stringsAsFactors=FALSE);
activity.train <- read.table(file="./train/y_train.txt", header=FALSE, stringsAsFactors=FALSE);
activity <- rbind(activity.test, activity.train);

## Read in the corresponding description for each activity code.
activity_labels <- read.delim("activity_labels.txt", sep=" ", header=FALSE, 
                              col.names=c("code", "activity.name"), stringsAsFactors=FALSE);

## Replace activity codes for each line of X with readable descriptions
activity <- merge(x=activity, y=activity_labels, by.x="V1", by.y="code");
activity <- activity[,2];

## Load and combine the subject information for each line in X
subject_test <- read.table(file="./test/subject_test.txt", header=FALSE, stringsAsFactors=FALSE);
subject_train <- read.table(file="./train/subject_train.txt", header=FALSE, stringsAsFactors=FALSE);
subject <- rbind(subject_test, subject_train);


## Merge the subject ids, the activity names, and the mean and std data
X <- cbind(subject, activity, X);
names(X)[1] <- "subject.id";

## Create a second, independent tidy data set with the average of each variable for each activity and each subject.
library(plyr);
library(reshape2)

Xmelted <- melt(X, id.vars=c("subject.id", "activity"));
#Xsummarized <- ddply(Xmelted, .(subject.id, activity, variable), summarize, mean=mean(value));

tidy_data <- dcast(Xmelted, subject.id + activity~variable, fun.aggregate=mean);

tidy_data <- arrange(tidy_data, subject.id, activity);

## Go back to the original directory and write out csv tables
setwd(home);
write.csv(x=X, file="measurement_data.csv", row.names=FALSE);
write.csv(x=tidy_data, file="tidy_data.csv", row.names=FALSE);





