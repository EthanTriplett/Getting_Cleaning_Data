## This code extracts data from this location: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## It then carries out the following steps:

## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Set working directory

setwd("C:/Users/et84675/Desktop/Coursera/3_Getting_and_Cleaning_Data/Course_Project/UCI HAR Dataset")

## Import activity labels

activity_labels <- read.table("activity_labels.txt")

## Import features

features <- read.table("features.txt")

## Extract column labels

extract_col_label <- as.character(features$V2)

## Import train data sets

setwd("C:/Users/et84675/Desktop/Coursera/3_Getting_and_Cleaning_Data/Course_Project/UCI HAR Dataset/train")
subject_train <- read.table("subject_train.txt")

## Add column label to subjects
colnames(subject_train) <- "subject_number"
table(subject_train)

X_train <- read.table("X_train.txt")

Y_train <- read.table("Y_train.txt")

library(dplyr)

## Join in activity label (e.g. Sitting, Standing) based on activity code

map_Y_train <- left_join(Y_train, activity_labels)

## Add names to dataset

colnames(map_Y_train) <- c("activity_code", "activity_description")

## Combine subject information, activity information, and analytical data into single set

full_train_dataset <- cbind(subject_train, map_Y_train, X_train)

## Import test data sets

setwd("C:/Users/et84675/Desktop/Coursera/3_Getting_and_Cleaning_Data/Course_Project/UCI HAR Dataset/test")
subject_test <- read.table("subject_test.txt")
colnames(subject_test) <- "subject_number"

X_test <- read.table("X_test.txt")
Y_test <- read.table("Y_test.txt")

map_Y_test <- left_join(Y_test, activity_labels)

colnames(map_Y_test) <- c("activity_code", "activity_description")

full_test_dataset <- cbind(subject_test, map_Y_test, X_test)

## 1. Merge the training and test sets to create one data set.

full_dataset <- rbind (full_train_dataset, full_test_dataset)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.

drop_non_numeric <- c("subject_number", "activity_code", "activity_description")
full_dataset_variables <- full_dataset[,!(names(full_dataset) %in% drop_non_numeric)]

measurement_mean <- sapply(full_dataset_variables, mean)

measurement_sd <- sapply(full_dataset_variables, sd)

measurement_mean_and_sd <- cbind(measurement_mean, measurement_sd)

for (i in 1:nrow(measurement_mean_and_sd)){
  rownames(measurement_mean_and_sd)[i] <- extract_col_label[i]
}

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

measurement_mean_and_sd

TableX <- aggregate(full_dataset$V1, list(full_dataset$subject_number, full_dataset$activity_description), FUN = mean)
TableX

## Pull off just the Subject_Number and Activity_Label

df = data.frame(TableX$Group.1, TableX$Group.2)

## Define the number of columns over which we'll need to cycle
n_cols <- ncol(full_dataset) - 3

## Label the columns
for (i in 1:n_cols) {
  temp_table <- aggregate(full_dataset[,i+3], list(full_dataset$subject_number, full_dataset$activity_description), FUN = mean)
  df <- cbind(df,temp_table$x)
}
  
## Extract the first two columns (Subject_Number and Activity_Label)

df_first_part <- cbind(df[,1],df[,2])

## Extract the data columns, i.e. all but the first two columns
drops <- c("TableX.Group.1", "TableX.Group.2")
df_second_part <- df[,!(names(df) %in% drops)]

## 3. uses descriptive activity names to name the activities in the data set

colnames(df_first_part) <- c("Subject_Number", "Activity_Label")

## 4. Appropriately labels the data set with descriptive variable names.

for (i in 1:ncol(df_second_part)){
  colnames(df_second_part)[i] <- extract_col_label[i]
}

tidy_data_set = cbind(df_first_part, df_second_part)

setwd("C:/Users/et84675/Desktop/Coursera/3_Getting_and_Cleaning_Data/Course_Project/Deliverables")

## 5. From the data in step 4, creates a second, independent tidy data set with the average
## of each variable for each activity and each subject.

write.table(tidy_data_set, file = "tidy_data_set.txt", sep = ",", row.names = FALSE)
