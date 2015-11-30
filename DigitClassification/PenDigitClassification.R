#CaseStudy3
library(cluster)
library(ggvis)
library(plyr)
library(dplyr)
library(ggplot2)
library(shinythemes)

train <- read.csv("data/pendigits.tra")
train_nodig <- train[,-17]

wss = kmeans(train_nodig, centers=1)$tot.withinss
for (i in 2:13)
  wss[i] = kmeans(train_nodig, centers=i)$tot.withinss

sse = data.frame(c(1:13), c(wss))
names(sse)[1] = 'Clusters'
names(sse)[2] = 'SSE'
sse %>%
  ggvis(~Clusters, ~SSE) %>%
  layer_points(fill := 'blue') %>% 
  layer_lines() %>%
  set_options(height = 300, width = 400)

clusters = kmeans(train, 10)
clusters

train$Cluster = clusters$cluster
head(train)

clusplot(train, clusters$cluster, color=T, shade=F,labels=0,lines=0, main='k-Means Cluster Analysis')

comp = train %>% group_by(Cluster, X8) %>% summarise(count=n())

#Alternate Method

res.kmeans <- lapply(1:10, function(i) {
  kmeans(train , centers = i)
#  kmeans(train[,c("Sepal.Length","Sepal.Width")], centers = i)
})

## Sum up SS
res.within.ss <- sapply(res.kmeans, function(x) sum(x$withinss))
plot(1:10, res.within.ss, type = "b", xlab = "Number of clusters", ylab = "Within SS")


ggplot(data.frame(cluster = 1:10, within.ss = res.within.ss), aes(cluster, within.ss)) +
  geom_point() + geom_line() +
  scale_x_continuous(breaks = 0:10)

## SS for each cluster (1 cluster to 10 clusters)
lapply(res.kmeans, function(x) x$withinss)

cluster.colors <- lapply(res.kmeans, function(x) x$cluster)

#Could make the compared parameters an input to shiny
#make Colnames input to shiny
l_ply(cluster.colors,
      function(colors) {
        plot(X100 ~ X81, train, col = colors, main = paste(nlevels(factor(colors))), pch = 16)
        #100,81 --
      })

l_ply(cluster.colors,
      function(colors) {
        plot(X56 ~ X8, train, col = colors, main = paste(nlevels(factor(colors))), pch = 16)
        #100,81 --
      })

l_ply(cluster.colors,
      function(colors) {
        plot(X56 ~ X37, train, col = colors, main = paste(nlevels(factor(colors))), pch = 16)
        #100,81 --
      })
