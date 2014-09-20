GettingDataProject
==================

There is one analysis script, run_analysis.R.  It assumes that you are in the 'UCI HAR Dataset' folder, 
so that in your workspace you can immediately refer to the test and train folders and the features.txt file.

The script is commented, but a description of how it works follows: the script begins by reading in the
two main data files, the test and train data.  Step 1 of the homework, merging the two, is accomplished
simply by row binding (rbind) the two data frames.  The means and standard deviations of the measurements
are selected for Step 2 using grep.  I assumed that the desired measurements would have both means and 
standard deviations, and so used the 'fixed=TRUE' option to get the literal string values.  This eliminates
the last few variables in the original data set (e.g. angle(Z,gravityMean) ), but since they have no paired
standard deviation, I thought this was ok.

I then skipped to part 4 and renamed the headers since I thought this was a good place to do that.  The names
are basically a fight between brevity and clarity; I erred towards brevity since no one would ever want to type
the variable names that would be most clear for this data set.  I used strsplit to look for either -mean() or
-std() and pull them out, combining the initial part of the name (e.g. tBodyAcc) with the final part if present
(the direction X, Y, or Z if present) and then added 'mean' or 'std' to the end as appropriate.  Names were thus 
changed from something like tBodyAcc-mean()-X to something like tBodyAccXmean, which I believe is equally informative
but shorter.  Having done this, I completed the data set by adding in the subject numbers and activity values from the
y_test, y_train, subject_test, and subject_train text files.  I went back and completed Step 3 using a for loop with
if else statements to map the activity numbers 1 through 6 to their activity names as listed in the activity_labels 
file.

I write out this tidy data file under the assumption that we would want to keep it in real life.  But the final
Step 5 takes place after to create a second tidy data file.  I use a for loop to go through each of the 66
measures in the data (tBodyAccXmean and so on) and use tapply to get an average for each subject doing each task.
The instructions are unclear how averaged this data is supposed to be ('for each activity and each subject' could
mean what I did, the average for subject 1 walking, subject 1 laying, etc; or it could mean the average for
subject 1, subject 2, and so on, as well as walking, laying, etc), so I left it fairly raw.  If one desires the
average across subjects or across activities that can be computed, whereas the reverse could not be done.  This file
is then written out to tidydatameans.csv.

Aside from this README and the analysis file (run_analysis.R), there is also a CodeBook.md file with a description
of the original data and the transformations that the analysis file does to it.