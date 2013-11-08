# Exercise 01

# 1. Create a vector of length 15, elements 1-7 increasing from 1,
# and 8-15 decreasing from 25
  something like 1,2,3,4,5,6,7   , 25, 23, 22, .... 

# How many ways can you find of doing it?

# 2. Substitute the 3rd and 7th element with NA

# 3. Calculate mean, var of the vector

# 4. Change all NA to 0


# Exercise 02

# 1. Create one numeric vector or random numbers and one character vector
# of the same length

# 2. Create a data frame with them

# 3. Add a column with 0 or 1 for values in numeric column > or <= 5

# 4. Extract rows with value of new column equal to 1

# S01_Vectors.R - Solutions to Exercise 01, vectors
# Day01/S01_Vectors.R

# Copyright 2011-13 JRC FishReg. Distributed under the GPL 2 or later
# Maintainer: FishReg, JRC

# Introduction to R for Fisheries Science

# Exercise 01

# 1. Create a vector of length 15, elements 1-7 increasing from 1,
# and 8-15 decreasing from 25

vec <- c(1:7, 25:18)

# How many ways can you find of doing it? Try not using c()

c(seq(1, 7), seq(25, 18, -1))

c(1, 2, 3, 4, 5, 6, 7, 25, 24, 23, 22, 21, 20, 19, 18)

c(1:7, rev(18:25))

# 2. Substitute the 3rd and 7th element with NA

vec[c(3, 7)] <- NA

# 3. Calculate mean, var and cv of the vector

mean(vec, na.rm=TRUE)

var(vec, na.rm=TRUE)

sd(vec, na.rm=TRUE) / mean(vec, na.rm=TRUE)

# 4. Change all NA to 0

vec[is.na(vec)] <- 0

mean(vec)

var(vec)


# Exercise 02

# 1. Create one numeric vector or random numbers and one character vector
# of the same length

val <- runif(20, 1, 8)

cha <- letters[1:20]

# 2. Create a data frame with them

df <- data.frame(val=val, names=cha)

# 3. Add a column with 0 or 1 for values in numeric column > or <= 5

cls <- df$val
cls[cls < 5] <- 0
cls[cls >= 5] <- 1
df$cls <- cls

ifelse(df$val < 5, 0, 1)

# 4. Extract rows with value of new column equal to 1

df[df$cls == 1,]
