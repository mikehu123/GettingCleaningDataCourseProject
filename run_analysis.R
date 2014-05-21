##### Description
# 
# This script collects and cleans the raw data and produces a tidy data set.
#
# The steps are
# - download raw data
# - read in descriptive feature variable names
# - combine training and test data for X, y and subject respectively (rbind)
# - assign description feature variables names to X feature variable columns 
# - read in description activity labels
# - map activity id in raw data to activity labels 
# - combine X, subject, y (activity) data set (cbind)
# - compute mean and standard deviation (sd) on feature variables per subject and activity
# - write the resulting tidy data set to the output file


#### download raw data file

url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,"Dataset.zip",method="curl")
unzip("Dataset.zip")

##### read in feature variable names file
varnames<-read.table("UCI HAR Dataset/features.txt")

#### normalize feature variable names using the following rules: 
# 1. remove "()" and ")"
# 2. replace "(" and "," with "_"

varnames<-varnames[,2]
varnames<-gsub("\\(\\)|\\)","",varnames)
varnames<-gsub("[\\(,\\,]","_",varnames)

#### combine X training and test data
X_training<-read.table("UCI HAR Dataset/train/X_train.txt",header=FALSE)  
X_test<-read.table("UCI HAR Dataset/test/X_test.txt",header=FALSE)  
X=rbind(X_training,X_test)
# set feature variable colomn names to description names 
colnames(X)=varnames

#### combine y training and test data
Y_training<-read.table("UCI HAR Dataset/train/y_train.txt",header=FALSE)  
Y_test<-read.table("UCI HAR Dataset/test/y_test.txt",header=FALSE)  
Y=rbind(Y_training,Y_test)
colnames(Y)<-c("activityid")

#### read in activityid and label mapping table
activitylabels<-read.table("UCI HAR Dataset/activity_labels.txt")
colnames(activitylabels)<-c("activityid","activity")

#### map Y's activityid to activity label
Y_labels<-merge(Y,activitylabels,by.x="activityid",by.y="activityid")

#### combine subject training and test data
subject_training<-read.table("UCI HAR Dataset/train/subject_train.txt",header=FALSE)  
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt",header=FALSE)  
subject=rbind(subject_training,subject_test)
colnames(subject)<-c("subject")

#### combine X, subject and y data
X_sub_act = cbind(X,subject,Y_labels["activity"])

#### compute mean and sd of every feature variable group by subject and activity
X_sub_act_mean_sd=aggregate(X_sub_act[,1:561],list(subject=X_sub_act$subject,activity=X_sub_act$activity)
                            ,FUN=function(x) c(mean=mean(x),sd=sd(x)))

#### write tidy data to output file
write.table(X_sub_act_mean_sd,"X_mean_sd_by_subject_activity.txt",row.names=FALSE,quote=FALSE,sep="\t")

