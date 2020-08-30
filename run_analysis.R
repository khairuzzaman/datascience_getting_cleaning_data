
mergeData <- function(){
    training_set <- read.table('X_train.txt', 
                               header = FALSE, sep = "", dec = ".")
    test_set <- read.table('X_test.txt', 
                           header = FALSE, sep = "", dec = ".")
    
    data <- rbind(training_set, test_set)
}

extractMeasurement <- function(){
    data <- mergeData()
    
    features <- read.table('features.txt', 
                           header = FALSE, sep = "", dec = ".")
    
    # column index of mean & std
    columns <- features[grepl("\\bmean()\\b|\\bstd()\\b", 
                               features$V2), 1]
    
    # select only mean & std variables
    data[, columns]
}

setActivityName <- function(){
    
    training_activity <- read.table('y_train.txt', 
                               header = FALSE, sep = "", dec = ".",
                               col.names = c("activity"))
    test_activity <- read.table('y_test.txt', 
                           header = FALSE, sep = "", dec = ".", 
                           col.names = c("activity"))
    
    # make activity data frame
    activity <- rbind(training_activity, test_activity)
    
    # append activity with original data frame
    data <- extractMeasurement()
    data <- cbind(data, activity)
    
    # may be there is alternative way to efficiently do this
    # need to refactor later
    data[data$activity == 1, c("activity")] = 'WALKING'
    data[data$activity == 2, c("activity")] = 'WALKING_UPSTAIRS'
    data[data$activity == 3, c("activity")] = 'WALKING_DOWNSTAIRS'
    data[data$activity == 4, c("activity")] = 'SITTING'
    data[data$activity == 5, c("activity")] = 'STANDING'
    data[data$activity == 6, c("activity")] = 'LAYING'
    
    data <- data
    
}

setVariableNames <- function(){
    features <- read.table('features.txt', 
                           header = FALSE, sep = "", dec = ".")
    
    # column name of mean & std
    columns <- features[grepl("\\bmean()\\b|\\bstd()\\b", 
                              features$V2), 2]
    #append a new column
    columns <- append(columns, "activity")
    
    # get the data with activity name
    data <- setActivityName()
    
    # rename column names
    names(data) = columns
    
    data <- data
}

setSubject <- function(){
    training_subject <- read.table('subject_train.txt', 
                                    header = FALSE, sep = "", dec = ".",
                                    col.names = c("subject"))
    test_subject <- read.table('subject_test.txt', 
                                header = FALSE, sep = "", dec = ".", 
                                col.names = c("subject"))
    
    # make activity data frame
    subject <- rbind(training_subject, test_subject)
    
    # append activity with original data frame
    data <- setVariableNames()
    data <- cbind(data, subject)
}

tidy_data_with_summary <- function(){
    library(dplyr)
    
    data <- setSubject()
    tbl_data <- as_tibble(data)
    
    tbl_data %>%
        group_by(subject, activity) %>%
        summarise_each(lst(mean))
    
    write.table(tbl_data, 'HAR_tidy.txt', row.names = FALSE)
}

