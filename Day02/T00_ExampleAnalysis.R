# T00_ExampleAnalysis.R - DESC
# T00_ExampleAnalysis.R

# Copyright 2011-13 JRC FishReg. Distributed under the GPL 2 or later
# Maintainer: FishReg, JRC

# Introduction to R for Fisheries Science

# LOAD North Atlantic Oscillation (NAO) datafile 
# http://www.esrl.noaa.gov/psd/data/climateindices/list/

nao <- read.table("http://www.cdc.noaa.gov/data/correlation/nao.data",
	skip=1, nrow=64, na.strings="-99.90")

# INSPECT data.frame

head(nao)

# FIX column names

colnames(nao)
colnames(nao) <- c("year", month.name)

summary(nao)

# SUBSET to drop years with no values
nao <- nao[-c(1,2),]

# CALCULATE and PLOT mean value by year

yearMean <- apply(nao[,-1], 1, mean)

plot(nao$year, yearMean, pch=19, type="b", xlab="", ylab="NAO, year mean")

# BARPLOT of monthly series
tsnao <- c(t(as.matrix(nao[,-1])))
color <- ifelse(tsnao>=0, "red", "gray")
barplot(tsnao, col=color, border=color)

# BARPLOT of spring series
sprnao <- apply(nao[,c(3,4,5)], 1, mean)
color <- ifelse(sprnao>=0, "red", "gray")
bars <- barplot(sprnao, col=color, border=color)

lines(bars, lowess(sprnao)$y)


# North Sea Sole SR data

sol <- read.table("sole.dat", sep="\t", header=TRUE)

# INSPECT data

summary(sol[,-1])

# PLOT SR relationship

plot(sol$rec[-1]~sol$ssb[-36], pch=19, cex=0.6, xlab="SSB (t)", ylab="recruits (1e+05)",
	xlim=c(0, max(sol$ssb)*1.2), ylim=c(0, max(sol$rec)))

# CALCULATE mean recruitment

mean(sol$rec)

# GEOMETRIC mean 

exp(mean(log(sol$rec)))

# RESIDUALS from mean

resid <- sol$rec - exp(mean(log(sol$rec)))

# PLOT residuals

plot(sol$year, resid, pch=19, xlab="", ylab="residuals")
abline(0,0, lty=2)

# NOW in log space

plot(sol$year, log(sol$rec) - mean(log(sol$rec)), pch=19, xlab="", ylab="residuals")
abline(0,0, lty=2)

# AUTOCORRELATION of SSB and recruitment

acf(sol$ssb)

acf(sol$rec)

# LINEAR MODEL of SSB and recruitment

lm(rec~ssb, sol)
