## created by LSH 3/18/2017

This readme file describes the processess in R used to create the tidy.txt data file


Original Data

  Data was obtained  obtained from:
  http://archive.ics.uci.edu/ml/machine-learning-databases/00341/

Overview
  run_analysis.r reads in the data sets below and combines them into
  one data set of only standard deviation and mean values (already existing)
  and creates the average of those, formats the columns names, makes a crosstab
  of the measurements and outputs that merged data into a text file.


Data Maniupulation

  Tidy.txt is a merged data set from the following files:

    activity_labels.txt
    features.txt
    X_train.txt
    Y_train.txt
    subject_train.txt
    X_test.txt
    Y_test.txt
    subject_test.txt

  The final data set (tidy.txt) does not contain all of the measurement data.
  Only the columns with standard deviation and means values were included in 
  tidy.txt's final output. All other data was discarded.

  After the merging of the data sets, run_analysis.r uses the melt function to
  create a crosstab of the measurement values, keeping the subject and activity
  as row identifiers

Data formatting
  To make the final data set more readable to the human analyst, run_analysis.r
  cleans up the column names by removing punctuation and by descriptive  text as
  the column names for the other merged data (e.g. activites and subject).

  