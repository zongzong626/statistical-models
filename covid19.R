# dataset : covid19 
# https://ourworldindata.org/
# location :Taiwan
# duration : 2020.01.16-2021.06.01 
# Encoding : UTF-8

library(ggplot2)  
library(forecast) 
library(dplyr)
library(tseries)
library(stats)

covid19 <- read.csv("C:/Users/user/Desktop/covid19.csv",h=T,fileEncoding="UTF-8-BOM")
covid19$date <- as.Date(covid19$date)
taiwan <- covid19[grep("Taiwan",covid19$location),]
ggplot(data=taiwan, aes(x=date, y=new_cases))+geom_point()+geom_line()
ggplot(data=taiwan, aes(x=date, y=new_cases))+geom_point()+geom_line()+scale_x_date(date_breaks = "1 month")
taiwan.ts <- ts(data=taiwan$new_cases, frequency = 365)
#taiwan.ts
fit <- auto.arima(taiwan.ts)
summary(fit)
forecast(fit,h=7)
plot(forecast(fit,h=7))
# 配置的不是很好 因為台灣在2021.05.15後才開始暴增 之前單日確診人數都沒超過50人
# covid19 台灣的資料沒有seasonal
# HoloWinters 三次指數平滑法
covid_HW <- HoltWinters(taiwan$new_cases, beta=F, gamma=F)
plot(covid_HW)
# 希望台灣早日能回到歸零的日子