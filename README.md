Coursera Course Project "Getting and Cleaning Data" Script
===========================================================

*This script will take the separate data files contained in the UCI HAR Dataset, combine them and calculate means of each measurement for each Subject and Activity.*

**In order to run "run_analysis.R" you must have dplyr and tidyr packages installed in your version of R.**

##Steps to run script (run_analysis.R)
1. Download UCI HAR Dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
2. Move Dataset zip file to your R working directory and extract files
3. In R, source the run_analysis.R file *source("run_analysis.R)*
4. Call function "run_analysis" *run_analysis()*
5. Output will be written to your working directory as **"CombinedData_Analysis.txt"** (intermediate combined data) and **"TidyRun_Analysis.txt"** (Final tidy dataset)

####Reference the CodeBook.md for more detail on the output data and the transformations performed.

###Details of script
*Loads dplyr and tidyr packages
*sets ""run_analysis" function
*reads separate data files into temporary variables using read.table using **grep()** to select only the "mean" and "std" measures
*combines temporary variables into "test" and "train" dataframes using **cbind()**
*removes temporary variables
*uses **rbind()** to combine "test" and "train" dataframes
*cleans column names with gsub() removing periods
*replaces numerical factor in "Activity" column with descriptive values
*outputs combined data to "CombinedData_Analysis.txt" to working directory
*uses *dplyr* **group_by()** to group data by "Subject" and "Activity"
*calculates the mean for each "Subject" and "Activity" using **summarise_each()**
*gathers the measure columns to combine into "measure" and "mean" variables using *tidyr* **gather()**
*outputs tidy dataset as "TidyRun_Analysis.txt" to working directory