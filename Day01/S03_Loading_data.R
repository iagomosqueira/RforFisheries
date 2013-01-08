# E03_Loading_data.R - DESC
# E03_Loading_data.R

# Copyright 2003-2013 FLR Team. Distributed under the GPL 2 or later
# Maintainer: Iago Mosqueira, JRC
# $Id: $
# Created:
# Modified:


# http://dl.dropbox.com/u/389113/ple4.csv

# (1) Load ple4.csv

ple4 <- read.table(file="ple4.csv", sep=",", header=TRUE)

# (2) plot() catch time series 

plot(ple4$year, ple4$catch, pch=19, type="b")

plot(ple4$catch~ple4$year, pch=19, type="b")

hist(ple4$catch)

# (3) Get summary statistics for catch and ssb

summary(ple4[,-1])

# (4) Draw a stock-recruitment plot

plot(ple4$ssb, ple4$rec, pch=19, cex=0.5, xlim=c(0, max(ple4$ssb)),
	ylim=c(0, max(ple4$rec)))
