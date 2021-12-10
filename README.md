==================================================================
# GettingAndCleaning
Week4_CourseProject

run_Analysis.R
Version 1.0
==================================================================
Mohamad Barad
Getting and cleaning data by Coursera 
==================================================================

The datasets  included in the following analysis are:
=========================================
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'train/subject_train.txt: Training subjects
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'test/subject_test.txt: Test subjects

Output: 
======
The output are 3 tidy datasets
'data' [10299 x 563], which includes the following variables 
- 'subjects' a list of alle subjects in the study, both train and test subjects
- 'activity' a list of all acitivty labels 
- list of measurement variables in the studyfor mean() and std()

'data2' [10299 x 81], which includes the following variables 
- 'subjects' a list of alle subjects in the study, both train and test subjects
- 'activity' a list of all acitivty labels 
- list of mean() and std() measurement variables

'data3' [180 x 81], which includes the following variables 
- 'subjects' a list of alle subjects in the study, both train and test subjects
- 'activity' a list of all acitivty labels 
- the average of measurement variables 
 

Notes: 
======
- The 'data' is a big data set with all the training and testing subjects merged together


License:
========
Use of this dataset in publications must be acknowledged by the author below
Mohamad Barad. December 2021.

