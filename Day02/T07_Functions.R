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
  res <- arg + b
  return(res)
}

x<-1

foo(x)

res

# args: default values

foo <- function(x, power=2) {
  return(x ^ power)
}

foo(3)

foo(3, power=3)
foo(power=3, 1)
foo(3, pow=3)

foo(3, 3)

# using with apply
df <- data.frame(x=rlnorm(20), y=rlnorm(20))

apply(df, 2, sum)

foo <- function(x) {
  return(x/mean(x))
}

apply(df, 2, foo)


# Exercise 01

# Write a function to calculate the CV of a vector

cv <- function(x)

cv(rnorm(100))



cv <- function(x, na.rm=TRUE) {
  return(abs(sd(x, na.rm=na.rm)/mean(x, na.rm=na.rm)))
}

cv <- function(x) {
  return(abs(sd(x)/mean(x)))
}


cv(rnorm(90))

apply(df, 2, cv)

# divsum, what does it do?

divsum <- function(x) {

  su <- apply(x, 2, sum)

  res <- x / matrix(rep(su, each=5), nrow=nrow(x))

  return(res)

}


# Testing it

mat <- matrix(1:20, ncol=4)

divsum(mat)

apply(divsum(mat), 2, sum)

# Will this work?

divsum(x)

# vs.

divsum(x=mat)


# SCOPE

foo <- function(x) {
  a <- 9
  return(x + a)
}

foo(2)

a <- 3

foo(2)


# More information:

# http://manuals.bioinformatics.ucr.edu/home/programming-in-r

# http://www.johndcook.com/R_language_for_programmers.html
