# T04_data.frame.R - DESC
# T04_data.frame.R

# Copyright 2011-13 JRC FishReg. Distributed under the GPL 2 or later
# Maintainer: FishReg, JRC

# Introduction to R for Fisheries Science


# DATA FRAME 

# A 2D table of data

# Example:

year <- seq(2000, 2010)
catch <- c(900, 1230, 1400, 930, 670, 1000, 960, 840, 900, 500,400)

dat <- data.frame(year=year, catch=catch)

# A data.frame can be inspect using

# summary

summary(dat)

# or head/tail

head(dat)
tail(dat)

# and its size with dim
dim(dat)

# Access individual columns using $
dat$year

# or, either by name
dat[, 'catch']

# or position
dat[, 2]

# Same for rows
dat[1:5,]

# Selection based on boolean logic comes handy
# e.g. select those rows matching year=2004
dat[dat$year==2004,]

# Adding extra columns of various types
dat$area <- rep(c("N", "S"), length=11)

dat$survey <- c(TRUE, FALSE, FALSE, rep(TRUE, 5), FALSE, TRUE, TRUE)


# LIST

# A list is a very flexible container. Element can be of any class and size

lst <- list(data=dat, description="Some data we cooked up")

# Extract elements by name using $
lst$dat

is.data.frame(lst$dat)

# or using [ and [[
# [ name/position subsets the list
lst[1]

is(lst[1])

# while [[ extracts the subset element
lst[[1]]

is(lst[[1]])


# Lists can be nested. Use with caution!

lst$repetition <- lst



