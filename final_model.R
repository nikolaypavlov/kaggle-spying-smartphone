### Example of submission code
library(caret)
library(doMC)
registerDoMC()

nick_model <- function(train) {
  samples <- 10
  neurons <- 26
  epoch <- 1000
  col <- ncol(train)
  
  # Training
  set.seed(1)
  bag_ctrl = bagControl(fit = nnetBag$fit, 
                        predict = nnetBag$pred,
                        aggregate = nnetBag$aggregate)
  
  model <- bag(train[,-c(col-1,col)], train$activity, 
               B = samples, bagControl=bag_ctrl, 
               size=neurons, decay=5e-04, 
               maxit=epoch, censored=T, 
               MaxNWts=20000)
}