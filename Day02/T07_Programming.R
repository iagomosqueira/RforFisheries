# T07_Programming.R - Writing your own functions
# T07_Programming.R

# Copyright 2011-13 JRC FishReg. Distributed under the GPL 2 or later
# Maintainer: FishReg, JRC

# Introduction to R for Fisheries Science

# IF ELSE

# Flow of code according to a logical comparison

# if(COMPARISON) ACTION
# else ACTION

foo <- function(x) {
  if(x > 2) {
    print("x is larger than 2")
  } else {
    print("it is not!")
  }
}

foo(9)

foo(1)


# FOR

# for loops allow for repetition of actions

# for(INDEX in SEQUENCE) { ACTION }


for(i in seq(1, 10))
  print(i)


# A simple population model: exponential growth of bacteria

foo <- function(){
n <- rep(NA, 10)

n[1] <- 1

for (i in 2:10) {
  n[i] <- 2 * n[i-1]
}

plot(1:10, n, type='b', pch=19)
} 

# Exercise 01: How to make it more generic?

# Length of time (No. of generations)

# Growth rate

# Function

expgr <- function(gen=10, r=2, plot=TRUE) {
  
  n <- rep(NA, gen)

  n[1] <- 1

  for (i in 2:gen) {
    n[i] <- r * n[i-1]
  }
  if(plot == TRUE)
    plot(n)
  
  return(n)
}

expgr(25, plot=FALSE)

