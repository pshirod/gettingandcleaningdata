# README file for course project  

The README file describes how the script works. The script was developed on a Windows 7 machine running version 3 of RStudio. Details of the original experiments and data set can be found in the following link : [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The script is arranged according the various steps of the project assignment.
I have added step 0 to take care of the preliminaries.  
**Step 0**  
 I check and create new directory named "data" subdirectory. I have assumed that one has to obtain the required files from the web link. Once the zip file is downloaded I unzip it to provide the main folder "UCI HAR Dataset" folder and its subfolder "train" and "test". I download the "activity" code and "features" files.  
**Step 1**  
 In preparation for the merging, the "training" and "test" data (X,y,subject) are read from the "train" and "test" subdirectory using a for-loop function. The "paste0" function was used to take advantage of the for-loop function. The merge was performed during the for-loop function using "cbind" and "rbind". "samdat" is the name of the file that contains the merged raw data.  
**Step 2**  
In this step, I extract only the measurements on the mean and standard deviation for each measurement. I made the assumption that only the calculated "mean" and "standard deviation" are needed. Based on the information on the "features_info.txt" file only variable names with "mean()" and "std()" meet this criteria. I used the "gprep" function to select the column names that meet have this terms in their name. The selected columns are stored in a vector named "selcol" with a length of 66. The dataframe "samdat1" has the merged file with the extracted measurement data.  
**Step 3**  
I renamed activity data from code to named activity. This was achieved by matching the activity code in "samdat1" with the corresponding activity in the "activity" code file. I also convert the activities to lower case letters and remove the "-" using the "gsub" function.  
**Step 4**  
In this step, I appropriately label the data set with descriptive variable names. To follow the convention of good variable names discussed in the class and the forums, I removed "-","()". I expanded "t" to "time", "f" to "frequency","mag" to "magnitude","std" to "stddev","Acc" to "accel". I also corrected a mistake in the original features  name from "BodyBody" to "Body".  I also converted all the variable names to lower case. I used the "gsub" function on the column names variable called "cnames".  File "samdat1" is the first tidy set datafile requested in the project. It has 10299 rows and 68 columns. The data set meets the following 3 requirements of a tidy data set discussed by Hadley Wickham in his paper http://vita.had.co.nz/papers/tidy-data.pdf.  
1. Each variable forms a column.  
2. Each observation forms a row.  
3. Each type of observational unit forms a table.  
The accompanying "CodeBook.md" file provides a codebook for first tidy set file "samdat1"  
**Step 5**  
 In this step I create a second, independent tidy data set with the average of each variable for each activity and each subject. This is achieved in the script with the help of the "aggregate" function that computes the "mean" over the variable names "activity" and "subject" in the "samdat1" file starting from columns 3 to 68. The output from the "aggregate" function is a 180x68 dataframe called "samdat2".  The "samdat2" file has "subject" as the first column, followed by"activity" and then the calculated averages of the "mean" and "std deviation" attribute variables. It has 180 rows and 68 columns. It represents a tidy data set because it meets the 3 requirements of a tidy data set outlined n Hadley Wickham's paper referenced in step 4. The data is written as a text file called "samsung2.txt".  This file is to be opened with the read.table function with the option of header=TRUE.
