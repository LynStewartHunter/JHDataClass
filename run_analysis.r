## LSH R assignment week 4 3/2017
## This program combines the folowing data sets obtained from:
## http://archive.ics.uci.edu/ml/machine-learning-databases/00341/
## It reads in the data sets below and combines them into
## one data set of only standard deviation and mean values (already existing)
## and creates the average of those, then it outputs that into a text file
## 

## load the data sets that create the structure for the main data
##dfactivities <- read.table("Y_train.txt")  ## 7352,1 
##dfsubjects <- read.table("subject_train.txt")  ## 7352,1 
dflabels <- read.table("activity_labels.txt", header = FALSE) ##6,2
dffeatures <- read.table("features.txt", header = FALSE) ## 561,2

## convert labels and features for easy column name maniuplation
dflabels[,2] <- as.character(dflabels[,2])
dffeatures[,2] <- as.character(dfeatures[,2])

## store the mean and standard deviation columns into an array to filter data loads
datacols <- grep(".*mean.*|.*std.*", dffeatures[,2])
# create a matrix of the good column names
datacols.names <- dffeatures[datacols,2]
##  strip out punctuation
datacols.names <-gsub("[[:punct:]]", "", datacols.names)

##load and bind testing and training data with the datacols variable to filter the load
dftrain <- read.table("X_train.txt", header = FALSE)[datacols] ##  7767, 79
dftrainA <- read.table("train/Y_train.txt")
dftrainS <- read.table("train/subject_train.txt")
finaltraindata <- cbind(dftrainA, dftrainS, dftrain)
##
dftest <- read.table("X_test.txt", header = FALSE)[datacols] ## 2947, 79
dftestA <- read.table("test/Y_test.txt")
dftestS <- read.table("test/subject_test.txt")
finaltestdata <- cbind(dftestS, dftestA, dftest)

## bind all data into the final table 
dfFinal <- rbind(finaltraindata, finaltestdata)
colnames(dfFinal) <- c("subject", "activity", colnames) ## the first two cols are from the two dim tables

# bring in the actual first two column names
dfFinal$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
dfFinal$subject <- as.factor(allData$subject)
## make a cross tab, keeping only the subject and activity columns as is
dfcrosstab <- melt(allData, id = c("subject", "activity")) 
dfmeans <- dcast(dfcrosstab, subject + activity ~ variable, mean) # create the averages

## produce the final table with no quotes in the output
write.table(dfmeans, "./out/tidy.txt", row.name=FALSE, quote = FALSE)