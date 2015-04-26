#Code Book

##Introduction

The data.csv file is a summary data set of the full data set from the Human Activity Recognition Using Smartphones project.


- activity   
  One of the 6 activities listed below:   
    laying
    sitting
    standing
    walking
    walking_upstairs
    walking_downstairs

- subject  
  A unique integer identifier for each of the subjects in the study, from 1-30.

- variable  
  The variable (or feature) being measured. All names start with "mean" since we have computed the mean for all variables. Variables are either measured over time or frequency.   
  Variables ending in "-X", "-Y" or "-Z" are measures on different coordinate axes.   
  For better understanding, here are the main abbreviations and their description::    
    "Acc" -> "Acceleration"   
    "Mag" -> "Magnitude"   
    "Gyro" -> "Gyroscope"   

- value  
  The value of the variable for the given subject/activity on the row. All values in this data set are in fact a mean of the original variable values from the the UCR HAR study.
