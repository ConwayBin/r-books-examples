#install.packages("tree")
#decision trees
library(tree)

data(iris)

sample <- iris[sample(nrow(iris)), ]

train <- sample[1:105,]
test <- sample[106:150,]

model <- tree(Species ~ ., train)

summary(model)

pred <- predict(model, test[,-5], type = "class")
pred
