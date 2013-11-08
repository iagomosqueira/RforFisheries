#-----------------------------------------------
# Length slicing tutorial 
# Copyright 2013 FLR Core Development Team
# Distributed under the GPL 2 or later
#-----------------------------------------------

library(FLa4a)
# Should load all the other packages too

# Set your own working directory!
# The next line is my working directory
setwd("~/Work/flr/RforFisheries/201311-R@GFCM/Day05/data")

# We have some *.csv files of length based data
# Catches and indices
# We want to read all these and make FLQuant objects from them

# Read them in
cth_n     <- read.csv("cth.n.csv",row.names=1)
cth_wt    <- read.csv("cth.wt.csv",row.names=1)
stk_wt    <- read.csv("stk.wt.csv",row.names=1)  
idx_n     <- read.csv("idx.n.csv",row.names=1)

# Turn them all into matrices
cth_n     <- as.matrix(cth_n)
cth_wt    <- as.matrix(cth_wt)   
stk_wt    <- as.matrix(stk_wt)   
idx_n     <- as.matrix(idx_n)   

# And make FLQuant objects
# The FLStock FLQuant objects, length based
cth_n_l <- FLQuant(cth_n, dimnames=list(length=1:59, year = 1986:2011))
cth_wt_l <- FLQuant(cth_wt, dimnames=list(length=1:59, year = 1986:2011))
stk_wt_l <- FLQuant(stk_wt, dimnames=list(length=1:59, year = 1986:2011))

# The FLIndex FLQuant objects, length based
idx_n_l <- FLQuant(idx_n, dimnames=list(length=1:59, year = 1986:2011))

#-----------------------------------------------
# Now slice them
#-----------------------------------------------
# We are going to convert the length based FLQuant
# objects to age based using the l2a() method

# Create formulae for the von Bertalanffy growth functions
# len = f(linf, l, t0, t)
vb_growth <- ~linf*(1-exp(-k*(t-t0)))
# t = f(linf, l, t0, len)
vb_inv_growth <- ~t0-1/k*log(1-len/linf)
# where t is the age

# Set the von Bertalanffy parameters
# Ignore what an FLPar is for the moment
vb_params <- FLPar(linf=58.5, k=0.086, t0=0.001)

# Create an 'a4aGr' object
# This contains the growth model, the inverse growth model
# and the parameters
vbObj <- a4aGr(grMod = vb_growth,
               grInvMod = vb_inv_growth,
               params = vb_params)

# How does an a4aGr object work?
# We can use this calculate t (or age) by giving it a length
t <- predict(vbObj, len=20)
# We can also use it to calculate length, given t (age) 
len <- predict(vbObj, t=t)

# This also works with vectors of lengths
predict(vbObj, len=1:10)
# And vectors of ages
predict(vbObj, t=1:10)

# Note that the ages and lengths that are returned are not integers
# However, when we make the FLQuant that is age based
# We know that data has to put in integer ages
# e.g. data can only be put into age=1, age=2, etc.
# not age=4.86575
# The assumption we make is to use the lower age boundary
# e.g. an individual of age 4.86575 gets put into the age=4 category

floor(4.86575)

# There is a convenient wrapper function, l2a() that can process
# a whole FLQuant, given an a4aGr object
# We must decide how to aggregate the length based data
# For example, numbers at length 10 cm fall into the age 2 category
# So do numbers at length 11 cm.
# So these should be summed.

# Here we slice the numbers at lengths
# So we want to sum up the abundances 
# For that we use the stat argument and set it to 'sum'
cth_n     <- l2a(cth_n_l, vbObj, stat="sum")
# what happened?
dimnames(cth_n_l)
dimnames(cth_n)
# Note that the ages are not contiguous
# This becomes important later on

# Do we have everyone?
quantSums(cth_n_l)
quantSums(cth_n)
# Good

# We don't want to sum the weights at length
# as it doesn't make any sense.
# Instead we take the mean
# e.g. the weights of the lengths that fall into age 2
# (about 9 to 13 cm)  should be averaged to give the average
# weight at age 2
# We set stat to "mean"
cth_wt    <- l2a(cth_wt_l, vbObj, stat="mean")   
stk_wt    <- l2a(stk_wt_l, vbObj, stat="mean")   

idx_n     <- l2a(idx_n_l, vbObj, stat="sum")   

#-----------------------------------------------
# Making the age based FLStock
#-----------------------------------------------
# We can make a new FLStock from the three FLQuant objects

stk <- FLStock(stock.wt = stk_wt,
               catch.n = cth_n,
               catch.wt = cth_wt,
               name = "Red fish",
               desc = "Made from length based data")

summary(stk)
# Note that the quant is age

# We have only filled up 3 of the 17 slots
# We are going to estimate stock.n and harvest later on
# Let's try fill up some of the others by making some assumptions

# Assumption 1: There are no discards
# So we can set discards.n to 0 and the discards.wt to 0
discards.n(stk)[] <- 0
discards.wt(stk)[] <- 0
# If there are no discards then the catch must be the same
# as the landings
landings.n(stk) <- catch.n(stk)
landings.wt(stk) <- catch.wt(stk)

# We can calculate the 'total' FLQuant slots:
# catch, discards, stock and landings
catch(stk) <- computeCatch(stk)
landings(stk) <- computeLandings(stk)
stock(stk) <- computeStock(stk)
discards(stk) <- computeDiscards(stk)

# Now we have 11 slots filled

# Assumption 2: All the harvesting and natural mortality occurs
# at the start of the year
harvest.spwn(stk)[] <- 0
m.spwn(stk)[] <- 0

# Assumption 3: Natural mortality is constant for all years and ages
# and it equals 0.05
m(stk)[] <- 0.05

# Finally we need to do something about maturity
# Here we have no information
# But we have an estimate of Lmat is 38cm
Lmat <- 38
# What age does this happen at?

# Assumption 4: Anything longer or equal to 38 cm is mature
# and anything shorter than 38 cm is immature
# We make a new length based FLQuant of the same
# dimensions as the others
mat_l <- FLQuant(0, dimnames=list(length=1:59, year = 1986:2011))
# What lengths do we have?
dimnames(mat_l)$length
# What lengths are greater than Lmat
# We can use as.numeric()
as.numeric(dimnames(mat_l)$length) >= Lmat
# We can fill up our FLQuant using this
mat_l[as.numeric(dimnames(mat_l)$length) >= Lmat,] <- 1
mat_l
# This is a very crude maturity ogive!
# We need to slice this like the others
mat    <- l2a(mat_l, vbObj, stat="mean")   
# Is it OK?
mat
mat(stk) <- mat

# Almost there...
# But we have small problem
# We know that the age ranges in our FLQuant objects are not contiguous
# e.g.
dimnames(catch.n(stk))
# This is not good and we need to fix it.
# This next stage may look a little strange but hold on
# First we make an empty FLQuant of the right size, which DOES have
# contiguous ages
dummy <- FLQuant(dimnames=list(age=0:55, year=1986:2011))
# We make an new, empty FLStock of the right dimensions
# We just set the 'm' slot because we have to set something
# It doesn't have to be m.
new_stk <- FLStock(m=dummy)
# We store the dimnames of the NON-contiguous stock
dms<-dimnames(m(stk))
# We can subset a whole FLStock object, in the same way
# we subset an FLQuant or a vector using []
# Here we subset the contiguous stock using the dimensions
# of the non-contiguous stock
# and copy the non-contiguous stock in
new_stk[dms$age, dms$year] <- stk
# Did it work?
catch.n(stk)
catch.n(new_stk)
# Yes...
# Write over the old stk object
stk <- new_stk

# Problem almost solved
# But we now have holes in the slots
# We can deal with this by setting the plus group
# We would have to do this anyway because at the moment we are going
# from ages 1 to 55
# This is not a good idea as the information on the later ages will
# be sparse
# So we want to set the plus group to something more sensible
stk <- setPlusGroup(stk, 17, na.rm=TRUE)
catch.n(stk)

# And a bit of house keeping
# Set the units of the harvest even though it is empty
units(harvest(stk)) <- "f"

# Have a look at the range
range(stk)

# And plot what we have
plot(stk)

#-----------------------------------------------
# Now for the indices
#-----------------------------------------------

# We have the same problem with non-contiguous ages
idx_n

# We can solve this before we make the FLIndex object
# We don't want all these ages in the FLIndex
# because some ages are not well selected by the survey
# gears.
# We just trim off the ages we don't want

# Set a maximum age
index_max_age <- 10
index_min_age <- 5
# Trim it to the maximum age
new_idx_n <- trim(idx_n, age = index_min_age:index_max_age)
new_idx_n

# Now make the FLIndex
# Giving it a name is very important (else FLXSA fails)
idx <- FLIndex(index = new_idx_n,
               name = "my_index")

# We also need to set the timing of the indices
range(idx)[c("startf","endf")] <- 0.5
range(idx)["plusgroup"] <- NA



plot(idx)

#-----------------------------------------------
# Now for the assessment
#-----------------------------------------------

library(FLXSA)

# Try the default XSA fit
xsa <- FLXSA(stk, FLIndices(idx), FLXSA.control())

# And the default a4a fit
a4afit <- a4a(stock = stk, indices = FLIndices(idx))

# Compare
plot(FLStocks(stk + a4afit, stk + xsa), col = c("blue","black"))


