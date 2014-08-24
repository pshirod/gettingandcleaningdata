# run_analysis.R script
# The script is arranged according the various steps of the project assignment
# I have added step 0 to take care of the preliminaries
# Step 0 Check and Create New Directory named "data" subdirectory
  if (!file.exists("data")) {
  dir.create("data")
  }
# Make "data" current working directory
  setwd("./data")
# Load samsung zipfile and Unzip
  fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileUrl,destfile="./samsung.zip",mode="wb")
  unzip("samsung.zip",unzip="internal")
# Read the activity and features variables from the appropriate folder
  activity<-read.table("./UCI HAR Dataset/activity_labels.txt",                    
                       colClasses="character")
  features<-read.table("./UCI HAR Dataset/features.txt",
                       colClasses="character")
# Step 1 Merge the training and the test sets to create one data set
# Read training and testing data and merge to data frame
# Do a for-loop on the "type" character vector to read both "train"&"test" data
  samdat<-data.frame()
  type<-c("train","test")
  for(i in 1:2) {
  X<-read.table(paste0("./UCI HAR Dataset/",type[i],"/X_",type[i],".txt")
                ,colClasses="numeric")
  y<-read.table(paste0("./UCI HAR Dataset/",type[i],"/y_",type[i],".txt"))
  sub<-read.table(paste0("./UCI HAR Dataset/",type[i],"/subject_",type[i],".txt"))
  samdat<-rbind(samdat,cbind(sub,y,X))
  } 
# Step 2 Extract only the measurements on the mean and standard deviation for
# each measurement
# Select measurement column Variables that reflect calculated mean and 
# standard deviation values
  selcol<-c(grep("mean()",features[,2],fixed=T),grep("std()",features[,2],
                                                     fixed=T))
  samdat1<-samdat[,c(1:2,(2+selcol))]
  colnames(samdat1)<-c("subject","activity",as.character(features[selcol,2]))
# Step 3 Rename activity data from code to named activity. 
# Remove "-" in activity names and convert to lower case
  activity[,2]<-tolower(activity[,2])
  activity[,2]<-gsub("_","",activity[,2],fixed=T)
  samdat1[,2]<-activity[samdat[,2],2]
# Step 4.Appropriately label the data set with descriptive variable names
# Clean up measurement labels using gsub with a for-loop and lower case
# Dataframe samdat1 with the corrected names is the first dataset for step 4
  cnames<-colnames(samdat1)
  wrong<-c("tBody","tGravity","fBodyBody","fBody","-","()","Mag","std","Acc")
  correct<-c("timebody","timegravity","frequencybody","frequencybody","","",
             "magnitude","stddev","accel")
  for (i in 1:9) {
  cnames<-gsub(wrong[i],correct[i],cnames,fixed=T)
  }
  colnames(samdat1)<-tolower(cnames)
# Step 5 Create a second, independent tidy data set with the average of each 
# variable for each activity and each subject
  
  samdat2<-aggregate(samdat1[,3:length(cnames)], 
          by=list(activity=samdat1$activity,subject=samdat1$subject), FUN=mean)
# Rearrange samdat2 file to make "subject" the first columns followed by "activity" and then the measured variables
  samdat2[,1:2]<-samdat2[,2:1]
  colnames(samdat2)[1:2]<-colnames(samdat2)[2:1]
# Write a txt file "samsung2.txt" as the second tidy data set
# Please open it as indicated below with read.table with header=T option
  write.table(samdat2, file = "samsung2.txt", col.names=T, row.names = FALSE,sep="\t")
  samsung2<-read.table("samsung2.txt",header=T)
