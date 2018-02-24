# GettingAndCleaningDataProject
Project for the Coursera Getting and Cleaning Data course
## Introduction
The data used in this project was based on human activity recognition using smartphones. The experiment was carried out with 30 volunteers between the ages of 19 and 48 years old. Each volunteer performed six activities whilst wearing a smartphone: walking, walking upstairs, walking downstairs, sitting, standing, and laying). The data has been supplied courtesy of:  
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.  
Smartlab - Non Linear Complex Systems Laboratory  
DITEN - Università degli Studi di Genova.  
Via Opera Pia 11A, I-16145, Genoa, Italy.  
activityrecognition@smartlab.ws  
www.smartlab.ws  
## Requirements
Please ensure that the relevant packages are installed: dplyr, tidyr, reshape2, stringr  
The data should be unzipped to a folder called "UCI HAR Dataset"
## References
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
## Procedure
- The data is downloaded via the url: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
- The raw data is loaded into the environment
- Data from the training and test sets are combined into a single set of data
- Columns labels are inserted: "Subject", "Activity", and relevant labels provided in the "features.txt" file
- The mean and standard deviation for each variable was extracted into a new dataset. Note: In this case only the mean() and std() results were extracted according to the description of the variables provided in the features_info file
- Column labels were formatted to be more meaningful
- A set of tidy data was produced containing the average of each variable (as specified in the Codebook) for each subject and each activity: called tidyData2
