## Codebook  
---------------------------------------------------------  
Project for "Getting and Cleaning Data"  

## Data source  

The original data is from  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

This zip file of data was provided for use in the project.  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

The data is collected from 30 volunteers performing six activities while wearing a Samsung smartphone. Data from the phone's accelerometer and gyroscope is recorded and analysed in this project.  


## Data Files  

Unzipping the data produces raw data files, processed data and other files explaining how the data has been collected and analysed.  

The data collected has been split as follows.
.\                         : files explaining how the data was collected, processed and labelled.
.\test\                    : data collected and assigned to 'test' category.
.\train\                   : data collected and assigned to 'training' category.

Within these two directories, the following split exists.
.\Inertial Signals        : contains the 'raw' data recorded. this data was not processed for this assignment.
.\                        : contains pre-processed data 



ie  
.\test\subject_train.txt   : contains ID number of volunteers for the data used for testing.  
.\test\X_train.txt         : values represent the activity recorded, 2947 rows x 561 columns.  
.\test\y_train.txt         : values represent the activity recorded, 2947 rows x   1 column.  
similarly for .\train\ except 73252 rows of data.  

The root directory contains important data and explanation of the data.  
activity_labels.txt        : contains description of the activities recorded.  
features.txt               : contains the full list of 561 variable names recorded.  
features_info.txt          : explains how the raw data was processed.  
README.txt                 : Provides a summary of the files, the data collected and how the data was processed.

To avoid duplication of explanations, the reader is referred to the above documents.

## Processing Method

The data stored in the "X_train.txt" contained 561 columns of data, by matching this with the 'volunteerID' from "subject_train.txt" and "y_train.txt" 563 columns of data were assembled.  

This process was replicated for the data in .\test\. The two data sets were combined to produce a data set with 10,299 rows and 563 columns.

Preliminary names were assigned to the data using the data recorded in "features.txt".

Merging of data also used the activity descriptions provided to provide human readable data instead of just activity numbers.

From this dataset the columns of interest were selected, in short, only columns with 'mean' or 'std' were selected in addition to the columns identifying the volunteer and activity.  

Cosmetic relabelling of the column names to provide more easily read names was performed, abbreviations were replaced by full words and a column naming syntax of lowercase and words.separated.by '.' adopted.  The column labels are shown below.

The data was tidied to present the columns listed below, with means for all columns for each combination of "volunteerID" & "activityID". 
ie : 30 volunteers x 6 activities, resulting in 180 rows by 68 columns.

------------------------------------------------------------------------------  
[1] "time.body.acceleration.std.X"                        
 [2] "time.body.acceleration.std.Y"                        
 [3] "time.body.acceleration.std.Z"                        
 [4] "time.gravity.acceleration.std.X"                     
 [5] "time.gravity.acceleration.std.Y"                     
 [6] "time.gravity.acceleration.std.Z"                     
 [7] "time.body.acceleration.jerk.std.X"                   
 [8] "time.body.acceleration.jerk.std.Y"                   
 [9] "time.body.acceleration.jerk.std.Z"                   
[10] "time.body.gyro.std.X"                                
[11] "time.body.gyro.std.Y"                                
[12] "time.body.gyro.std.Z"                                
[13] "time.body.gyro.jerk.std.X"                           
[14] "time.body.gyro.jerk.std.Y"                           
[15] "time.body.gyro.jerk.std.Z"                           
[16] "time.body.acceleration.magnitude.std"                
[17] "time.gravity.acceleration.magnitude.std"             
[18] "time.body.acceleration.jerk.magnitude.std"           
[19] "time.body.gyro.magnitude.std"                        
[20] "time.body.gyro.jerk.magnitude.std"                   
[21] "frequency.body.acceleration.std.X"                   
[22] "frequency.body.acceleration.std.Y"                   
[23] "frequency.body.acceleration.std.Z"                   
[24] "frequency.body.acceleration.jerk.std.X"              
[25] "frequency.body.acceleration.jerk.std.Y"              
[26] "frequency.body.acceleration.jerk.std.Z"              
[27] "frequency.body.gyro.std.X"                           
[28] "frequency.body.gyro.std.Y"                           
[29] "frequency.body.gyro.std.Z"                           
[30] "frequency.body.acceleration.magnitude.std"           
[31] "frequency.body.body.acceleration.jerk.magnitude.std"   
[32] "frequency.body.body.gyro.magnitude.std"              
[33] "frequency.body.body.gyro.jerk.magnitude.std"         
[34] "time.body.acceleration.mean.X"                       
[35] "time.body.acceleration.mean.Y"                       
[36] "time.body.acceleration.mean.Z"                       
[37] "time.gravity.acceleration.mean.X"                    
[38] "time.gravity.acceleration.mean.Y"                    
[39] "time.gravity.acceleration.mean.Z"                    
[40] "time.body.acceleration.jerk.mean.X"                  
[41] "time.body.acceleration.jerk.mean.Y"                  
[42] "time.body.acceleration.jerk.mean.Z"                  
[43] "time.body.gyro.mean.X"                               
[44] "time.body.gyro.mean.Y"                               
[45] "time.body.gyro.mean.Z"                               
[46] "time.body.gyro.jerk.mean.X"                          
[47] "time.body.gyro.jerk.mean.Y"                          
[48] "time.body.gyro.jerk.mean.Z"                          
[49] "time.body.acceleration.magnitude.mean"               
[50] "time.gravity.acceleration.magnitude.mean"            
[51] "time.body.acceleration.jerk.magnitude.mean"          
[52] "time.body.gyro.magnitude.mean"                       
[53] "time.body.gyro.jerk.magnitude.mean"                  
[54] "frequency.body.acceleration.mean.X"                  
[55] "frequency.body.acceleration.mean.Y"                  
[56] "frequency.body.acceleration.mean.Z"                  
[57] "frequency.body.acceleration.jerk.mean.X"             
[58] "frequency.body.acceleration.jerk.mean.Y"             
[59] "frequency.body.acceleration.jerk.mean.Z"              
[60] "frequency.body.gyro.mean.X"                          
[61] "frequency.body.gyro.mean.Y"                          
[62] "frequency.body.gyro.mean.Z"                          
[63] "frequency.body.acceleration.magnitude.mean"          
[64] "frequency.body.body.acceleration.jerk.magnitude.mean"  
[65] "frequency.body.body.gyro.magnitude.mean"             
[66] "frequency.body.body.gyro.jerk.magnitude.mean"        
[67] "volunteerID"                                         
[68] "activityID"  

------------------------------------------------------------------------------  

