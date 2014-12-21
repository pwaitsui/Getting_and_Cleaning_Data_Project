# run_analysis.R
#
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each
#    measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.

# setwd("~/Documents/Getting_and_Cleaning_Data")

# Setting up directory structure
data_dir <- "UCI HAR Dataset/"
activity_labels_file <- paste0(data_dir, "activity_labels.txt")
feature_file <- paste0(data_dir, "features.txt")
x_train_file <- paste0(data_dir, "train/X_train.txt")
y_train_file <- paste0(data_dir, "train/y_train.txt")
subject_train_file <- paste0(data_dir, "train/subject_train.txt")
x_test_file  <- paste0(data_dir, "test/X_test.txt")
y_test_file  <- paste0(data_dir, "test/y_test.txt")
subject_test_file <- paste0(data_dir, "test/subject_test.txt")

# Loading raw data
activity_labels <- read.table(activity_labels_file)
features <- read.table(feature_file)
x_train <- read.table(x_train_file)
y_train <- read.table(y_train_file)
subject_train <- read.table(subject_train_file)
x_test <- read.table(x_test_file)
y_test <- read.table(y_test_file)
subject_test <- read.table(subject_test_file)

# Combining train and test data by rows
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
s <- rbind(subject_train, subject_test)

# Removing unnecessary features index
features <- features[,2]
# Getting the indices of mean and std on the feature list
mean_std_index <- grep("-mean\\(\\)|-std\\(\\)", features) 
x <- x[, mean_std_index]
# Labeling Columns with Features, removing parenthesis at the same time
names(x) <- gsub("\\(|\\)", "", (features[mean_std_index]))
names(x) <- gsub("BodyBody", "Body", names(x))  # Removing duplicate body
names(x) <- gsub("^t", "Time", names(x))        # replacing "t" by "Time"
names(x) <- gsub("^f", "Freq", names(x))        # replacing "f" by "Freq"


# Labeling columns with features and activities
y[,2] = activity_labels[,2][y[,1]]
names(activity_labels) = c("activity_id", "activity")
names(y) = c("activity_id", "activity")
names(s) = "subject"

# Binding all the parts together
data <- cbind(s, y, x)

# Cleaning up unused variables
rm(data_dir, activity_labels_file, feature_file,
   x_train_file, y_train_file, subject_train_file,
   x_test_file, y_test_file, subject_test_file,
   mean_std_index)

# Cleaning up unused data frames
rm(features, activity_labels,
   x_train, y_train, subject_train,
   x_test, y_test, subject_test,
   x, y, s)

if(!require(dplyr)){
    install.packages("dplyr")
    library(dplyr)
}

data <- data %>%
    select(-activity_id) %>%
    group_by(subject,activity) %>%
    summarise_each(funs(mean))
    
write.table(data, "./tidy_output.txt",row.names=FALSE)
