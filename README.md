getdata-project
===============

##What Is This?

This repository containing code and other files for a course project.  The class is "Getting and Cleaning Data" and is offered through Coursera by Johns Hopkins.


##What Are All These Files?

###run_analysis.R

This text document contains R script that will download data, extract it, then create a tidy data set by doing the following steps.

First, it downloads the data.  Since it is in a zip file, the next step is to unzip it in the current working directory.

After unzipping the file, the contents of the zipfile are placed in the "UCI HAR Dataset" subfolder.  The next step is to set that folder as the working directory, load the features data from the training and test sets, and then combine them into "x".

Each column in the features data is a variable, and these variable names are stored under "features.txt" from the original data.  Load this file and add column names to X

Then, keep only those columns that calculate the mean or standard deviation of a feature by searching the column names for the terms "mean()" and "std()" with grep, and subsetting those columns.

For each row in the feature X data, there is an indicator for the type of activity.  This indicator is located in the "y_test.txt" and "y_train.txt" files.  Load these files then combine them.

Read in the corresponding description for each activity code from the "activity_labels.txt".  then

See the comments in this file for more details in context of the code, then replace the activity codes for each line of X with readable descriptions.

Load and combine the subject information from the test and training sets for each line in X.

Merge the subject ids, the activity names, and the mean and standard deviations of the features

Melt the data then create groups of subject id and activity, calculating the mean for each variable within those subset groups.  Then recast the data frame with each variable in a seperate column.  Output this table as tidy_data.txt

###CODEBOOK.rtf

This document contains information about the output data files, tidy_data.txt and measurement_data.txt

###measurement_data.txt

This is a comma-separated values (CSV) file containing data that has been shaped to an intermediate format between the raw data and the final tidy data set.  It merges the training and test sets and contains only the mean and standard deviation values for each measurement.  Descriptive activity names replace activity codes.  Merges the training and the test sets to create one data set.


See CODEBOOK.rtf for more details.

###tidy_data.txt
This is a comma-separated values (CSV) file containing the final tidy data set.  See CODEBOOK.rtf for more details.

###README.md 

This document!