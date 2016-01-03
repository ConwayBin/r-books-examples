# based on Chapter 8 - Probability from "R Coockbook"

# 1 - Counting the Number of Combinations

# choose(n, k)
# n - items
# k - amount of items taken
choose(500, 1)
choose(500, 500)

choose(200, 20)

# 2 - Generatig Combinations

# combn(items, k)
combn(1:5, 3)
combn(1:6, 3)

combn(10, 5)

combn(c('T1', 'T2', 'T3', 'T4', 'T5'), 3)
combn(c('a', 'b', 'c'), 2)
combn(LETTERS, 2)

# 3 - Generating Random Numbers

runif(1)
runif(n=50, min = 100, max = 120)

rnorm(1)

rnorm(10)
rnorm(n = 3, mean = c(-10, 0, 10), sd = 1)

rbinom(n = 100, size = 1, prob = 0.7)
rbinom(100, 1, 0.2)
table(rbinom(100, 1, 0.2))

means <- rnorm(100, mean = 0, sd = 0.2)
rnorm(100, mean = means, sd = 1)

# 4 - Generating Reproducible Random Numbers

set.seed(123)
runif(10)
set.seed(123)
runif(10)

# 5 - Generaing a Random Sample
