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

#on to step 2: pull out only the mean and std variables
mean_val=grep("-mean()",datanames[,2],fixed=TRUE)
std_val=grep("-std()",datanames[,2],fixed=TRUE)
keep_val=c(mean_val,std_val)
alldata2=alldata[,keep_val]

#step 4: pretty up the names.
curnames=names(alldata2)
futurenames=vector('character',length(curnames))
for (i in 1:length(curnames)) {
  val=unlist(strsplit(curnames[i],'-'))
  if (val[2]=='mean()') {
    if (length(val)==3) {
      futurenames[i]=paste0(val[1],val[3],'mean')
    } else {
      futurenames[i]=paste0(val[1],'mean')
    }
  } else {
    if (length(val)==3) {
      futurenames[i]=paste0(val[1],val[3],'std')
    } else {
      futurenames[i]=paste0(val[1],'std')
    }
  }
}

#subject numbers are in the subject files; we might want those
test_sub=read.table("test/subject_test.txt")
train_sub=read.table("train/subject_train.txt")
subnum=rbind(test_sub,train_sub)
alldata2=cbind(alldata2,subnum)

#and the activity markers
test_act=read.table("test/y_test.txt")
train_act=read.table("train/y_train.txt")
activities=rbind(test_act,train_act)
alldata2=cbind(alldata2,activities)

#apply to dataset
names(alldata2)=c(futurenames,'subnum','activity')

#now back to step 3 to make the activity names helpful
for (i in 1:nrow(alldata2)) {
  if (alldata2$activity[i]==1) {
    alldata2$activity[i]='walking'
  } else if (alldata2$activity[i]==2) {
    alldata2$activity[i]='walking_upstairs'
  } else if (alldata2$activity[i]==3) {
    alldata2$activity[i]='walking_downstairs'
  } else if (alldata2$activity[i]==4) {
    alldata2$activity[i]='sitting'
  } else if (alldata2$activity[i]==5) {
    alldata2$activity[i]='standing'
  } else {
    alldata2$activity[i]='laying'
  }
}

#now to wrap up with step 5. get average of each variable for each subject for each activity
#loop through each variable, but not subnum and activity
finaldata=NULL
for (i in 1:66) {
  curdata=tapply(alldata2[,i],list(alldata2$subnum,alldata2$activity),mean)
  curdata=as.data.frame(curdata)
  curdata$measure=rep(names(alldata2)[i],nrow(curdata))
  curdata$subnum=1:30
  finaldata=rbind(finaldata,curdata)
}

write.csv(finaldata,"tidydatameans.csv",row.names=FALSE)
