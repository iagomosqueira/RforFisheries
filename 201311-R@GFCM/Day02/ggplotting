#GGPLOTing

#Load the catch wt data

catch_wt <- read.csv("/media/E/Rcourse/catch_wt.csv", sep=";")

library(ggplot2)

# let's start simple

# Breaking down the plotting loggic of ggplot:

library(reshape2)
#1 Define your dataset and what you want to plot

ggplot(catch_wt, aes(x=year, y=age1))+geom_point()+geom_point(aes(x=year, y=age2, color=2))

ggplot(catch_wt, aes(x=year, y=age1))+geom_point()+stat_smooth(aes(x=year, y=age2, color=2))

# reshape the data from a matrix form to a long table version
catch_wtM<-melt(catch_wt, measure.vars=c("age1",  "age2",  "age3",  "age4" , "age5" , "age6" , "age7",  "age8",  "age9" , "age10"))

ggplot(catch_wtM, aes(x=year, y=value, color=variable))+geom_point()+stat_smooth()


ggplot(catch_wtM, aes(x=year, y=value, color=variable))+geom_point()+stat_smooth()+facet_grid(.~variable)

ggplot(catch_wtM, aes(x=year, y=value, color=variable))+geom_point()+stat_smooth(method="lm")+facet_grid(.~variable)
