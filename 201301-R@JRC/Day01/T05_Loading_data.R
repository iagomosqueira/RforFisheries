# T05_Loading_data.R - DESC
# T05_Loading_data.R

# Copyright 2011-13 JRC FishReg. Distributed under the GPL 2 or later
# Maintainer: FishReg, JRC

# Introduction to R for Fisheries Science

# READ CSV

# read.table & friends

?read.table

# file, header=FALSE, sep="", dec=".", na.strings="NA", ...

# Read the ple4.csv file into a data.frame

ple4 <- read.csv("ple4.csv", header=TRUE)

# Plot the S/R datapoints

plot(ple4$ssb, ple4$rec, pch=19, xlab="SSB", ylab="recruits")

# but must add lag!
x <- ple4$ssb[-dim(ple4)[1]]
y <- ple4$rec[-1]

plot(x, y, pch=19, xlab="SSB", ylab="recruits")

# better add limits by hand

plot(x/1000, y/1000, pch=19, xlab="SSB (t 10^3)", ylab="recruits 10^3",
	ylim=c(0, max(y/1000)), xlim=c(0, max(x/1000)))

# a mean(rec)( line

abline(a=mean(y/1000), 0, col="red", lty=2)

# a lowess smoother

lines(lowess(x/1000, y/1000), col="blue", lty=3)
