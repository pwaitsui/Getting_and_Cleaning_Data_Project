# Goal

The purpose of the project is to isolate and transform the means and standard deviations from raw dataset collected in the Human Activity Recongnition Using Smartphones Project into a tidy data set.

# Data source

Human Activity Recongnition Using Smartphones Raw Data set:

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

Information about the raw data set can be found at the following location:
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

# The Script

Located in this Repository is the R script `run_analysis.R` that is used to transform the raw data set.  It does the following:

<ol>
<li>Setup directory structure and load raw data in to dataframes</li>
<li>Row binds training and test dataframes for subject, X, and Y</li>
<li>Isolate the column index for `mean` and `std` (standard deviation) from features to select the corresponding columns on the X dataframe</li>
<li>Use activity and features to label X and Y dataframes</li>
<li>Column binds Subject, X, and Y into a single dataframe</li>
<li>Use `dplyr` funtions `chain`, `select`, `group_by`, and `summarise_each` to take the average for all the activity means and std's and create a tidy data set</li>
<li>Finally, the tidy data is outputted to the current working directory. The filename is called `tidy_output.txt`.</li>
</ol>

Please note that the R library `dplyr` is required to run the script `run_analysis.R`.  The script does try to install the library if it is unavailable.

