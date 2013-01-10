# T06_Functions.R - DESC
# T06_Functions.R

# Copyright 2011-12 JRC FishReg. Distributed under the GPL 2 or later
# Maintainer: FishReg, JRC

# Introduction to R for Fisheries Science

# function()

# A function is defined by an assignment of the form

# > name <- function(arg_1, arg_2, ...) expression

# foo

foo <- function(arg) {
  res <- arg + 1
  return(res)
}

# args: default values

foo <- function(x, power=2) {
  return(x ^ power)
}

foo(3)

foo(3, power=3)
foo(3, pow=3)

foo(3, 3)

# using with apply
df <- data.frame(x=rlnorm(20), y=rlnorm(20))

apply(df, 2, sum)

foo <- function(x) {
  x/mean(x)
}

apply(df, 2, sum)

x <- df

# option 1

y <- x/mean(x)
boxplot(y)

# option 2
boxplot(x/mean(x))

#
foo <- function(x) {
  boxplot(x/mean(x))
}

foo(df)

# Exercise 01

# Write a function to calculate the CV of a vector

cv <- function(x) {
  abs(sd(x)/mean(x))
}

cv(rnorm(90))

# apply it to a data.frame

apply(df, 2, cv)

# print the result on the console

cv <- function(x) {
  a <- abs(sd(x)/mean(x))
  cat(a)
  a
}

# include a plot option

foo <- function(x, plot=TRUE){
  y <- apply(x, 2, cv)
  if(plot) plot(y)
}

# SCOPE

foo <- function(x) {
  #a <- 9
  return(x + a)
}

foo(2)

a <- 3

foo(2)


# More information:

# http://manuals.bioinformatics.ucr.edu/home/programming-in-r

# http://www.johndcook.com/R_language_for_programmers.html
