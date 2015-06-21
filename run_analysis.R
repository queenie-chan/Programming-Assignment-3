# The following script manipulates data sets downloaded from:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip,
# description at:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#
# The script was designed to run from the working directory of the unzipped
# "UCI HAR Dataset" folder (which contains files [activity_labels.txt, 
# features.txt]) and folders [test, train] that contain data described on the 
# website above and the codebook.
#
# For a detailed explanation on what the following script does, see the README file.
######################################################################################
######################################################################################

# Setup: clear environment, define relabel function used in script
rm(list=ls())
relabel <- function(dataSet) {
    ## Labels 'Activity' column in dataSet with description from "activity_labels.txt"
    ## Returns dataSet with relabeled 'Activity' column
    
    labelLookup <- read.table("./activity_labels.txt",stringsAsFactors = F)[,2]
    
    for (i in seq(labelLookup)) {       # for each activity index, replace with
        dataSet[dataSet$Activity == i, 'Activity'] <- labelLookup[i]     # text
    }
    return(dataSet)
}

###########################################################
### Import and merge datasets, IDs, and Activity labels ###
###                     (Steps 1-4)                     ###
###########################################################

#[Data] Import datasets' means and stdevs (cols 1:6)
raw_test <- read.table("./test/X_test.txt", header=F)[,1:6]     #raw test data
raw_train <- read.table("./train/X_train.txt",header=F)[,1:6]   #raw train data
#[Data] Combine datasets and name columns
raw_data <- rbind(raw_test, raw_train)      #combine- test, train
features <- read.table("./features.txt",stringsAsFactors = F)[,2]
colnames(raw_data) <- features[1:6]

#[ID] Import, combine, name subject ID data (to be added as column)
subjs_test <- read.table("./test/subject_test.txt", header=F)
subjs_train <- read.table("./train/subject_train.txt", header=F)
subjs <- rbind(subjs_test, subjs_train)     #combine- same order (test, train)
colnames(subjs) <- c("ID")

#[Activity] Import, combine, replace Activity number indices with text labels
labels_test <- read.table("./test/Y_test.txt", header=F)
labels_train <- read.table("./train/Y_train.txt", header=F)
labels <- rbind(labels_test, labels_train)  #combine- same order (test, train)
colnames(labels) <- c("Activity")
labels <- relabel(labels)   #UDF replaces int labels with descriptive labels

### Combine columns:  ID, Activity, dataset
data <- cbind(subjs,labels,raw_data)
data <- data[order(data$ID),]


####################################################################################
### Tidy Dataset showing avg of each variable for each activity and each subject ###
###                                     (Step 5)                                 ###
####################################################################################
library(reshape2)

# Melt data into narrow format. Features listed out under "variable" column
dataMelt <- melt(data, id=c("ID","Activity"),measure.vars= features[1:6])

# Recast melted data to wide format. Reports average of each measure for each 
# action from each subject. 
    # (180 rows: 30 subjects * 6 actions per subject)
    # (8 cols: 2 identifiers + 6 variables(features))
dataCast <- dcast(dataMelt, ID + Activity ~ variable, fun.aggregate = mean)

# Modify column names
colnames(dataCast) <- c("ID", "Activity", "tBodyAccMeanX.Mean", 
                        "tBodyAccMeanY.Mean","tBodyAccMeanZ.Mean",
                        "tBodyAccStdX.Mean","tBodyAccStdY.Mean",
                        "tBodyAccStdZ.Mean")

# Write tidy data table to txt file (dataOut.txt)
write.table(x = dataCast,file = "./dataOut.txt",row.names = FALSE)
