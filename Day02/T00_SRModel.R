# T00_SRModel.R - DESC
# T00_SRModel.R

# Copyright 2011-13 JRC FishReg. Distributed under the GPL 2 or later
# Maintainer: FishReg, JRC

# Introduction to R for Fisheries Science

# LOAD data

sol <- read.table('sole.dat', header=T, sep='\t')
attach(sol)

# FUNCTION that returns minus log-likelihood (Beverton & Holt model)

foo <- function(par)
  sum(log(rec / (par[1] * ssb / (par[2] + ssb)))^2)

# CALL optimizer
res <- optim(c(5000, 1000), foo)

# CALCULATE estimated values
rechat <- res$par[1] * ssb / (res$par[2] + ssb)

# CALCULATE log residuals
lnresid <- log(rec / rechat)

# Total Sum of squares
sstot <- sum((log(rec) - mean(log(rec)))^2)

# R2
R2 <- 1 - (res$value/sstot)

# PLOT model fit
plot(ssb, rec, pch=19, xlab='SSB', ylab='recruits', xlim=c(0,max(ssb)),
  ylim=c(0, max(rec)))
pssb <- seq(0, max(ssb), length=200)
lines(pssb, res$par[1] * pssb / (res$par[2] + pssb), col='red')

# plot obs. vs. pred.
lim <- max(rec, rechat)
plot(rec, rechat, xlab='R', ylab=expression(hat(R)), pch=19,
  xlim=c(0, lim), ylim=c(0, lim))
lines(c(0, lim), c(0, lim), lty=2)

# plot residuals over time
barplot(lnresid, names.arg=year, ylab='Ln residuals', col='blue')
  abline(0, 0, lty=2)

# plot residuals over SSB
plot(ssb, lnresid, pch=19, xlab='SSB', ylab='Ln residual')
  abline(0, 0, lty=2)
