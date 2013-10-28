# Introduction to FLStock
# Copyright 2013 FISHREG. Distributed under the GPL 2 or later
# Maintainer: FISHREG, JRC

# In this tutorial we take a look at the FLStock class.
# The FLStock class is used to store information on the
# dynamics of a fish stock. This includes fishery information
# such as catches and harvest rates, and also biological
# information such as maturity and natural mortality.

#-----------------------------------------------------
# Getting started

# Load FLCore
library(FLCore)

# Load the example FLStock object: ple4, plaice in the North Sea
data(ple4)

# Is it an FLStock
class(ple4)
# Yes

#-----------------------------------------------------
# Why FLStock?
# By holding stock data in a common format we can define functions and methods
# For example, we can calculate SSB of an FLStock using the ssb() method

ssb(ple4)

# Or calculate the mean fishing mortality

fbar(ple4)

# And plot it for a quick look

plot(ple4)

#-----------------------------------------------------
# Inside an FLStock

# help("FLStock-class")

# If you want to inspect the whole object you can try:

ple4

# But you just get pages of text that is difficult to read
# An easier way to look inside is to use summary()

summary(ple4)

# You get a:
#     Description
#     Range
#     and then lots of other things like catch, catch.n etc
# These all have 6 numbers after them
# These are the sizes of the dimensions of the FLQuant that is used to store that information
# (remember an FLQuant has 6 dimensions)
# An FLStock is really just a collection of FLQuant objects
# Each of these FLQuant objects is known as a 'slot'
# An FLStock has 20 slots
# 17 of them are FLQuant objects
# + name (character string)
# + desc (character string)
# + range (numeric vector)

# We can see this by using the getSlots() method

getSlots("FLStock")

# Or str()

str(ple4,2)

#-----------------------------------------------------
# Accessing the slots

# There are at least two ways of accessing a slot
# Using the '@' operator

ple4@catch.n

# using the name of the slot (e.g. catch())

catch.n(ple4)

# Using the second method is recommended

# As these slots are FLQuant objects they can accessed in the usual way:

catch.n(ple4)[,as.character(2000:2008)]

#-----------------------------------------------------
# Useful and common methods

# Calculates sum(catch.n * catch.wt)
computeCatch(ple4)

# Is it the same as the data in the FLStock object?
catch(ple4)

# Yes. Good. But this is sometimes not always the case

# Also:
computeDiscards(ple4)
computeLandings(ple4)
computeStock(ple4)

# Check data consistency
# Does landings + discards = catch?
# Remember you can add FLQuant objects together (if there dimensions are the same)
landings(ple4) + discards(ple4)
catch(ple4)

# We have already seen plot() and summary()
summary(ple4)
plot(ple4)
# We can plot individual slots
plot(catch.n(ple4))

# transform() - used to modify slots
# This is useful because multiple slots can be modified in the same line
# Here we modify only one slot - we set the stock.wt slot to be the same as the landings.wt
ple42 <- transform(ple4, stock.wt = landings.wt)
stock.wt(ple42)
landings.wt(ple42)

# Or do it directly, one slot at a time
ple43 <- ple4
stock.wt(ple43) <- landings.wt(ple43)

# window() - similar to how we used it with an FLQuant
range(ple4)
smallple4 <- window(ple4, start = 2005, end = 2008)

# Check new year range
range(smallple4)
plot(smallple4)

# Subset
temp<-ple4[,as.character(1998:2001)]
summary(temp)

# many FLQuant methods also available at this level
summary(propagate(ple4, 10))
summary(ple4[,'1990'])
summary(trim(ple4, year=1990:1999))
# We can 'grow' the FLStock with expand
bigple4 <- expand(ple4, year=1957:2057)
summary(bigple4)
# Filled up with NAs
stock.n(bigple4)

# A short cut to getting the recruitment (in numbers)
rec(ple4)
stock.n(ple4)[1,]

# Spawning Stock Biomass (SSB)
# SSB = stock.n * exp(-F * F.spwn - M * M.spwn) * stock.wt * mat
ssb(ple4)
# Or by hand, using quantSums() to sum over the first dimension
quantSums(ple4@stock.n * exp(-ple4@harvest *
	ple4@harvest.spwn - ple4@m * ple4@m.spwn) *
	ple4@stock.wt * ple4@mat)

# Mean fishing mortality
fbar(ple4)

# fapex = max F per year
fapex(ple4)

# ssbpurec = SSB per unit recruit
ssbpurec(ple4)

# r = stock reproductive potential
r(ple4)

# survprob = survival probabilities by year or cohort
survprob(ple4)
survprob(ple4, by ='cohort')
plot(survprob(ple4))

# FLStock objects can be coereced into other FLR objects
# For example, FLSR is a class for investigating stock-recruitment relationships
# We can coerce a FLStock object to an FLSR object using as.FLSR()
# (Don't worry about FLSR here, we are just demonstrating that you can move data between FLR classes)
ple4SR<-as.FLSR(ple4)
summary(ple4SR)

# We can convert the FLStock to a data frame
temp<-as.data.frame(ple4)
head(temp)
# And then write it to a *.csv using write.csv()

# Or just some of the slots
head(as.data.frame(ple4@catch.n))

# FEEL LIKE WE NEED SOME MORE ON DATA EXPLORATION HERE - BUBBLE PLOTS ETC

#-----------------------------------------------------
# Reading in data to make an FLStock

# There are several ways of creating an FLStock object
# One method is to create an empty FLStock of the required size
# and then fill up the slots by hand

# We saw in the FLQuant tutorial how to read in data from a *.csv file.
# Here we look at a similar process for reading in data to create an FLStock

# As before we read some data into an FLQuant (here we have stock numbers)

sn <- read.csv("stock_n.csv", row.names = 1)
sn <- as(sn,'matrix')
sn_fq <- FLQuant(sn, dimnames = list(age = 1:10, year = 1957:2008), quant='age')

# We can make an FLStock of the correct dimensions using the FLStock() constructor
# and passing in the FLQuant and other slots (where available)

stk <- FLStock(stock.n = sn_fq, name = "My stock", desc = "A stock I made")
summary(stk)

# We have created an FLStock with the same dimensions as the FLQuant we passed in
# We have also filled up the stock.n slot
stock.n(stk)

# But the other slots are currently empty
stock.wt(stk)

# So the data for these slots needs to be read in and set



#-----------------------------------------------------
# Why are we doing all this?
# Why bother with FLStock and FLQuant objects at all
# Why don't we just use the exisiting tools in R
# Here we give an example of how FLR can be used to perform
# a complete analysis of a stock
# For this we will need some more packages
library(Core)
library(FLash) # ?
library(FLAssess)
library(FLXSA)
library(FLBRP)

# First we read in the stock data again
data(ple4)
# And also some tuning indices
data(ple4.indices)
# Empty the harvest and stock.n slots so we start from having
# no estimates of abundance or fishing mortality
harvest(ple4)[] <- NA
stock.n(ple4)[] <- NA
plot(ple4) # Just checking we have no abudance or F data

# Run an XSA asessment with default settings
ple4_xsa <- FLXSA(ple4, ple4.indices)
# Update the stock object with estimated abundances and F
ple4 <- ple4 + ple4_xsa
plot(ple4)

# We can now fit a stock-recruitment relationship
ple4_sr <- as.FLSR(ple4, model = "bevholt")
ple4_sr <- fmle(ple4_sr)
plot(ple4_sr)

# And calculate reference points
ple4_brp <- FLBRP(ple4, ple4_sr)
ple4_brp <- brp(ple4_brp)
refpts(ple4_brp)
# plot(ple4_brp)

# Finally we run a short term projection
ple4_stf <- stf(ple4, nyears = 3)
# Future F is the mean of the last 3 years
f_future <- mean(fbar(ple4)[,as.character(2004:2008)])
# Set up some assumptions about the future
ctrl_target <- data.frame(year = 2009:2011,
			  quantity = "f",
			  val = c(f_future))
# Set the control object - year, quantity and value for the moment
ctrl_f <- fwdControl(ctrl_target)
# And run the projection
ple4_fwd <- fwd(ple4_stf, ctrl = ctrl_f, sr = ple4_sr)
plot(ple4_fwd)

# All of this done using FLR classes and methods
# And most FLR classes are created using an FLStock, which is made up of FLQuant slots
# So if you get comfortable with FLStock and FLQuant, you can use FLR

#-----------------------------------------------------
# End










