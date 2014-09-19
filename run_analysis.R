##Course Project for Getting and Cleaning Data

##assumes that workspace is set to directory containing test and train folders

#test data is in X_test
test=read.table("test/X_test.txt",header=FALSE)

#train data is in X_train
train=read.table("train/X_train.txt",header=FALSE)

#we'll want some labels, which are in the 'features' file
datanames=read.table('features.txt')
names(test)=datanames[,2]
names(train)=datanames[,2]

#subject numbers are in the subject files; we might want those
test_sub=read.table("test/subject_test.txt")
train_sub=read.table("train/subject_train.txt")
test$subnum=test_sub
train$subnum=train_sub

#ok, now we want to merge the two.
