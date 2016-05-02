#Getting and Cleaning Data Course Project - The Code book:

This code book should describes the variables, the data, and any transformations or work done to clean up the data.


The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

###For each record it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

###The dataset includes the following files:
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

###Notes:
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

## Analysis and data transformation:
After unzipping all files and going through all info, we can conclude that:

* "features.txt" holds names for Feature Variable
* "activity_labels.txt" holds levels for Activity Variable
* "y_train.txt" and "y_test.txt" hold Values for Activity Variable
* "X_train.txt" and "X_test.txt" hold Values for Features Variable
* "subject_train.txt" and "subject_test.txt" hold Values for Subject Variable

###1. Merges the training and the test sets to create one data set.
- read files listed above.
- rbind (y_test and y_train), rbind (x_test and x_train), rbind (subject_test and subject_train). Give suitable names to variables.
- combine all into one final dataset. 


###2. Extracts only the measurements on the mean and standard deviation for each measurement.
- get names of Features with “mean()” or “std()”
- subset the dataframe to keep only features with “mean()” or “std()”, using names obtained in the previous step.

###3.Uses descriptive activity names to name the activities in the data set
- Get descriptive activity names from “activity_labels.txt”
- Factorize Variable 'activity' in  the data frame using descriptive activity names obtained in the previous step.

###4.Appropriately labels the data set with descriptive variable names.
Names of Features will labelled using descriptive variable names.see below

- prefix t is replaced by time
- Acc is replaced by Accelerometer
- Gyro is replaced by Gyroscope
- prefix f is replaced by frequency
- Mag is replaced by Magnitude
- BodyBody is replaced by Body

###5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
In this part,a new tidy dataset will be created using aggregate, with the average of each variable for each Activity and each Subject based on the data set in step 4. Write new dataset after ordering, into data file tidydata.txt(created under working directory)  that contains the processed data. 
