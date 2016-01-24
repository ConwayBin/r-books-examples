#k-means clustering
library(cluster)

data(iris)

iris$Species <- as.numeric(iris$Species)
iris$Species <- NULL

kmeans <- kmeans(x = iris, centers=5)

attributes(kmeans)

clusplot(iris, kmeans$cluster, color=T, shade=T, labels=13, lines=0)

# -----------------------------------
library(cluster)
library(ggplot2)

data(iris)

iris$Species <- as.numeric(iris$Species)

cost_df <- data.frame()

for(i in 1:100){
  kmeans <- kmeans(x = iris, centers = i, iter.max = 50)
  cost_df <- rbind(cost_df, cbind(i, kmeans$tot.withinss))
}
names(cost_df) <- c("cluster", "cost")

#Elbow method to identify the idle number of Cluster
#Cost plot
ggplot(data = cost_df, aes(x = cluster, y = cost, group = 1)) +
  theme_bw(base_family = "Garamond") +
  geom_line(colour = "darkgreen") +
  theme(text = element_text(size=20)) +
  ggtitle("Reduction In Cost For Values of 'k'\n") +
  xlab("\nClusters") +
  ylab("Within-Cluster Sum of Squares\n")