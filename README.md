## Getting and Cleaning Data project

#Overview
In this project, data collected from the accelerometer and gyroscope of the Samsung Galaxy S smartphone was retrieved, worked with, and cleaned, to prepare a tidy data that can be used for later analysis. This project has serves to demonstrate the collection and cleaning of a tidy data set that can be used for subsequent analysis.

This repository contains the following files:

- `README.md`, this file, which provides an overview of the data set and how it was created.
- `tidy_Data.txt`, which contains the data set.
- `CodeBook.md`, the code book, which describes the contents of the data set (data, variables and transformations used to generate the data).
- `run_analysis.R`, the R script that was used to create the data set 'tidy_data'

## Creating the data set <a name="creating-data-set"></a>

The R script `run_analysis.R` can be used to create the data set. 

- Download and unzip source data if it doesn't exist.
- Read data.
- Merge the training and the test sets to create one data set.
- Extract only the measurements on the mean and standard deviation for each measurement.
- Use descriptive activity names to name the activities in the data set.
- Appropriately label the data set with descriptive variable names.
- Create a second, independent tidy set with the average of each variable for each activity and each subject.
- Write the data set to the `tidy_data.txt` file.

The `tidy_Data.txt` in this repository was created by running the `run_analysis.R` script using R version 3.4 on Windows 10 64-bit edition.

