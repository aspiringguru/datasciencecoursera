# datasciencecoursera
project for 'The data scientists toolbox' on coursera

## Summary  

The goals for this project were outlined in the Coursera "Getting and Cleaning Data" project.  In short, the task required processing the data and producing a tidy data format for subsequent interpretation.
https://class.coursera.org/getdata-011/human_grading  

The original data source (below) used a samsung phone to record movement of volunteers performing nominated tasks.  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones   

This repo contains the following files.

1. run_analysis.r            : the R code produced for this project.
2. CodeBook.md               : Codebook produced to explain the data produced and method used.
3. tidyData.txt              : The tidy data produced. (not required but submitted for backup and historical purposes)


## Data processing.  

The 'run_analysis.r' file in this repo processes the data as described below.  

a.  Read the data files provided.  
b.  Match corresponding data to provide a complete data set.  
c.  Using text files provided add column names to the complete data set.  
d.  Using the test files provided, add descriptions of the activities to the complete data set.  
e.  select the columns of interest for the final tidy data set (ie : means and standard deviation columns)  
f.  relabel the columns into a human readable form with a consistent naming style.  
g.  calculate the average values.  
h.  write the resulting data set to a text file.  


## notes on selection of 'mean' and 'std' columns.  

The project definition nominated 
"2. Extracts only the measurements on the mean and standard deviation for each measurement."

In discussion forum thread, the teaching assistant advised.

https://class.coursera.org/getdata-011/forum/thread?thread_id=69  
"what columns are measurements on the mean and standard deviation  
 Based on interpreting column names in the features is an open question as to is the the entries that include mean() and std() at the end, or does it include entries with mean in an earlier part of the name as well. There are no specific marking criteria on the number of columns. It is up to you to make a decision and explain what you did to the data. Make it easy for people to give you marks by explaining your reasoning."  
 
Looking at the original column names and the descriptions provided of how the pre-processing of data was performed, it was felt that only the columns with name format mean() or std() should be used. 

Should subsequent analysis identify additional columns are required, the commenting provided in the code will enable the selection of columns to be adjusted to suit.