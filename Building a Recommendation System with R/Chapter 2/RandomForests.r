#install.packages("randomForest")
#randomForest

library(randomForest)

data(iris)

sample <- iris[sample(nrow(iris)), ]

train <- sample[1:105,]
test <- sample[106:150,]

model <- randomForest(Species ~ . , data = train, mtry = 4, importance = TRUE, proximity=TRUE)
model

pred <- predict(model, newdata = test[,-5])
pred 


