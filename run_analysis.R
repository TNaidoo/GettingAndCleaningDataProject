# Load relevant libraries
library(dplyr)
library(tidyr)
library(reshape2)
library(stringr)

# Download Data and Unzip
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "projectData.zip", method = "curl")
unzip("projectData.zip")
rm(url)

loadData <- function(dataFile){
    dt <- read.table(dataFile, header = FALSE, sep = "")
}

# Load the Test Data
xtest <- loadData("./UCI HAR Dataset/test/X_test.txt")
ytest <- loadData("./UCI HAR Dataset/test/y_test.txt")
stest <- loadData("./UCI HAR Dataset/test/subject_test.txt")
test <- cbind(stest, ytest, xtest)
rm(xtest, ytest, stest)

# Load the Training Data
xtrain <- loadData("./UCI HAR Dataset/train/X_train.txt")
ytrain <- loadData("./UCI HAR Dataset/train/y_train.txt")
strain <- loadData("./UCI HAR Dataset/train/subject_train.txt")
train <- cbind(strain, ytrain, xtrain)
rm(xtrain, ytrain, strain)

# Get Headings for Data
features <- loadData("./UCI HAR Dataset/features.txt")
features <- as.character(features$V2)

# Combine All Data
allData <- rbind(train, test)
colnames(allData) <- c("Subject", "Activity", features)
rm(train, test, features)

# Extract Means & Standard Deviations
selectCol <- grep(".*mean\\(\\)*|.*std*", names(allData))
tidyDataset <- allData[,c(1,2,selectCol)]
rm(allData, selectCol)

# Get Activity Names
activities <- loadData("./UCI HAR Dataset/activity_labels.txt")
activities[,2] <- gsub("_","", tolower(activities[,2]))

# Add descriptive names for Activity - convert Activity to Factor with levels
tidyDataset$Activity <- as.factor(tidyDataset$Activity)
levels(tidyDataset$Activity) <- activities[,2]
rm(activities)

# Convert Headings to be Meaningful
colnames(tidyDataset) <- colnames(tidyDataset) %>%
    tolower() %>%
    str_replace("^t", "time_") %>%
    str_replace("^f", "freq_") %>%
    str_replace("acc", "_acc_") %>%
    str_replace("gyro", "_gyro_") %>%
    str_replace("-std\\(\\)", "std") %>%
    str_replace("-mean\\(\\)", "mean") %>%
    str_replace("jerk", "jerk_") %>%
    str_replace("mag", "mag_") %>%
    str_replace("-x", "_x") %>%
    str_replace("-y", "_y") %>%
    str_replace("-z", "_z") %>%
    str_replace("bodybody", "body")

tidyData2 <- melt(tidyDataset, id=c("subject", "activity"), measure.vars=names(tidyDataset)[3:length(names(tidyDataset))])
tidyData2 <- dcast(tidyData2, subject + activity ~ variable, mean)

write.table(tidyData2, file="tidy_data.txt", row.names=FALSE)
