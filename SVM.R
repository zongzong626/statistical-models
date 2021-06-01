SVM in R 
Now we perform SVM for the fish data. 
First read data from the file "fish.dat". (you might save it as a different file) 

fish<-read.table("fish.dat",h=T) 
Load next the "e1071" library. 

install.packages('e1071')
library(e1071)

Then apply SVM on the data using the R function svm: 

s<-svm(fish[,2:7],fish[,1]) 

Note that the default settings are: cost=1, kernel=RBF, gamma=1/(# of variables). 
Check out the summary of the output: 
summary(s) 

Parameters:
   SVM-Type:  C-classification 
 SVM-Kernel:  radial 
       cost:  1 
      gamma:  0.1666667 

Number of Support Vectors:  85

 ( 12 5 18 8 4 8 30 )

Number of Classes:  7 

Levels: 
 bream parki perch pike roach smelt white

Use the SVM classifier to predict the classes of the original data: 

pred<-predict(s,fish[,2:7])
table(pred,fish[,1])
       
pred    bream parki perch pike roach smelt white
  bream 33     1     0     0    0     0     0   
  parki  0     9     0     0    0     0     0   
  perch  0     0    54     0   18     1     5   
  pike   0     0     0    16    0     0     0   
  roach  0     0     0     0    0     0     0   
  smelt  0     0     0     0    0    11     0   
  white  0     0     0     0    0     0     0

==>The apparent error rate is 25/148.
We can change gamma to get a new (or better) classifier:

s1<-svm(fish[,2:7],fish[,1],gamma=1)
pred1<-predict(s1,fish[,2:7])
table(pred1,fish[,1])
       
pred1   bream parki perch pike roach smelt white
  bream 33     0     0     0    0     0     0   
  parki  0    10     0     0    0     0     0   
  perch  0     0    53     0   11     0     4   
  pike   0     0     0    16    0     0     0   
  roach  0     0     1     0    7     0     1   
  smelt  0     0     0     0    0    12     0   
  white  0     0     0     0    0     0     0   

==>The new error rate is 16/148, which becomes significantly smaller.
#增加GAMMA 會使得分群分得更好!!!
Choose an even larger gamma:

s5<-svm(fish[,2:7],fish[,1],gamma=5)
pred5<-predict(s5,fish[,2:7])
table(pred5,fish[,1])
       
pred5   bream parki perch pike roach smelt white
  bream 33     0     0     0    0     0     0   
  parki  0    10     0     0    0     0     0   
  perch  0     0    54     0    7     0     1   
  pike   0     0     0    16    0     0     0   
  roach  0     0     0     0   11     0     1   
  smelt  0     0     0     0    0    12     0   
  white  0     0     0     0    0     0     3 

==>The new error rate is 9/148.
Theoretically, the increase of gamma will derive an apparent error rate 0.
However, this might cause an over-fitting problem which affects the "true error rate".
Now we use a 20-fold CV to derive a good combination of (cost,gamma) based on grid search:

(1) Let's start with (cost=0.1,gamma=0.1):
c1<-svm(fish[,2:7],fish[,1],cost=0.1,gamma=0.1,cross=20)
summary(c1)
..........................................
20-fold cross-validation on training data:

Total Accuracy: 62.83784

(2) Change to (cost=0.5,gamma=0.1):
c1<-svm(fish[,2:7],fish[,1],cost=0.5,gamma=0.1,cross=20) #cross=20代表作20次的cross validation
summary(c1)
..........................................
20-fold cross-validation on training data:

Total Accuracy: 82.43243

(3) A global search finally shows that (cost=100,gamma=0.2) has almost the smallest 
    estimated true error rate 9% : 
c1<-svm(fish[,2:7],fish[,1],cost=130,gamma=0.2,cross=20) 
summary(c1)
..........................................
20-fold cross-validation on training data:

Total Accuracy: 90.54054

#寫一個迴圈去試試看!(cost gamma cross>fixed!)
c1$tat.accuracy

Based on the optimal choice (cost=100,gamma=0.2), we can fit a new SVM model for all training data:

c1<-svm(fish[,2:7],fish[,1],cost=100,gamma=0.2)
pred<-predict(c1,fish[,2:7])
table(pred,fish[,1])
       
pred    bream parki perch pike roach smelt white
  bream 33     0     0     0    0     0     0   
  parki  0    10     0     0    0     0     0   
  perch  0     0    54     0    1     0     0   
  pike   0     0     0    16    0     0     0   
  roach  0     0     0     0   16     0     0   
  smelt  0     0     0     0    0    12     0   
  white  0     0     0     0    1     0     5 

==> Note that this classifier also has a very low apparent error rate 2/148.
The most important thing is, it is a better classifier for prediction.
Now we use this classifier to predict the test data:

test<-read.table("fish_test.dat",h=T)
pred.test<-predict(c1,test)
pred.test
 [1] parki bream perch perch pike smelt smelt parki roach roach white