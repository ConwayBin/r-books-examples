# based on Chapter 8 - Data Transformations from "R Coockbook"

v <- c(40,2,83,28,58)
f <- factor(c("A","C","C","B","C"))

# 1 - Splitting a Vector into Groups

groups <- split(v, f)
groups <- unstack(data.frame(v,f))

library(MASS)
dim(Cars93)
str(Cars93)
split(Cars93$MPG.city, Cars93$Origin)


g <- split(Cars93$MPG.city, Cars93$Origin)
median(g[[1]])
median(g[[2]])

# 2 - Applying a Function to Each List Element

lapply(g, length)
sapply(g, length)

class(lapply(g, length))
class(sapply(g, length))

sapply(g, mean)
sapply(g, sd)
sapply(g, summary)
sapply(g, range)

tests <- lapply(g, t.test)
sapply(tests, function(t) t$conf.int)

# 3 - Applying a Function to Every Row

x <- runif(100, min = 10, max = 150)
m <- matrix(x, ncol = 5)

apply(m, 1, mean)
apply(m, 1, range)


# 4 - Applying a Function to Every Column

x <- runif(100, min = 10, max = 150)
m <- matrix(x, ncol = 5)

apply(m, 2, mean)
apply(m, 2, range)

# apply is for matrixes
# use sapply and lapply if data.frames
# data.frame is like a list with columns like list elements

class(Aids2)
str(Aids2)
head(Aids2)

sapply(Aids2, class)

# brakuje tutaj data.frame pred
# znalesc jakis i sprawdzic
cors <- sapply(pred, cor, y=resp)
mask <- (rank(-abs(cors)) <= 10)
best.pred <- pred[,mask]
lm(resp ~ best.pred)

# 5 - Applying a Function to Groups of Data
