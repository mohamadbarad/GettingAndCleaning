# Date <-  "2021-12-10"
# Author <- "Mohamad Barad"
# Course <- Getting and Cleaning data, By Coursera 
# Version <- v1.0

# This script does:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each 
#    measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.


# cleaning variable environment and graphics 
rm(list=ls())
graphics.off()

# Loading packages
library(dplyr)
library(stringr)

# Reading data
getwd()
setwd("C:/Users/Moham/Desktop/DataScience/03Getting_and_cleaning/Week4/CourseProject/UCI HAR Dataset/GettingAndCleaning/")
test_x <- read.table("data/test/X_test.txt",header = FALSE)
test_y <- read.table("data/test/y_test.txt",header = FALSE)
test_sub <- read.table("data/test/subject_test.txt",header = FALSE)

train_x <- read.table("data/train/X_train.txt",header = FALSE)
train_y <- read.table("data/train/y_train.txt",header = FALSE)
train_sub <- read.table("data/train/subject_train.txt",header = FALSE)


# 1. Merges the training and the test sets to create one data set. --------
# preparing the test data sets
test_com <- test_x %>% 
        mutate(activity = as.character(test_y[[1]]),
               subjects = as.character(test_sub[[1]]),
               dataset  = "test") %>% 
        arrange(subjects) %>% 
        select(subjects,activity,dataset,everything())

# perparing the train data set
train_com <- train_x %>% 
        mutate(activity  = as.character(train_y[[1]]),
               subjects  = as.character(train_sub[[1]]),
               dataset   = "train") %>% 
        arrange(subjects) %>% 
        select(subjects,activity,dataset,everything())

# combining the test and training datasets
data <- rbind(test_com, train_com)

# sorting the combined data set according to subjects and then activity type
data <- data %>%
        select(-dataset) %>% 
        arrange(subjects,activity)

# removing unused data sets to free up some memory
rm(train_x,test_x,train_y,test_y,test_sub,train_sub,test_com,train_com)


# 2. Extracts only the measurements on the mean and standard devia --------
# loding the explanatory data set for the variables 
varExp <- read.table("data/features.txt",header = FALSE)

# defining the measurement variables of interest
meas1 <- "mean()"
meas2 <- "std()"

# Finding them in the "fearures.txt" file
filtered1 <- varExp[str_detect(varExp[[2]],meas1),]
filtered2 <- varExp[str_detect(varExp[[2]],meas2),]

# subsetting the main dataset to only include the "mean" and "std" 
data2 <- data[,c("subjects","activity",
                            paste0("V",sort(c(filtered1$V1,filtered2$V1))))]


# 3. Uses descriptive activity names to name the activities in the --------
varAct <- read.table("data/activity_labels.txt",header = FALSE)
colnames(varAct)[2] <- "activity"
data2$activity <- varAct$activity[match(data2$activity,varAct$V1)]


# 4. Appropriately labels the data set with descriptive variable names --------

colnames(data2)[4:length(data2)] <- varExp$V2[match(substring(names(data2[,4:length(data2)]),2),varExp$V1)]

# 5. From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject. --------
data3 <- data2 %>% 
        group_by(subjects, activity) %>%
        summarise_at(vars(-group_cols()), mean,na.rm = TRUE)

rm(filtered1,filtered2,varExp,varAct)
