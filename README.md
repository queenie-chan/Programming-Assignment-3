## Getting and Cleaning Data, Coursera assignment
Queenie Chan, 21 June 2015

### Intro
The following README file describes the analysis process in the run_analysis.R script.

The run_analysis.R script manipulates data sets downloaded from [UCI's Human Activity Recognition data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) (full description at [this link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).) The data measures the activity data from 30 subjects performing 6 different tasks.

The working directory for the run_analysis.R script should be the unzipped "UCI HAR Dataset" folder (which contains files [activity_labels.txt, features.txt]) and folders [test, train] that contain data described on the website above and the codebook.

### Script Description
#### Pre-analysis Setup
The first part of the script sets up the analysis by clearing the global environment and providing the code for the 'relabel' function. 'relabel' is called in the script to replace the Activity integers (e.g. 1, 2, 6) in the raw data with the corresponding descriptive labels  (e.g. WALKING, WALKING_UPSTAIRS, LAYING), as laid out in the 'activity_labels.txt' file of the downloaded data.


#### Import and merge datasets
The second part of the script aims to obtain a dataset that merges the 'test' and 'training' data on the mean and standard deviation of each measurement.

Once the first six columns of the 'X_test.txt' and 'X_train.txt' tables (which report the mean and standard deviation of the body acceleration data in the X,Y,Z directions: mean-X, mean-Y, mean-Z, std-X, std-Y, std-X) are imported, the script combines the two datasets via rbind, placing test data on the top, followed by train data. The 'features.txt' file, which dictates the data set variables, is then imported and applied to the merged data as column names.

Next, a similar process is repeated for the subject ID data, combining 'subject_test.txt' with 'subject_train.txt' (test on top). The column is named "ID".

The process is then repeated again for the Activity data, combining 'Y_test.txt' with "Y_train.txt" (test on top). The column is named "Activity", then the 'relabel' function is called to replace the Activity indicies with descriptive labels. 'relabel' cycles through the Activity indicies in the 'activity_labels.txt' file and replaces the instances of each index in the Activity column with the corresponding descriptive label.

Now that the test and training datasets for the measurements, ID, and Activity have been combined, the columns are cbind-ed to form the full merged dataset and ordered by subject in ascending order.


#### Tidy Dataset 
To generate a text file that meets the principles of tidy data (see "vita.had.co.nz/papers/tidy-data.pdf" for Hadley Wickham's paper on Tidy Data) and shows the average of each activity for each subject, the data set created in the previous step ('data') must be "melted" and "recast" via the functions in the reshape2 library.

The first step is to melt 'data' into the narrow form of data with ID and Activity as identifiers and the variables as the first 6 'features'. The result is saved in 'dataMelt'.

The next step recasts 'dataMelt' into the wide form of data using the dcast function, with ID and Activity serving as identifiers for reporting the aggregated mean of each variable. The column names are renamed to clarify that the variables are the means of the mean and standard deviation measurements of the body's acceleration, and the resulting table is written to the 'dataOut.txt' file.

The 'dataOut.txt' file can be read into R via the following code:
`
tidyData <- read.table("./dataOut.txt",header = TRUE)
`

------
For more detailed descriptions of the variables in the tidy dataset output ('dataOut.txt'), see the codebook.    
