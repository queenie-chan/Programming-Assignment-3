## Codebook
This codebook describes the variables and data resulting from the run_analysis.R script, written into the 'dataOut.txt' file.

-----
The tidy data set reports the average measurements of average body acceleration and standard deviation of body acceleration for each activity performed for each subject, totaling 180 observations of 8 variables:

*  Observations: 
    + 30 subjects, each with 6 activities to result in 180 total observations
        - Activities include LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS
*  8 variables consisting of:
    + 2 identifiers: 
        - subject's ID (1-30) indicating which subject performed the activity
        - Activity (e.g. LAYING) indicating activity performed
    + 6 normalized measurements in the time domain of body acceleration, *averaged* for each subject's activity data.
        - 2 types, Average body acceleration and Standard Deviation of body acceleration, each in the X,Y,Z axes.
        - Additional information from [UCI's data set description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones):
            ```
            The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.
            ```

For additional details on the raw data used to summarize the average measurements, see the "features_info.txt" file in the [UCI data files](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).