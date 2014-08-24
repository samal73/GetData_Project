GetData_Project
===============

Coursera Get Data Course Project

This code reads the Samsung data set from a set of folders found in UCI HAR Dataset directory of the working directory.  The code reads the X, y and subject files from both the train and test subfolders.  Additionally the file uses the file files features.txt and activity_labels.txt to provide the names for the columns and the activities.  These files should be in the UCI HAR Dataset directory.

A variable md is created to represent the merged data set.  The set is initiallized by setting it equal to the training data observations from the file X_train.txt.  The columns are then named using the lower case value of the names in the features.txt file.  Column names are given the values read for the y_train.txt and subject_train.txt files.  The subject and activity columns are added to the md data frame using cbind to add the columns at the end. The same is done for the test data using the md_test variable.

The two data frames are combined to provdie a merged data set including the training and testing data as well as the subject and activity information.  The two data frames are combined using the rbind function.

Next the data is subset to include only the mean and standard deviations of the measurments.  This is done by using the grepl command to look for the column names that contain "mean" and again to find the column names that contain "std".  Finally these two data sets are recomined to provide all of the measurmenst with mean and standard deviation plus the subject and activity data.  This is accomplished with the cbind function.

The names of the activities that coorespond with the activity numbers is read from the file activity_labels.txt.  A function is created to replace the value with the corresponding activity name.  This is accomplished using the sapply function across the activity column of the data frame.

This tidy data frame is out put to the file tidyoutput.txt using the write.table function.  The details of the variables can be found in the codebook.MD file.  The data is tidy because it meets the definition (1. Each variable forms a column, 2. Each observation forms a row, and 3. Each type of observational unit forms a table) as put forth in the lecture and in the paper <i>Tidy Data</i> by Hadley Wickham.  (http://vita.had.co.nz/papers/tidy-data.pdf)
