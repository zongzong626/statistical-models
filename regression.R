## Scatterplot + regression line
HOMES2 <- read.table("d02_HOMES2.txt",header=TRUE) #Read data for analysis
attach(HOMES2)
fit <- lm(Y~X)
summary(fit)
plot(X,Y,ylab = "Y=sale price (in thousands of dollars)", 
	xlab = "X=floor size")
abline(fit)

## Manual calculations ----------------------------------------------------
SXYd <- sum( (X-mean(X))*(Y-mean(Y)) )
SXd2 <- sum( (X-mean(X))^2 )
b1 <- SXYd/SXd2			# = coefficient of X = b1.hat
b0 <- mean(Y)-b1*mean(X)	# = coefficient of intercept = b0.hat

SYd2 <- sum( (Y-mean(Y))^2 )		# Note that this is in fact SST!
SSE <- sum(residuals(fit)^2)		# Also: sum( (fitted(fit)-Y)^2 )

R.sq <- 1-SSE/SYd2

n <- length(Y)

sigma.hat <- sqrt(SSE/(n-2))		# summary(fit)$sigma

se.b1 <- sqrt(summary(fit)$sigma^2/SXd2)
	# = standard error of b1.hat
se.b0 <- sqrt( summary(fit)$sigma^2 * (1/length(X) + mean(X)^2/SXd2) )
	# = standard error of b0.hat


## Summary of regression ---------------------------------------------------
summary(fit)			# R.sq, sigma.hat, se.b0, se.b1 are printed

confint(fit)			# confidence intervals for model parameters
confint(fit, "X", level=0.90)	# confidence interval for b_1, alpha=0.10

	## Advanced practice
	anova(fit)
	#! sqrt('Residual Mean Sq' in anova()) = 'Residual standard error' in summary()
	#! (In R) anova() and summary() cannot be derived from each other, as the info 
	#! about (X-X_bar) is not shown in anova(), and the info about (Y-Y_bar)
## -------------------------------------------------------------------------


## Diagnostic Plots - Residual plot
# par(mfrow=c(1,2))
plot(X, residuals(fit), xlab="X", ylab="Residuals")
abline(h=0)

plot(fitted(fit), residuals(fit), xlab="Fitted", ylab="Residuals")
abline(h=0)

## Diagnostic Plots - Histogram on Residuals
hist(residuals(fit))

## Diagnostic Plots - QQ-plot
fit$fitted;		fitted(fit)
fit$residual;	residuals(fit)
qqnorm(residuals(fit), ylab="Residuals")
qqline(residuals(fit))

## Prediction Interval of Y given new observed x
xnew <- data.frame(X=2)
predict(fit, xnew, interval="prediction", level=0.95)
# predict(fit, xnew, interval="prediction", level=0.95)
# predict(fit, xnew, interval="confidence", level=0.95)

## CI plot
xy <- data.frame(X=pretty(X))
yhat <- predict(fit, newdata=xy, interval="confidence")
ci <- data.frame(lower=yhat[,"lwr"], upper=yhat[,"upr"])
plot(X,Y, main ="Confidence Interval",
	ylab = "Y = sale price (in thousands of dollars)", 
	xlab = "X = floor size (in thousands of dollars)")
abline(fit)
lines(xy$X, ci$lower, lty=2, col="red")
lines(xy$X, ci$upper, lty=2, col="blue")

## Advanced Practice: CI & PI plot
yhat.pi <- predict(fit, newdata=xy, interval="prediction")
pi <- data.frame(lower=yhat.pi[,"lwr"], upper=yhat.pi[,"upr"])
plot(X,Y, main ="Confidence and Prediction Intervals",
	ylab = "Y = sale price (in thousands of dollars)", 
	xlab = "X = floor size (in thousands of dollars)")
abline(fit)
lines(xy$X, ci$lower, lty=2, col="red")
lines(xy$X, ci$upper, lty=2, col="red")
lines(xy$X, pi$lower, lty=2, col="blue")
lines(xy$X, pi$upper, lty=2, col="blue")

## -------------------------------------------------------------------------
## Some additional info 

summary(fit)$sigma		# residual standard error
summary(fit)$r.squared		# R^2
summary(fit)$adj.r.squared	# adjusted R^2

summary(fit)$cov.unscaled
summary(fit, correlation=TRUE)$correlation