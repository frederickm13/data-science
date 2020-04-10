# Import packages
library(caret)
library(mlbench)
library(AppliedPredictiveModeling)
library(ggplot2)
library(gbm)


# Set working directory
dir <- #add directory path here
setwd(dir)


# Set seed for development environment
set.seed(12345)


# Load data and check high level details
data <- read.csv("cbb.csv")
head(data)
str(data)
levels(data$CONF)


# Create win percentage variable
data$WinPercent <- (data$W / data$G)


# Remove insignificant variables
removeColumns <- c("YEAR", "TEAM", "WAB", "W", "G", "POSTSEASON")
data <- data[, !(names(data) %in% removeColumns)]


# Replace SEED values: NA with 0
data[is.na(data$SEED), "SEED"] <- 0


# Fix SEED values to be valid variable names
for (val in 0:16) {
  data[data$SEED == val, "SEED"] <- paste("X",val, sep = "")
}


# Set SEED variable as a factor
data$SEED <- as.factor(data$SEED)
levels(data$SEED)


# Determine distribution of data
for (var in levels(data$SEED)) {
  print(paste(var, ": ", nrow(data[data$SEED == var,])))
}
print(paste("Total: ", nrow(data)))


# Split dependent vars from independent vars
depData <- data[, !(names(data) == "SEED")]
indData <- data[, "SEED"]


# PreProcess: 
# Remove near zero variance predictors
# Remove highly correlated predictors.
# Apply a YeoJohnson transformation to reduce skewness of predictors.
# Center and scale your numeric predictors.
preProcessOut <- preProcess(depData,
                            method=c('nzv', 
                                     'corr', 
                                     'YeoJohnson', 
                                     'center', 
                                     'scale', 
                                     'knnImpute'))
depData <- predict(preProcessOut, depData)


# Convert factor variables to dummy variables
dummyInfo <- dummyVars(~., data=depData, fullRank=TRUE)
depData <- data.frame(predict(dummyInfo, depData))


# Add the dependent variable back to the data
data <- depData
data$SEED <- indData


# Split into training and test data
trainIndex <- createDataPartition(data$SEED, p=0.8, list=FALSE)
trainData <- data[trainIndex,]
testData  <- data[-trainIndex,]


# Use 10-fold cross-validation resampling for model training
fitControl <- trainControl(method = "cv",
                           number = 10, 
                           classProbs = TRUE)


# Random forest model
rfOut <- train(trainData[, !(names(data) == "SEED")],
               trainData[, "SEED"],
               method = "rf",
               trControl = fitControl)         


# Neural Network model
nnetOut <- train(trainData[,!(names(data) == "SEED")], 
                 trainData[,"SEED"], 
                 method='nnet',
                 trControl = fitControl)


# Stochastic Gradient Boosting
gbmOut <- train(trainData[, !(names(data) == "SEED")],
               trainData[, "SEED"],
               method = "gbm",
               trControl = fitControl)   


# Predict
rfPred <- predict(rfOut, testData)
nnPred <- predict(nnetOut, testData)
gbmPred <- predict(gbmOut, testData)


# Compare performance
postResample(rfPred, testData$SEED)
postResample(nnPred, testData$SEED)
postResample(gbmPred, testData$SEED)


# Determine Variable Importance
View(varImp(rfOut)$importance)
View(varImp(nnetOut)$importance)
View(varImp(gbmOut)$importance)