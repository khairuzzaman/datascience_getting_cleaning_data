This repository is the project work of Getting & Cleaning Data for the data science course. This repository contains a R file run_analysis.R. Below is the details of the script.

The R Script contains the below function:
======================================

- mergeData: This function merge the test & train data set in a single data frame.
- extractMeasurement: This function extract only mean and standard deviation variable from the data frame prepared by mergeData. 
- setActivityName: This function replace the numeric activity name by more readable name. 
- setVariableNames: This function replace all the variables name with the more readable name. 
- setSubject: This function append the subject variable in the data frame.
- tidy_data_with_summary: This is the final function which create the tidy data set.

