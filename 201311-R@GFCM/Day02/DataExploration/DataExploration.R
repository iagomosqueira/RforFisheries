# Tutorial: Introduction to FLQuant objects
# Copyright 2013 FLR Core Development Team
# Distributed under the GPL 2 or later

#-------------------------------------------------------
# Exploring data
#-------------------------------------------------------

# a quick recap

a <- 1
a

a + a
b <- a + a
b

x <- c(a, b)
x

x <- seq(a, b, length = 5)
x
length(x) # should be 5

# plot x
plot(x)

# plot a function of x
y <- (x - 1.5)^2
plot(x, y)

# use extra arguments to plot
plot(x, y, col = "blue", lty = 2, type = "l")

# add another line
x2 <- seq(a, b, length = 100)
y2 <- (x2 - 1.5)^2
lines(x2, y2)

# finally subset
which <- x2 > 1.5

# what are the corresponding y2 values when x2 is > 1.5?
y2[which]

# to see this
plot(x2, y2, type = "l")
abline(v = 1.5, lty = 2)
lines(x2[which], y2[which], lwd = 4, col = "red")

# Excercise

# 1. make a vector than runs from 1990 to 2010 called "year"

# 2. calculate (year - 2000)^2, and store this in a vector called "catch"

# 3. make another vector of random normal noise with mean = 0 and sd = 10 the same length as catch.
# call this "noise"

# 4. a) make a scatter plot of catch + noise against year
#    b) add a "red" line for catch against year



# Lets now turn to some fisheries data

# first we will read in some data...

?read.csv

# the data file is on our github page - the address of the file is
# https://github.com/iagomosqueira/RforFisheries/tree/master/201311-R%40GFCM

catch_wt <- read.csv("catch_wt.csv")
catch_n <- read.csv("catch_n.csv")

str(catch_wt)

head(catch_wt)

tail(catch_wt)

#  Lets take one column
age1 <- catch_wt $ age1

age1
# this is a vector, just like we have seen already

# we can explore the data using the functions we already know:

# the sum of the data 
sum(age1)

# the number of values in the vector
length(age1)

# so we can now calculate the mean
sum(age1) / length(age1)

# or more simply
mean(age1)

# the sample standard deviation
sd(age1)

# or written out in full
sqrt( sum( (age1 - mean(age1))^2 ) / (length(age1) - 1) )

# shortcuts are nice!


# there are lots of summaries of data vectors
median(age1)

quantile(age1, .5)

quantile(age1, c(.25, .75))

min(age1)

max(age1)

summary(age1)

signif(mean(age1), 3)


# plotting the data is also useful
plot(age1)

# to get a line plot
plot(age1, type = "l")

abline(h = median(age1), col = "red")

abline(h = quantile(age1, c(.05, .95)), lty = 2)


# plotting with two vectors
year <- 1957:2008

# plot age 2 agains age 1
plot(year, age1, type = "l", main = "mean weight at age 1", lwd = 2)
abline(h = median(age1), col = "red")
abline(h = quantile(age1, c(.05, .95)), lty = 2)

# try a simple data smoother
lines(lowess(year, age1), col = "blue")


#######################################
# working with data frames
#######################################

# The simplest way to look at your data is to print it
catch_wt

# what is this?
str(catch_wt)

# it is a data.frame

head(catch_wt)


# let's convert it to a matrix
sn.mat <- as.matrix(sn)
sn.mat




