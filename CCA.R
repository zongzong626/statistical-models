Canonical Correlation Analysis (CCA)

The following R commands perform a simple CCA on the following data set (download the data set from the "Data Sets" folder). 
The data come from 2000 US News magazine which ranks 42 US colleges according to some evaluation items. 
Six variables are Academic (Academic Reputation), Grad_rate (Graduation Rate), SAT_P25 (SAT 25th percentile score), SAT_P75 (SAT 75th percentile score), HS_P10 (ratio of High School top 10% students), Accept_rate (rate of Acceptance for Applications). 

The data are in the "new_col2000.txt" file that I read next. 

col<-read.table("new_col2000.txt",h=T) 

Load next the "stats" library. 

library(stats) 

Then seperate the 6 variables into two groups. 
The first group has 3 variables Academic, Grad_rate, and Accept_rate. 
The second group has 3 variables SAT_P25, SAT_P75, and HS_P10. 

x<-cbind(col[,1],col[,2],col[,6]) 
y<-cbind(col[,3],col[,4],col[,5]) 

Standardize all variables and apply CCA to the two groups using the R function "cancor". 

cxy<-cancor(scale(x,scale=T,center=T),scale(y,scale=T,center=T)) 

Check out the results: 

cxy 

$cor                                        #√λ
[1] 0.9138012 0.4853202 0.1060088

$xcoef                                      #看直的!!! u1=0.089 0.033 -0.0498 我們可選第一個就好!
            [,1]        [,2]        [,3]
[1,]  0.08974032 -0.19011912 -0.06046737
[2,]  0.03330972  0.16560726 -0.22826530
[3,] -0.04986535 -0.04022887 -0.28403564

$ycoef                                       #一樣看直的!!! v1=-0.1769 0.304 0.036 應選第一個和第二個! #學術價值高的 好學生也多
            [,1]        [,2]        [,3]
[1,] -0.17690301  0.85320991 -0.14228895                                                                   
[2,]  0.30493077 -0.84344730  0.01596496
[3,]  0.03635201  0.05630199  0.16833153

$xcenter
[1] -5.974057e-16 -3.320096e-15  5.231224e-16

$ycenter
[1]  9.542631e-16 -3.304235e-16 -1.691768e-16

To visualize the result in the first canonical variate space, you can use 

xx<-scale(x,scale=T,center=T) 
yy<-scale(y,scale=T,center=T) 
scorex<-xx%*%cxy$xcoef[,1]                  #variable*其coefficient
scorey<-yy%*%cxy$ycoef[,1] 
plot(scorex,scorey,type="n") 
text(scorex,scorey,row.names(col),cex=.6) 

Note that R does not provide the likelihood ratio test for the significance of eigenvalues. 
It turns out that SAS has more complete output for CCA. 
However, you can calculate the Wilks' statistic and perform a chi-square test to determine the number of canonical variates. 