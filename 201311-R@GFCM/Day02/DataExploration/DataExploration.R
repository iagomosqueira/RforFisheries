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

#
x > 1.5

# finally subset
which <- x2 > 1.5

# what are the corresponding y2 values when x2 is > 1.5?
y2[which]

# to see this
plot(x2, y2, type = "l")

lines(x2[which], y2[which], lwd = 4, col = "red")


lty - line type
lwd - line width
col - colour
pty - point type




# Excercise

# 1. make a vector than runs from 1990 to 2010 called "year"

year <- 1990:2010
year <- seq(1990, 2010)

# 2. calculate (year - 2000)^2, and store this in a vector called "catch"

catch <- (year - 2000)^2

# 3. make another vector of random normal noise with mean = 0 and sd = 10 the same length as catch.
# call this "noise"  using
#  rnorm()  - ?rnorm

noise <- rnorm(length(catch), mean = 0, sd = 10)

# 4. a) make a scatter plot of year against catch + noise
#    b) add a "red" line for year against catch

obs.catch <- catch + noise

plot(year, obs.catch)
lines(year, catch, col = "red")


# Lets now turn to some fisheries data

# first we will read in some data...

# set up a working directory

# and download the data files

# the data file is on our github page - the address of the file is
# https://github.com/iagomosqueira/RforFisheries/tree/master/201311-R%40GFCM

?read.csv

# make sure the file name is correct!
# some of you may have "catch_wt.txt"
catch_wt <- read.csv("catch_wt.csv")

catch_wt <- read.csv("catch_wt.txt")

str(catch_wt)

x <- 1

head(catch_wt, n = 2)

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
# 1/n * sum(x)
sum(age1) / length(age1)

# or more simply
mean(age1)

# the sample standard deviation
sd(age1)
var(age1)

# there are lots of summaries of data vectors
median(age1)

quantile(age1, .5)

quantile(age1, c(.25, .75))

min(age1)

max(age1)


summary(age1)

summary(catch_wt[1:2])


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

# try a simple data smoother
lines(lowess(year, age1), col = "blue")


#######################################
# working with data frames introduction
#######################################

# The simplest way to look at your data is to print it
catch_wt

# what is this?
str(catch_wt)

# it is a data.frame
head(catch_wt)

# Accessing the elements
names(catch_wt)

# the $ operator

catch_wt $ age1
catch_wt $ age2

# the [[ operator

catch_wt[["age1"]]
catch_wt[["age10"]]

# or

catch_wt[[1]]
catch_wt[[2]]


#######################################
# Using loops
#######################################

for (i in c(1,2,3)) {
  print(i)
}


for (i in c("hello", "ciao", "bonjour")) {
  print(i)
}



for (i in 1:4) {
  mean_wt <- mean(catch_wt[[i]])
  print(mean_wt)
}


# lets do something more useful

# creates a plot with 4 figures
par(mfrow = c(2,2))

# plotting with two vectors
year <- 1957:2008

for (i in 1:4) {
  weight <- catch_wt[[i]]
  plot(year, weight, type = "l") 
}

# use par(mfrow = c(2,2))


## exercise

# 1. plot mean weight for ages 5, 6, 7, 8

# creates a plot with 4 figures
par(mfrow = c(2,2))

# plotting with two vectors
year <- 1957:2008

for (i in 5:8) {
  weight <- catch_wt[[ paste0("age", i) ]]
  plot(year, weight, type = "l", 
        main = paste("mean weight age", i) )
  lines(lowess(year, weight), col = "blue")
}

# hint - use paste to build up names

# 2. a) add in useful titles to each plot
#    b) add in a lowess smooth of the data to each plot


#######################################
# brief introduction to functions
#######################################

# lets have a look at another data set
catch_n <- read.csv("catch_n.csv")

# again it comes in as a data.frame
str(catch_n)

# sometimes a useful thing to look at is the proportion of the catch

# numbers at age 1 / total numbers caught,  by year

catch_n $ age.1 / (catch_n $ age.1 + catch_n $ age.2 + catch_n $ age.3)

# there must be a better way!
catch_total <- rep(0, length(catch_n $ age.1))

# lets to a loop and keep a running total
for (i in names(catch_n)) {
  catch_total <- catch_total + catch_n[[i]]
}

#  So now the proportion at age 1 is:
catch_n $ age.1 / catch_total

#  So now the proportion at age 2 is:
catch_n $ age.2 / catch_total





