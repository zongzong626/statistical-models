fastICA:

c<-read.table("citycrime.txt",h=T)
install.packages('fastICA')
library(fastICA)

The data matrix X is considered to be a linear combination of non-Gaussian (independent) components 
i.e. X = SA where columns of S contain the independent components and A is a linear mixing matrix. 
In short ICA attempts to `un-mix' the data by estimating an un-mixing matrix W where XW = S.

Request a 2-D solution:

a <- fastICA(c,2)

The estimated mixing matrix:

a$A
          [,1]      [,2]       [,3]       [,4]      [,5]      [,6]      [,7]
[1,] -1.724861  5.128444  -95.56283   86.13376  150.1625 1184.9904 -178.8074
[2,] -9.081217 -9.253246 -316.50592 -373.76809 -453.0883 -614.2615 -664.5164

par(mfcol = c(2, 3))

Plotting Mixed signals:

plot(1:72, c[,1], type = "l", main = "Mixed Signals D-1")
plot(1:72, c[,2], type = "l", main = "Mixed Signals D-2")

Plotting ICA Source Estimates:

plot(1:72, a$S[,1], type = "l", main = "ICA Source Estimate D-1")
plot(1:72, a$S[,2], type = "l", main = "ICA Source Estimate D-2")