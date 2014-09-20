Code Book
==================================
This codebook describes the output to 'tidydatameans.csv'.  As the name implies, it should be read in
as a csv, perhaps with the R code "read.csv('tidydatameans.csv')".  This assumes that you are in the 
working directory with the run_analysis.R file and have already run it to generate the output file.

The original data set is described by the UCI group's README and features_info.txt files.
Please refer to those for details on the meaning of various variable meanings, e.g. t versus f; 
X, Y, and Z; or Body versus Gravity.  It is sufficient to note here that the data comes from
accelerometer readings from a smart phone.

*Subject number (subnum) was combined with the accelerometer data but left in numerical format (1 to 30).
*The various measurement variables (body acceleration is the X direction, etc.) are collapsed
into a 'measure' variable (66 possible values).  These measures are a subset of all the 
accelerometer readings; following instruction, they are limited to those that are a mean
or standard deviation (see also the README.md that goes with this Code Book and the R script).
*Activity label was combined with the accelerometer data and changed from a number (1 to 6) to a 
character (walking, walking upstairs, walking downstairs, laying, standing, sitting) according to 
the activity_labels file.
*The value in an activity column for a subject-by-measure row is the mean value of multiple observations
for that subject performing that activity for that measure.  For example, there were 53 observations of
subject 1 while standing.  The value of 0.2789... in the first row in the 'standing' column is the 
average of those 53 observations for the tBodyAccmean measure.  The other values for subject 1 in the
'standing' column are similarly averages of 53 observations for their respective measures.
*The data is thus organized in something of a mix of long and wide format; it is long in that there are
multiple lines for each subject and each measure, but it is wide in that activity was also observed
within subject, but each activity has its own column instead of being collapsed into a single variable.