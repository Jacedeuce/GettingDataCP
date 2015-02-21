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

###Reference the CodeBook.md for more detail on the output data and the transformations performed.
