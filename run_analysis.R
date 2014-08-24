run_analysis <- function() {
        ## Read data files
        ## The downloaded data should be extracted into a directory under the
        ## current working directory.
        ## Data should be left in the extracted subdirectories.        
        
        ## X data sets are the sets of observations
        x_data_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
        x_data_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
        
        ## y data sets provide information on the activities related to the data
        ## in set X
        y_data_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
        y_data_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
        
        ## The subject files contain information on which subject was observed
        sub_data_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
        sub_data_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
        
        ## the file features is read and transposed to create the data labels
        ## for the observation data.
        data_labels <- t(read.table("./UCI HAR Dataset/features.txt"))
        
        ## md will represent our merged data set
        md <- x_data_train
        ## set column names of the merged data set using the features.txt file
        colnames(md) <- tolower(data_labels[2,])
        ## add column names for the subject and activity        
        colnames(sub_data_train) <- "subject"
        colnames(y_data_train) <- "activity"
        ## add the subject and activity data as columns in the data frame        
        md <- cbind(md,sub_data_train)
        md <- cbind(md,y_data_train)
        
        ## do the same things with the test data
        md_test <- x_data_test
        colnames(md_test) <- tolower(data_labels[2,])
        colnames(sub_data_test) <- "subject"
        colnames(y_data_test) <- "activity"
        md_test <- cbind(md_test,sub_data_test)
        md_test <- cbind(md_test,y_data_test)

        
        ## combine the training and test data
        md <- rbind(md,md_test)
        
        ## subset the data that includes mean and standard deviation data
        md_mean <- md[,grepl("mean",names(md))]
        md_std <- md[,grepl("std",names(md))]
        
        ## combine the data mean and standard deviation data with the 
        ## subject and activity columns.
        md2 <- cbind(md_mean,md_std,subject = md$subject,activity = md$activity)
 
        ## read activity names
        
        act_names <- read.table("./UCI HAR Dataset/activity_labels.txt")
        
        ## define function to apply names and use sapply to replace numbers
        ## with names form the activity labels
        
        apply_names <- function(x,y) {y[x]}
        
        md2$activity <- sapply(md2$activity,apply_names,act_names$V2)
        
        ## Count the number of data columns
        ## Then aggregate using the mean function by the activity and subject
        sub_count <- ncol(md2) - 2
        agg_data <- aggregate(x = md2[,1:sub_count], by = list(md2$activity,
                md2$subject),FUN="mean")
        
        ## rename the activity and subject columns
        agg_names <- colnames(agg_data)
        agg_names[1] <- "activity"
        agg_names[2] <- "subject"
        colnames(agg_data) <- agg_names
        
        ## Output tidy data set to file.
        write.table(agg_data,"./tidyoutput.txt",row.name=FALSE)
        
        return(agg_data)
}