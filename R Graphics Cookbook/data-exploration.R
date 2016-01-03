# dimensions
dim(iris)

# names of attributes
names(iris)

# structure
str(iris)

# attributes list of object
attributes(iris)

# first 5 rows
head(iris)

# the same as above
iris[1:5,]

# first 10 rows or variable "Sepal.Width" 
iris[1:10, "Sepal.Width"]

# the same as above
iris$Sepal.Width[1:10]

# summary of variables
summary(iris)

# frequency
table(iris$Species)

# pie chart of frequency
pie(table(iris$Species))

# variance
var(iris$Sepal.Length)

# covariance of 2 variable
cov(iris$Sepal.Length, iris$Petal.Length)

# correlation of 2 variable
cor(iris$Sepal.Length, iris$Petal.Length)

# correlation of all variables insted of Species (not numeric)
cor(iris[-5])

# histogram
hist(iris$Sepal.Length)

# density
plot(density(iris$Sepal.Length))
