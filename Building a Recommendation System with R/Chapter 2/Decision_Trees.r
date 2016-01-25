#install.packages("tree")
#decision trees
library(tree)

data(iris)

sample <- iris[sample(nrow(iris)), ]

train <- sample[1:105,]
test <- sample[106:150,]

model <- tree(formula = Species ~ ., data = train)

summary(model)

# test[,-5] means without column 'Species'
pred <- predict(model, test[,-5], type = "class")
pred
