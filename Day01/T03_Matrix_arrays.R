# T03_Matrix_arrays.R - DESC
# T03_Matrix_arrays.R

# Copyright 2011-13 JRC FishReg. Distributed under the GPL 2 or later
# Maintainer: FishReg, JRC

# Introduction to R for Fisheries Science


# MATRIX

# A 2D structure of either numeric or character elements

# Constructed using matrix()

matrix(rnorm(10), ncol=10, nrow=10)

mat <- matrix(rnorm(100), ncol=10, nrow=10)

# Subsetting as in df

mat[1, 2]
mat[1, ,drop=FALSE]
mat[1:4,]

# Get size using dim
dim(mat)
length(mat)

# R works column first, unless instructed otherwise

a <- matrix(1:16, nrow=4)

b <- matrix(1:16, nrow=4, byrow=TRUE)

# An important method for matrices is apply()

mat <- matrix(1:10, ncol=10, nrow=10)

apply(mat, 2, sum)

apply(mat, 1, sum)

# Arithmetics work element-wise

mat + 2

mat * 2

mat - mat

# but matrix algebra is also defined

mat %*% 1:10

# ARRAY

# An array is an n-dimensional extension of a matrix

# Created by array(), specifying dim and dimnames

array(1:100, dim=c(5, 5, 4))

arr <- array(1:25, dim=c(5, 5, 4))

# Subsetting works as in matrix, on all dims (count the commas)

arr[1:3, 1:5, 4]

# but be careful with dimensions collapsing

arr[1,,]

arr[1,3,]

# Arithmetic (element by element) is well defined

arr * 2

arr + (arr / 2)

# apply is our friend here too

apply(arr, 2, sum)

apply(arr, 2:3, sum)