#CaseStudy3
library(cluster)
library(ggvis)
library(plyr)
library(dplyr)
library(ggplot2)
library(e1071)

#Classify hand-written digit data with SVM Algorithms and calculate prediction accuracy

setwd("/Users/sivanvitha/WPI/DS501/CaseStudy3/PenDigitData")
train <- read.csv("pendigits.tra")
test <- read.csv("pendigits.tes.txt")

x <- subset(train, select = -X8)
y <- train$X8
model <- svm(X8 ~ ., data = train)

print(model)
summary(model)

# test with train data
pred <- predict(model, x)

# (same as:)
pred <- fitted(model)

# Check accuracy:
table(pred, y)

# compute decision values and probabilities:
pred <- predict(model, x, decision.values = TRUE)
attr(pred, "decision.values")[1:4,]

plot(cmdscale(dist(train[,-17])),
     col = as.integer(train[,17]))

rmse <- function(error)
{
  sqrt(mean(error^2))
}

error <- model$residuals  # same as data$Y - predictedY
predictionRMSE <- rmse(error)   # 5.703778

