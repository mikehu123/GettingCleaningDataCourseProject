GettingCleaningDataCourseProject
================================

## Introduction

This project collects and processes the raw Human Activity Recognition Using Smartphones Data Set 
from the UCI Machine Learning Repository, then produces a tidy data set with the mean and standard deviation of each variable for each activity and each subject.

## Files Included

* READE.md - project overview and design considerations
* CodeBook.md - description on the variables and transformations 
* run_analysis.R - data processing R script
* raw files - for convenience, not required by run_analysis.R which downloads raw data from web
  * UCI HAR Dataset/activity_labels.txt - mapping from activity id to activity label
  * UCI HAR Dataset/features.txt - list of feature variable names
  * UCI HAR Dataset/train/X_train.txt - Training Set
  * UCI HAR Dataset/train/y_train.txt - Training labels
  * UCI HAR Dataset/train/subject_train.txt - subject id of each train sample
  * UCI HAR Dataset/test/X_test.txt - Test Set
  * UCI HAR Dataset/test/y_test.txt - Test Labels
  * UCI HAR Dataset/test/subject_test.txt - subject id of each test sample
* X_mean_sd_by_subject_activity.csv - tidy data set

## How Raw Files are chosen

The raw data zip file contains a number of data files which can be categorized as follow:

* meta data files including
  * UCI HAR Dataset/activity_labels.txt - mappings from activity id to activity label
  * UCI HAR Dataset/features.txt - list of feature variable names
* feature variable training and test data/labels and corresponding subject ids 
  * UCI HAR Dataset/train/X_train.txt - Training Set
  * UCI HAR Dataset/train/y_train.txt - Training labels
  * UCI HAR Dataset/train/subject_train.txt - subject id of each train sample
  * UCI HAR Dataset/test/X_test.txt - Test Set
  * UCI HAR Dataset/test/y_test.txt - Test Labels
  * UCI HAR Dataset/test/subject_test.txt - subject id of each test sample
* accelerometer and gyroscope signals from which the feature variables were estimated
  * UCI HAR Dataset/train/Inertial Signals
  * UCI HAR Dataset/test/Inertial Signals
  
In this project, only the first two categories (i.e. meta data files and feature variable files) were used in data processing and not the accelerometer and gyroscope signals based on the following design considerations:

* One of the tidy data principle is that each tidy data table contains information about only one type of observation. Since the feature variables were estimated from the sensor signals, if we
include feature variables, then the sensor signals can become redundant data hence shall be 
excluded

* The requirements for the project is to compute the mean of sd of each measurement, i.e., it appears to look for more summarization of the measurements, so it seems to make more sense to use the estimated feature variables instead of the raw sensor signals here. Having said that, upon further clarifications on the requirements or the real needs of the data consumer, it is not impossible that the raw sensor signals are preferred, in which case it will be quite easy to update the script to use the sensor signals and the whole processing flow will remain mostly the same. 


## How The Data Processing Script works

This run_analysis.R script downloads and processes the raw data then produces a tidy data set.

The main steps are
* download raw data
* read in descriptive feature variable names and normaliz the names to be more readable
* combine training and test data for X, y and subject respectively (rbind)
* assign description feature variables names to X feature variable columns 
* read in description activity labels
* map activity id in raw data to activity labels 
* combine X, subject, y (activity) data set (cbind)
* compute mean and standard deviation (sd) on feature variables per subject and activity
* write the resulting tidy data set to the output file

## Notes on Running Script

The data processing script is designed to download the raw data file from web directly so it can 
be run from any place and does not depend on the data files availability on user's local disk.

However if the user has a slow network connection which may cause the script to take too long to download the file or already has the data files on local disk, the user can easily comment out the 'download.file' and/or 'unzip' codes in the beginning of the script and do the raw data downloading tasks manually outside the script.



