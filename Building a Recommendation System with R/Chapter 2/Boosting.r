#Boosting in R
#Install.packages(“gbm”)

library(gbm)
data(iris)

sample <- iris[sample(nrow(iris)),]

train <- sample[1:105,]   # 70% training
test <- sample[106:150,]  # 30% test

str(train)
model <- gbm(Species ~ . , data = train, distribution = "multinomial", n.trees = 5000, interaction.depth = 4)
summary(model)

pred <- predict(model, newdata = test[ ,-5], n.trees = 5000)
pred
