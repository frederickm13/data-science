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
levels(data$POSTSEASON)
levels(data$CONF)


# Create win percentage variable
data$WinPercent <- (data$W / data$G)


# Remove insignificant variables
removeColumns <- c("YEAR", "TEAM", "WAB", "W", "G")
data <- data[, !(names(data) %in% removeColumns)]


# Replace POSTSEASON values: '2ND' with 'RunnerUp' and remove teams that missed tourney
data <- data[!is.na(data$POSTSEASON),]
data[,"POSTSEASON"] <- as.character(data[,"POSTSEASON"])
data[data$POSTSEASON == "2ND", "POSTSEASON"] <- "RunnerUp"
data$POSTSEASON <- as.factor(data$POSTSEASON)
levels(data$POSTSEASON)


# Set SEED variable as a factor
data$SEED <- as.factor(data$SEED)
levels(data$SEED)


# Determine distribution of data
for (var in levels(data$POSTSEASON)) {
  print(paste(var, ": ", nrow(data[data$POSTSEASON == var,])))
}
print(paste("Total: ", nrow(data)))


# Split dependent vars from independent vars
depData <- data[, !(names(data) == "POSTSEASON")]
indData <- data[, "POSTSEASON"]


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
data$POSTSEASON <- indData


# Split into training and test data
trainIndex <- createDataPartition(data$POSTSEASON, p=0.7, list=FALSE)
trainData <- data[trainIndex,]
testData  <- data[-trainIndex,]


# Use 10-fold cross-validation resampling for model training
fitControl <- trainControl(method = "cv",
                           number = 10, 
                           classProbs = TRUE)


# Random forest model
rfOut <- train(trainData[, !(names(data) == "POSTSEASON")],
               trainData[, "POSTSEASON"],
               method = "rf",
               trControl = fitControl)         


# Neural Network model
nnetOut <- train(trainData[,!(names(data) == "POSTSEASON")], 
                 trainData[,"POSTSEASON"], 
                 method='nnet',
                 trControl = fitControl)


# Stochastic Gradient Boosting
gbmOut <- train(trainData[, !(names(data) == "POSTSEASON")],
               trainData[, "POSTSEASON"],
               method = "gbm",
               trControl = fitControl)   


# Predict
rfPred <- predict(rfOut, testData)
nnPred <- predict(nnetOut, testData)
gbmPred <- predict(gbmOut, testData)


# Compare performance
postResample(rfPred, testData$POSTSEASON)
postResample(nnPred, testData$POSTSEASON)
postResample(gbmPred, testData$POSTSEASON)


# Determine Variable Importance
View(varImp(rfOut)$importance)
View(varImp(nnetOut)$importance)
View(varImp(gbmOut)$importance)