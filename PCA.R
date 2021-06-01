PCA in R 
The following R commands perform PCA on the following data set (you can download it from the "Data Sets" folder). 
The data give crime rates per 100,000 people for the 72 largest US cities in 1994. 
The variables are: 
  1) Murder 
  2) Rape 
  3) Robbery 
  4) Assault 
  5)  Burglary 
  6) Larceny 
  7) Motor Vehicle Thefts 
  

The data are saved in the "citycrime.txt" file that I read next. 
crime<-read.table("citycrime.txt") 

We can then look at the scatterplot matrix 

pairs(crime) 

Load next the multivariate analysis library. 

library(stats) 

Then apply PCA on the correlation matrix by rescaling and centering the data using the R function princomp 

pca.crime<-princomp(scale(crime,scale=TRUE,center=TRUE),cor=TRUE) #¼Ð·Ç¤Æ

Look at the results 

summary(pca.crime) 

                                        Comp. 1   Comp. 2   Comp. 3    Comp. 4     Comp. 5 
Standard deviation       1.948024 1.0950164 0.8771129 0.71434047 0.57690506 
Proportion of Variance 0.542114 0.1712944 0.1099039 0.07289747 0.04754564 
Cumulative Proportion 0.542114 0.7134084 0.8233123 0.89620976 0.94375539 

                                       Comp. 6    Comp. 7 
Standard deviation       0.4617666 0.42483396 
Proportion of Variance 0.0304612 0.02578341 
Cumulative Proportion 0.9742166 1.00000000 

Calculate the loadings. Note that it defines loadings without multiplying by the sqrt of lambda - this is not unique to R, SAS gives similar results also.  Be aware that people use the term in both ways. 

loadings(pca.crime) 
  
                    Comp.1      Comp.2        Comp.3            Comp.4         Comp.5         Comp.6 
Murder   -0.3703162  -0.3393305  -0.20197401    0.716536320   -0.27667317    0.2195058 
Rape       -0.2494347    0.4665068  -0.78285390  -0.158647300     0.09801765    0.2666223 
Robbery  -0.4260252  -0.3878604  -0.07906463  -0.022205333     0.19425099  -0.1467357 
Assault   -0.4340165    0.0424326     0.28183161    0.004121735     0.76699528    0.1184636 
Burglary -0.4497241    0.2382532   -0.01503743  -0.054744947  -0.24207660  -0.7940676 
Larceny  -0.2759217    0.6055442     0.49241798     0.209243512  -0.26414901    0.3028892 
MVT      -0.3903791  -0.3025585     0.13403135   -0.643519086  -0.39931631    0.3505418 
                   Comp.7 
Murder     0.26224431 
Rape       -0.03781056 
Robbery  -0.77592380 
Assault     0.35786553 
Burglary   0.22049052 
Larceny  -0.33076964 
MVT        0.20407887 

Calculate the PCs. 

pcs.crime<-predict(pca.crime) 

Check out the screeplot. 
eigen<-eigen(cor(crime)) 
plot(eigen$values,type="h") 

Plot the first 2 PCs. 
plot(pcs.crime[,1:2],type="n",xlab='1st PC',ylab='2nd PC') 
text(pcs.crime[,1:2],row.names(crime)) 

Plot also the biplot. 
biplot(pca.crime,scale=1) 