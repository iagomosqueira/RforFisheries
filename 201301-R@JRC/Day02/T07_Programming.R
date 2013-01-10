# 03_Programming.R - Writing your own functions
# Second/02_Functions.R

# Copyright 2011-12 JRC FishReg. Distributed under the GPL 2 or later
# Maintainer: FishReg, JRC

# Introduction to R for Fisheries Science

# IF ELSE

# Flow of code according to comparison

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




foo <- function(a){
  if(is.numeric(a)){
    b <- a+1
  } else {
    #print("need a numeric")
    #cat("need a numeric")
    stop("need a numeric")
  }
  b^2
}

# FOR

# for loops allow for repetition of actions

# for(INDEX in SEQUENCE) { ACTION }


for(i in seq(1, 10))
  print(i)


# A simple population model: exponential growth of bacteria

foo <- function(ngen, gmod, gr=NULL){
  n <- rep(NA, ngen)
  n[1] <- 1
  if(gmod=="linear"){
    for (i in 2:ngen) n[i] <- gr * n[i-1]
  }
  if(gmod=="exponential"){ 
    for (i in 2:ngen) n[i] <- exp(n[i-1])
  }
  plot(1:ngen, n, type='b', pch=19)
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

