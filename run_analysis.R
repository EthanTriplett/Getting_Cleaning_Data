setwd("C:/Users/et86714/Desktop/Coursera/3_Getting_and_Cleaning_Data/Course_Project/UCI HAR Dataset")
activity_labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")
features

extract_col_label <- as.character(features$V2)
extract_col_label

setwd("C:/Users/et86714/Desktop/Coursera/3_Getting_and_Cleaning_Data/Course_Project/UCI HAR Dataset/train")
subject_train <- read.table("subject_train.txt")
colnames(subject_train) <- "subject_number"

table(subject_train)
X_train <- read.table("X_train.txt")

for (i in 1:ncol(X_train)){
  colnames(X_train)[i] <- extract_col_label[i]
}

Y_train <- read.table("Y_train.txt")
head(Y_train, n = 100)
table(Y_train)

library(dplyr)
map_Y_train <- left_join(Y_train, activity_labels)
head(map_Y_train, n = 100)
colnames(map_Y_train) <- c("activity_code", "activity_description")
head(map_Y_train)
dim(map_Y_train)
full_train_dataset <- cbind(subject_train, map_Y_train, X_train)
View(full_train_dataset)

## End train start test



setwd("C:/Users/et86714/Desktop/Coursera/3_Getting_and_Cleaning_Data/Course_Project/UCI HAR Dataset/test")
subject_test <- read.table("subject_test.txt")
colnames(subject_test) <- "subject_number"

table(subject_test)
X_test <- read.table("X_test.txt")

for (i in 1:ncol(X_test)){
  colnames(X_test)[i] <- extract_col_label[i]
}

Y_test <- read.table("Y_test.txt")

map_Y_test <- left_join(Y_test, activity_labels)

colnames(map_Y_test) <- c("activity_code", "activity_description")
head(map_Y_test)

full_test_dataset <- cbind(subject_test, map_Y_test, X_test)
View(full_test_dataset)


