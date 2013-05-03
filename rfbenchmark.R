### Example of submission code
setwd("~/repos/kaggle-smartphone/")
require(randomForest)
library(caret)
require(nnet)
library(e1071)
library(doMC)
registerDoMC()

### loading test and training set

### train.csv directly downloaded from kaggle
### test.csv directly downloaded from kaggle
train <- read.csv("data/train.csv")
test <- read.csv("data/test.csv")


### random forest
#rfmodel <- randomForest(activity ~ . - subject, data = train, prox=TRUE, mtry=14)
ctrl <- trainControl(method="cv", number=5, verboseIter=T)
set.seed(1)
time <- system.time({model <- train(activity ~ . - subject, data = train, method="nnet", linout=F, 
                                    tuneGrid=expand.grid(.size=c(26), .decay=c(5e-04, 5e-03)), trControl=ctrl, range=.1, 
                                    maxit=1000, censored=T, MaxNWts=20000, trace=T)})

### prediction
activpred <- predict(model$finalModel, newdata = test)

### submit your prediction
write.table(x = activpred, file = "rf_submission.csv", row.names = FALSE, col.names = FALSE)
