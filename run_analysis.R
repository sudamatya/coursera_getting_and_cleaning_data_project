# 1. Merge the training and the test sets to create one data set.

#Setting the working directory to dataPath
dataPath<-setwd("C://Users//sudamatya//Desktop//Assignment//Getting and Cleaning data//UCI HAR Dataset//");

# Reading in the data from files
features     = read.table(file.path(dataPath, "features.txt"),header = FALSE)
activity_label = read.table(file.path(dataPath, "activity_labels.txt"),header = FALSE)
colnames(activity_label)  = c('activityId','activityType');

#Importing training data set
subject_train = read.table(file.path(dataPath,"train" ,"subject_train.txt"),header = FALSE)
x_train        = read.table(file.path(dataPath,"train" ,"x_train.txt"),header = FALSE)
y_train        = read.table(file.path(dataPath,"train" ,"y_train.txt"),header = FALSE)

# Assiging column names to the imported training data set
colnames(subject_train)  = "subjectId"
colnames(x_train)        = features[,2]
colnames(y_train)        = "activityId"

# Merging the train data sets
train_Data = cbind(y_train,subject_train,x_train)

#Importing test data set
subject_test = read.table(file.path(dataPath,"test" ,"subject_test.txt"),header = FALSE)
x_test       = read.table(file.path(dataPath,"test" ,"x_test.txt"),header = FALSE)
y_test       = read.table(file.path(dataPath,"test" ,"y_test.txt"),header = FALSE)

# Assign column names to the imported test data set
colnames(subject_test) = "subjectId"
colnames(x_test)       = features[,2]
colnames(y_test)       = "activityId"

# Merging the test data sets
test_Data = cbind(y_test,subject_test,x_test)

# Combining training and test data to create a combined data set
combined_Data = rbind(train_Data,test_Data)


# 2. Extract only the measurements on the mean and standard deviation for each measurement. 

#creating columns_to_keep vector for taking the subset of the combined data for extracting the measurement on mean and sd
columns_to_keep=colnames(combined_Data) 
combined_Data=combined_Data[(grepl("activity..",columns_to_keep) | grepl("subject..",columns_to_keep) | grepl("-mean..",columns_to_keep) & !grepl("-meanFreq..",columns_to_keep) & !grepl("mean..-",columns_to_keep) | grepl("-std..",columns_to_keep) & !grepl("-std()..-",columns_to_keep))==TRUE]


# 3. Use descriptive activity names to name the activities in the data set

# Merging the combined data set with the activity_label table to include descriptive activity names
combined_Data = merge(combined_Data,activity_label,by='activityId',all.x=TRUE)


# 4. Appropriately label the data set with descriptive activity names. 

# Updating the columns_to_keep vector to label the data set with new descriptive column names after labeling 
columns_to_keep  = colnames(combined_Data) 

# Updating the columns with descriptive label names
for (i in 1:length(columns_to_keep)) 
{
  columns_to_keep[i] = gsub("\\()","",columns_to_keep[i])
  columns_to_keep[i] = gsub("-std$","StandardDev",columns_to_keep[i])
  columns_to_keep[i] = gsub("-mean","Mean",columns_to_keep[i])
  columns_to_keep[i] = gsub("^(t)","time",columns_to_keep[i])
  columns_to_keep[i] = gsub("^(f)","frequency",columns_to_keep[i])
  columns_to_keep[i] = gsub("([Gg]ravity)","Gravity",columns_to_keep[i])
  columns_to_keep[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",columns_to_keep[i])
  columns_to_keep[i] = gsub("[Gg]yro","Gyroscope",columns_to_keep[i])
  columns_to_keep[i] = gsub("AccMag","AccMagnitude",columns_to_keep[i])
  columns_to_keep[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",columns_to_keep[i])
  columns_to_keep[i] = gsub("JerkMag","JerkMagnitude",columns_to_keep[i])
  columns_to_keep[i] = gsub("GyroMag","GyroMagnitude",columns_to_keep[i])
};

# Re-assigning the new descriptive column names to the combined_Data set
colnames(combined_Data) = columns_to_keep

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Create a new table, combined_Data_NoActivityType without the activityType column
combined_Data_NoActivityType  = combined_Data[,names(combined_Data) != 'activityType']

# Aggregating the finalDataNoActivityType table to include just the mean of each variable for each activity and each subject
tidy_Data= aggregate(combined_Data_NoActivityType[,names(combined_Data_NoActivityType) != c('activityId','subjectId')],by=list(activityId=combined_Data_NoActivityType$activityId,subjectId = combined_Data_NoActivityType$subjectId),mean)

# Merging the tidyData with activityType to include descriptive acitvity names
tidy_Data   = merge(tidy_Data,activity_label,by='activityId',all.x=TRUE)

write.table(tidy_Data,file = "C://Users//sudamatya//Desktop//Assignment//Getting and Cleaning data//UCI HAR Dataset//tidy_Data.txt" ,row.names = FALSE, quote = FALSE)

