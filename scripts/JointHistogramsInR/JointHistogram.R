# set the working directory
setwd("E:/Projects/School/RWorkspace")
# read the data file into a data frame
DataFrame <- read.csv("SampleSet.txt")

#separate data into training data and test data and free the original data frame
TrainingFrame <- DataFrame[1:100, 1:5]
rm(DataFrame)

#function that computes the threshold for a single feature (1D threshold)
threshold1D <- function (negativeSet, positiveSet) {

	threshhold <- 0
	possibilities <- seq(0.001,1.001, length = 1000)
	elemCount <- length(negativeSet) + length(positiveSet) + 1
	error <- elemCount

	
	for (testValue in possibilities) {
		#assume x axis order is Negative -> Positive
		err1 <- 0;
		for (element in negativeSet) {
			if (element > testValue) err1 <- err1 + 1
		}
		for (element in positiveSet) {
			if (element < testValue) err1 <- err1 + 1
		}

		#assume order is Positive -> Negative
		err2 <- 0;
		for (element in negativeSet) {
			if (element < testValue) err2 <- err2 + 1
		}
		for (element in positiveSet) {
			if (element > testValue) err2 <- err2 + 1
		}
		
		if (error > err1){
			error <- err1;
			threshold <- testValue;
		}
		if (error > err2){
			error <- err2;
			threshold <- testValue;	
		}
	} 	
	
	return (list(value = threshold, accuracy = round((1 - error/elemCount), digits = 2)*100))
}
 

par(mfrow=c(2,2))

F1Solution <- threshold1D(TrainingFrame$F1[TrainingFrame$R == -1], TrainingFrame$F1[TrainingFrame$R == 1])
str1 <- paste("Threshhold: ", round(F1Solution$value, digits = 3), " Training accuracy: ", F1Solution$accuracy, "%\n")
hist(TrainingFrame$F1[TrainingFrame$R == -1], main = "Histogram for Feature 1", xlab = str1, ylim = c(0,10), xlim = c(0,1), breaks = 20, col = rgb(0,1,0,0.5))
hist(TrainingFrame$F1[TrainingFrame$R == 1], main = "Histogram for Feature 1", xlab = str1, ylim = c(0,10), xlim = c(0,1), breaks = 20, col = rgb(1,0,0,0.5), add=T)
abline(v = F1Solution$value, col = "blue")

F2Solution <- threshold1D(TrainingFrame$F2[TrainingFrame$R == -1], TrainingFrame$F2[TrainingFrame$R == 1])
str2 <- paste("Threshhold: ", round(F2Solution$value, digits = 3), " Training accuracy: ", F2Solution$accuracy, "%\n")
hist(TrainingFrame$F2[TrainingFrame$R == -1], main = "Histogram for Feature 2", xlab = str2, ylim = c(0,10), xlim = c(0,1), breaks = 20, col = rgb(0,1,0,0.5))
hist(TrainingFrame$F2[TrainingFrame$R == 1], main = "Histogram for Feature 2", xlab = str2, ylim = c(0,10), xlim = c(0,1), breaks = 20, col = rgb(1,0,0,0.5), add=T)
abline(v = F2Solution$value, col = "blue")

F3Solution <- threshold1D(TrainingFrame$F3[TrainingFrame$R == -1], TrainingFrame$F3[TrainingFrame$R == 1])
str3 <- paste("Threshhold: ", round(F3Solution$value, digits = 3), " Training accuracy: ", F3Solution$accuracy, "%\n")
hist(TrainingFrame$F3[TrainingFrame$R == -1], main = "Histogram for Feature 3", xlab = str3, ylim = c(0,10), xlim = c(0,1), breaks = 20, col = rgb(0,1,0,0.5))
hist(TrainingFrame$F3[TrainingFrame$R == 1], main = "Histogram for Feature 3", xlab = str3, ylim = c(0,10), xlim = c(0,1), breaks = 20, col = rgb(1,0,0,0.5), add=T)
abline(v = F3Solution$value, col = "blue")

F4Solution <- threshold1D(TrainingFrame$F4[TrainingFrame$R == -1], TrainingFrame$F4[TrainingFrame$R == 1])
str4 <- paste("Threshhold: ", round(F4Solution$value, digits = 3), " Training accuracy: ", F4Solution$accuracy, "%\n")
uracy of: ", F4Solution$accuracy, "%\n")
hist(TrainingFrame$F4[TrainingFrame$R == -1], main = "Histogram for Feature 4", xlab = str4, ylim = c(0,10), xlim = c(0,1), breaks = 20, col = rgb(0,1,0,0.5))
hist(TrainingFrame$F4[TrainingFrame$R == 1], main = "Histogram for Feature 4", xlab = str4, ylim = c(0,10), xlim = c(0,1), breaks = 20, col = rgb(1,0,0,0.5), add=T)
abline(v = F4Solution$value, col = "blue")

#clear memory of all objects
rm(list=objects())

