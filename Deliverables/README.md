Coursera Getting and Cleaning Data Course Project
=================================================

Overview and Purpose
--------------------

The file "run_analysis.R" contains code that accomplishes the following:


1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names. 

5. From the data set in step 4, creates a second, independent tidy data set with the average 
of each variable for each activity and each subject.

File Structure
--------------

The script is organized into the following sections

* Import data from [a website](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

* Join in column descriptions

* Execute the same preparation for both Train and Test

* combine Train and Test

* Generate the measurements in bullet 2, above.

* Label the columns appropriately.

* Create the tidy data set for export.

Coding detail
-------------

For a detailed description of the coding steps, please see the codebook "Codebook.txt", which is available in the github
repository.