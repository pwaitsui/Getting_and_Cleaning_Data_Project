# Goal

The purpose of the project is to isolate and transform the means and standard deviations from raw dataset collected in the Human Activity Recongnition Using Smartphones Project into a tidy data set.

# Data source

Human Activity Recongnition Using Smartphones Raw Data set:

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

Information about the raw data set can be found at the following location:
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

# run_analysis.R

R library `dplyr` is required to run the script `run_analysis.R`.  The script does try to install the library if it is unavailable.

```R
library(dplyr)
```