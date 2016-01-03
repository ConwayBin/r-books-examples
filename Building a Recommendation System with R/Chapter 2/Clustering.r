#k-means clustering
library(cluster)

data(iris)

iris2 <- iris

iris2$Species <- as.numeric(iris2$Species)

kmeans <- kmeans(x = iris2, centers=5)

clusplot(iris2, kmeans$cluster, color=TRUE, shade=TRUE, labels=13, lines=0)
