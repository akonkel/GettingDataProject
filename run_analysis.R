##Course Project for Getting and Cleaning Data

##assumes that workspace is set to directory containing test and train folders

#test data is in X_test
test=read.table("test/X_test.txt",header=FALSE)

#train data is in X_train
train=read.table("train/X_train.txt",header=FALSE)

#since both files have the same general data, we can combine with rbind
alldata=rbind(test,train)

#we'll want some labels, which are in the 'features' file
datanames=read.table('features.txt')
names(alldata)=datanames[,2]

#subject numbers are in the subject files; we might want those
test_sub=read.table("test/subject_test.txt")
train_sub=read.table("train/subject_train.txt")
subnum=rbind(test_sub,train_sub)
alldata$subnum=subnum

#on to step 2: pull out only the mean and std variables
mean_val=grep("-mean()",datanames[,2],fixed=TRUE)
std_val=grep("-std()",datanames[,2],fixed=TRUE)
keep_val=c(mean_val,std_val)
alldata2=alldata[,keep_val]
