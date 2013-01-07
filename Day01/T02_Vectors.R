# T02_Vectors.R - Solutions to Exercise 01, vectors
# Day01/T02_Vectors.R

# Copyright 2011-13 JRC FishReg. Distributed under the GPL 2 or later
# Maintainer: FishReg, JRC

# Introduction to R for Fisheries Science


# NUMERIC VECTORS

# Vectors can be created as a sequence, using : or seq()

ov <- 1:10

seq(1, 10, by=2)
seq(1, 10, length=20)

# or by contatenating elements, using c()

on <- c(1,5,7,6,3,4,4,1,2)

# Many functions operate on vectors naturally

mean(on)

var(on)

# TODO Arithmetics

# Subsetting can select one or more elements,
# including or excluding

ov[3]

ov[3:5]

ov[-1]

# Information on a vector, like
# length

length(ov)

# summary of values

summary(ov)

# Some eye candy

plot(ov)

# equivalent to

plot(1:length(ov), ov)

# try some of plot extra arguments

dat <- rnorm(20, 5, 6)

plot(dat, main="Some random numbers", xlab="", ylab="N", type='b')

# When in doubt, use is()
is(ov)

is.numeric(ov)
is.vector(ov)

# STRINGS (CHARACTERS)

# Vectors can also consist of strings

# Use quotes to create them

a <- "welcome to"
b <- "the R course"

# We can combine them in a longer string

msg <- c(a,b)

# Using paste converts to character if needed
paste(a, b, 2013)

# Checking data type
is.vector(msg)

is.numeric(msg)

is.character(msg)


# FACTOR

# Character data with a limited set of possible values

dir <- c("N", "S", "W", "E")

dir <- as.factor(dir)

levels(dir)

dir[1] <- "S"

# Values not in levels() are not valid

dir[2] <- "P"


# LOGICAL

# R has explicit logical elements: TRUE and FALSE

res <- c(TRUE, FALSE)


# what are they?

is(res)

is.logical(res)

# Logicals are commonly used for subsetting

dat <- 1:4

dat[c(TRUE, FALSE, FALSE, TRUE)]


# SPECIAL VALUES

# R has special representations of

# Inf

Inf

1/0

# Not-a-number

NaN

1/0 - 1/0
sin(Inf)

# Not Available
NA

dat <- c(1, 4, 8, 9, NA, 12)

dat

is.na(dat)

# Some functions can deal with NA as required
mean(dat)

res <- mean(dat, na.rm=TRUE)

sum(dat, na.rm=TRUE)


# EX01_Vectors.R
