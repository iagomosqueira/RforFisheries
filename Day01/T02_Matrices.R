# E02_Matrices.R - DESC
# E02_Matrices.R

# Copyright 2011-13 JRC FishReg. Distributed under the GPL 2 or later
# Maintainer: FishReg, JRC

# Introduction to R for Fisheries Science

# Exercise 01

# 1. Create a matrix with 10 rows and 15 columns, containing random
# numbers (choose your distribution)

mat <- matrix(rlnorm(150), ncol=15, nrow=10)

# 2. Subset the first 5 rows and columns of this matrix

sub <- mat[1:5,1:5]


# 3. Sum the matrix by row

apply(sub, 2, sum)

sum(sub[,5])
