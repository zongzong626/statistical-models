Clustering Analysis in R
Hierarchical (tree) Clustering.
We perform a hierarchical cluster analysis on a set of dissimilarities using
hclust(d, method = "complete", members=NULL)
Here "d" is a dissimilarity structure as produced by "dist". "method" is the agglomeration method to be used.  Example :

#install.packages('MVA')
library(MVA)
data(USArrests)
#hclust()階層式集群
hc <- hclust(dist(USArrests), method="single")
plot(hc)
plot(hc, hang=-1)
 
The function "dist" is used to calculate distances between the objects. Method "single" corresponds to single linkage. Other choices (the agglomeration methods) are "ward","complete",
"average","mcquitty","median" or "centroid".
For more details, type
help(hclust)

K-Means Clustering

The algorithm of Hartigan and Wong (1979) is used. The data given by "x" is clustered by the k-means algorithm using
kmeans(x, centers, iter.max = 10)
Here "x" is a numeric matrix of data, or an object that can be coerced to such a matrix (such as a numeric vector or a data frame with all numeric columns).  "centers" represents either the number of clusters or a set of initial cluster centers. "iter.max" is the maximum number of iterations allowed. 
Here is a 2-dimensional example :
x <- rbind(matrix(rnorm(100, sd = 0.3), ncol = 2),matrix(rnorm(100, mean = 1, sd = 0.3), ncol = 2))
cl <- kmeans(x, 2, 20)
plot(x, col = cl$cluster)
points(cl$centers, col = 1:2, pch = 8)

Another example :
x <- read.table("glass.txt",h=T)
km <- kmeans(x[,1:9], 2, 20)

View clusters of Variable 1 vs Variable 2 :
plot(x[,1:2], col = km$cluster)

To text the observations :
plot(x[,1:2], col = km$cluster,type="n")
text(x,row.names(x),cex=.8)

See all objects of km :
summary(km)

         Length Class  Mode  

cluster  114    -none- numeric

centers   18    -none- numeric

withinss   2    -none- numeric

size       2    -none- numeric

km$centers

        V1       V2        V3       V4       V5        V6       V7         V8

1 1.518447 14.05343 0.3025714 1.815714 73.06229 0.1751429 9.869714 0.56742857

2 1.517560 13.24380 3.3507595 1.402152 72.60582 0.6873418 8.429241 0.06962025

          V9

1 0.04600000

2 0.05835443

For more details, type
help(kmeans)

Other Clustering Methods in R
Generally speaking, cluster analysis methods are of either of two types. Hierarchical methods like agnes, diana and mona construct  a hierarchy of clusterings, with the number of clusters ranging from one to the number of observations. Partitioning methods like pam, clara and fanny require that the number of clusters be given by the user. These functions are in the package "cluster".
Agglomerative Nesting.
agne(x,diss=FALSE,metric="euclidean",stand=FALSE,method="single")
"x" is a data matrix or data frame. Missing values are allowed. The currently available options for "metric" are "euclidean" and "manhattan". The logical flag "stand", if TRUE, then the measurements in x are standardized before calculating. The five methods implemented are "average" (default),"single", "complete", "ward" and "weighted". Example :
library(cluster)
data(votes.repub)
agn <- agnes(votes.repub,metric="manhattan",stand=TRUE)
agn
plot(agn)

Divisive Analysis.
diana(x,diss=FALSE,metric="euclidean",stand=FALSE)
The logical flag "diss", if TRUE, then x will be considered as a dissimilarity matrix. Example :
data(votes.repub)
dv <- diana(votes.repub,metric="manhattan",stand=TRUE)
print(dv)
plot(dv)

Monothetic Analysis. >>只能用binary(0.1)的變數!
mona(x)
"x" is a data matrix or dataframe in which all variables must be binary. A limited number of missing values (NAs) is allowed.

Example :
data(animals)
ma <- mona(animals)
ma
plot(ma)

Partitioning Around Medoids.
pam(x,k,diss=FALSE,metric="euclidean",stand=FALSE)
Here "k" is a positive integer specifying the number of clusters, less than the number of observations. Example :
We generate 25 objects, divided into 2 clusters.
x <- rbind(cbind(rnorm(10,0,0.5),rnorm(10,0,0.5)),cbind(rnorm(15,5,0.5),rnorm(15,5,0.5)))
pamx <- pam(x,2)
summary(pamx)
plot(pamx)

Clustering Large Applications.
clara(x,k,metric="euclidean",stand=FALSE,samples=5,sampsize=40+2*k)
Here "samples" is the number of samples to be drawn from the dataset. "sampsize" is the number of observations in each sample.
It should be higher than the number of clusters k and at most the number of observations n=nrow(x). Example :
We generate 500 objects, divided into 2 clusters.

x <- rbind(cbind(rnorm(200,0,8),rnorm(200,0,8)),cbind(rnorm(300,50,8),rnorm(300,50,8)))
clarax <- clara(x,2)
clarax
clarax$clusinfo
plot(clarax)

Fuzzy Analysis.
fanny(x,k,diss=FALSE,metric="euclidean",stand=FALSE)
All values in x must be numeric. Missing values are allowed. It is also required that 0 < k < n/2 where n is the number of observations. Example :
We generate 25 objects, divided into 2 clusters, and 3 objects lying between those clusters.
x <- rbind(cbind(rnorm(10,0,0.5),rnorm(10,0,0.5)),cbind(rnorm(15,5,0.5),rnorm(15,5,0.5)),cbind(rnorm(3,3.5,0.5),rnorm(3,3.5,0.5)))
fannyx <- fanny(x,2)
summary(fannyx)
plot(fannyx)

Dissimilarity Matrix Calculation.
daisy(x,metric="euclidean",stand=FALSE,type=list())
Missing values in x are allowed. "type" lists containing some(or all) of the types of variables(columns) in x. The list may contain the components "ordratio"(ratio scaled variables to be treated as ordinal variables),"logratio" and "asymm". Variables not mentioned in the type list are interpreted as usual. Example :
data(agriculture)
d.agr <- daisy(agriculture,metric="euclidean",stand=FALSE)
d.agr

You can use help() to see a complete description for each function.

Clustering Using Self-Organizing Maps (SOM)
require(klaR)
data(iris)
library(som)
library(klaR)
irissom <- som(iris[,1:4], xdim = 6, ydim = 14)
shardsplot(irissom, data.or = iris, vertices = FALSE)
opar <- par(xpd = NA)
legend(7.5, 6.1, col = rainbow(3), xjust = 0.5, yjust = 0, legend = levels(iris[, 5]), pch = 16, horiz = TRUE)
par(opar)    