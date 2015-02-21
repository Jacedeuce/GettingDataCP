##Load packages for script
library(dplyr)
library(tidyr)

## set function
run_analysis <- function() {

  ## store the working directory for later
  wd <- getwd()

  ## read the "features.txt" to create column names for "x" and select "mean" and "std" computations
  features <- read.table("./UCI HAR Dataset/features.txt")

  ## change working directory to read "test" data
  setwd("./UCI HAR Dataset/test")

    ## read 3 "test" data files to temporary variables in order to combine them
    s_test <- read.table("subject_test.txt", header = FALSE, col.names = "Subject", stringsAsFactors=FALSE)
    y_test <- read.table("y_test.txt", header = FALSE, col.names = "Activity", stringsAsFactors=FALSE)
    x_temp <- read.table("x_test.txt", header = FALSE, col.names = features[,2], stringsAsFactors=FALSE)

    ## Use GREP to select only the "mean" and "std" values from the "x_test.txt"
    x_test <- x_temp[,grep("mean\\(\\)|std\\(\\)", features[,2])]
    
      ## remove temp variable
      rm(x_temp)

    ## Combine "test" datasets
    test <- cbind(s_test, y_test, x_test)
    
      ## Unload "test" temp variables
      rm(s_test)
      rm(x_test)
      rm(y_test)

  ##change working directory to read "train" data
  setwd(paste(wd, "/UCI HAR Dataset/train", sep = ""))

    ## read 3 "train" data files to temporary variables in order to combine them
    s_train <- read.table("subject_train.txt", header = FALSE, col.names = "Subject", stringsAsFactors=FALSE)
    y_train <- read.table("y_train.txt", header = FALSE, col.names = "Activity", stringsAsFactors=FALSE)
    x_temp <- read.table("x_train.txt", header = FALSE, col.names = features[,2], stringsAsFactors=FALSE)

    ## Use GREP to select only the "mean" and "std" values from the "x_test.txt"
    x_train <- x_temp[,grep("mean\\(\\)|std\\(\\)", features[,2])]
    
      ## remove temp variable
      rm(x_temp)

    ## Combine "test" datasets
    train <- cbind(s_train, y_train, x_train)
  
      ## Unload "train" temp variables
      rm(s_train)
      rm(x_train)
      rm(y_train)

  ## reset the working directory
  setwd(wd)

  ## Combine "train" and "test" dataframes 
  data <- rbind(train, test)

  ## Clean column names by removing periods that were substituted by read.table for special characters 
  names(data)  <- gsub("\\.", "", names(data))

  ## Read in "activity_labels.txt" in order to replace numerical factor with descriptive "Activity" values
  activity <- read.table(paste(wd, "/UCI HAR Dataset/activity_labels.txt", sep = ""), stringsAsFactors = FALSE)

    ## For loop to replace values
    for(i in 1:6){
      data$Activity[data$Activity == i] <- activity[i, 2]
    }

  write.table(data, file = "CombinedData_Analysis.txt", row.name=FALSE)

  ## Use dplyr to group data by "Subject" and "Activity" and calculate means for each.  
  grouped <- data %>% group_by(Subject, Activity) %>%
    summarise_each(funs(mean)) %>%
    ## Use tidyr to gather measurement columns and combine into two variables
    gather(measure, mean, -Subject, -Activity)

  ## Output tidy data table of means of the measurements for each subject and activity
  write.table(grouped, file = "TidyRun_Analysis.txt", row.name=FALSE)
}