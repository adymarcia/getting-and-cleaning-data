#Downloads the .zip file from the website. If the file has already been downloaded (namely, it exists) this step is skipped.
if(!file.exists("C:/Users/admarcia/Desktop/Data Science/Assignments/Assignment3-4/data")){dir.create("C:/Users/admarcia/Desktop/Data Science/Assignments/Assignment3-4/data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="C:/Users/admarcia/Desktop/Data Science/Assignments/Assignment3-4/data/Dataset.zip")

#Unzip dataSet
unzip(zipfile="C:/Users/admarcia/Desktop/Data Science/Assignments/Assignment3-4/data/Dataset.zip",exdir="C:/Users/admarcia/Desktop/Data Science/Assignments/Assignment3-4/data")

#read the tables
 #test data - read table as .txt files
        subject_test = read.table("C:/Users/admarcia/Desktop/Data Science/Assignments/Assignment3-4/data/UCI HAR Dataset/test/subject_test.txt")
        x_test = read.table("C:/Users/admarcia/Desktop/Data Science/Assignments/Assignment3-4/data/UCI HAR Dataset/test/X_test.txt")
        y_test = read.table("C:/Users/admarcia/Desktop/Data Science/Assignments/Assignment3-4/data/UCI HAR Dataset/test/y_test.txt")

 #training data - read table as .txt files
        subject_train = read.table("C:/Users/admarcia/Desktop/Data Science/Assignments/Assignment3-4/data/UCI HAR Dataset/train/subject_train.txt")
        x_train = read.table("C:/Users/admarcia/Desktop/Data Science/Assignments/Assignment3-4/data/UCI HAR Dataset/train/X_train.txt")
        y_train = read.table("C:/Users/admarcia/Desktop/Data Science/Assignments/Assignment3-4/data/UCI HAR Dataset/train/y_train.txt")

        
 #features data - read table as .txt file
        features = read.table('C:/Users/admarcia/Desktop/Data Science/Assignments/Assignment3-4/data/UCI HAR Dataset/features.txt')
        
 #activity labels - read table as .txt file
        activityLabels = read.table('C:/Users/admarcia/Desktop/Data Science/Assignments/Assignment3-4/data/UCI HAR Dataset/activity_labels.txt')

#assignment of column names
        #assign column names to the subject_test, x_test (these column names come from the features data, second column. First column (features[,1] evidence row number elements) and y_test)
        colnames(subject_test) = "subjectID"
        colnames(x_test) = features[,2] 
        colnames(y_test) = "activityID"
        
        #assign column names to the subject_train, x_train (these column names come from the features data, second column. First column (features[,1] evidence row number elements) and y_train)
        colnames(subject_train) = "subjectID"
        colnames(x_train) = features[,2] 
        colnames(y_train) = "activityID"      
        
        #assign column names to activityLabels
        colnames(activityLabels) = c('activityID','activityType')
        
#combine all data columns
        #column bind all the training and test data into a single variable.
        combined_train = cbind(y_train, subject_train, x_train)
        combined_test = cbind(y_test, subject_test, x_test)
        
        #row bind the training and test datasets into one variable
        combined_data = rbind(combined_train, combined_test)

#extracting variables with mean and standard deviations from the combined_data variable
        #read all column names
        column_names = colnames(combined_data)
        
        #identify all elements of the combined data sets which have mean or standard deviations in their name. Set column variables activityID and subjectID
        #grepl used for approximate matching (pattern matching) as all elements with mean or std in the names are extracted. True and False output
        mean_and_standard_deviation = (grepl("activityID" , column_names) | grepl("subjectID" , column_names) | grepl("mean.." , column_names) | grepl("std.." , column_names))
        
        #subset out the columns with mean and standard deviation from the combined data
        subset_combined_data = combined_data[, mean_and_standard_deviation]
        