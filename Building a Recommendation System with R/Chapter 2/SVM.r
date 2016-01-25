#install.packages("e1071")
#SVM
library(e1071)

data(iris)

sample <- iris[sample(nrow(iris)), ]

train <- sample[1:105, ]
test <- sample[106:150, ]

# Now, we will see that the SVM() method is called with the tune() method, which
# does cross validation and runs the model on different values of the cost parameters
tune <- tune(svm, Species ~ . ,data = train, kernel = "radial", scale = FALSE, ranges = list(cost = c(0.001, 0.01, 0.1, 1, 5, 10, 100)))
tune$best.model

# check summary of tune
summary(tune)

model <- svm(Species ~ . , data = train, kernel ="radial", cost = 5, scale = FALSE, gamma = 0.25)
model

pred <- predict(model, test)
pred
