setwd("~/repos/kaggle-smartphone/")

### train.csv directly downloaded from kaggle
### test.csv directly downloaded from kaggle
train <- read.csv("data/train.csv")
test <- read.csv("data/test.csv")

rescale <- function(data) {
  for (i in unique(data$subject)) {
    for (j in 1:561) {
      data[data$subject == i, j] <- scale(data[data$subject == i, j])
    }
  }
  return(data)
}

write.csv(rescale(train), file="data/rescaled_train.csv", row.names=FALSE)
write.csv(rescale(test), file="data/rescaled_test.csv", row.names=FALSE)
