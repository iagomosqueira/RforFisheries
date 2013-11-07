# Copyright 2013 JRC FISHREG. Distributed under the GPL 2 or later
# Maintainer: JRC FISHREG
# Ispra, 18th - 22nd March, 2013

#####################################################################
# VPA and XSA models with FLAssess and FLXSA
#####################################################################
#====================================================================
# VPA
#====================================================================

install.packages("FLAssess", repos = "http://flr-project.org/Rdevel")

install.packages("FLash", repos = "http://flr-project.org/Rdevel")


library(FLAssess)

data(ple4)


# just to be clean we will remove the values we would not know
harvest(ple4)[] <- NA
stock.n(ple4)[] <- NA

# lets check it is empty
harvest(ple4)

#--------------------------------------------------------------------
# before we run a VPA we need to set up
# set final year and final age F values
#--------------------------------------------------------------------

# set F at the oldest age to 1
harvest(ple4)[as.character(range(ple4)["max"]), ] <- 1
harvest(ple4)

# set F at the final year to 1
harvest(ple4)[, as.character(range(ple4)["maxyear"])] <- 1
harvest(ple4)

#
m(ple4)

# In FLAssess we have the function VPA()
# the help file is found usinf
?VPA

#--------------------------------------------------------------------
# run a VPA
#--------------------------------------------------------------------
ple4.vpa <- VPA(ple4)

# what is ple4.vpa
class(ple4.vpa)
# it is an FLVPA class

# in FLR, a stock assessment method returns a something that
# is a stock assessment object.  So VPA returns an FLVPA object
# and XSA returns an FLXSA object.
# The common thing is that to get the results out of a stock assessment
# you add the assessment to the stock:
#  fitted.stock = stock + assessment
#

ple4.fitted <- ple4 + ple4.vpa
plot(ple4.fitted)

# we can also look at the stock.n and harvest slots in more detail
stock.n(ple4.fitted)

harvest(ple4.fitted)

# and again we can use ggplot to visualise things
harvest.df <- as.data.frame(harvest(ple4.fitted))

ggplot(harvest.df, aes(x = year, y = data)) + geom_line() + facet_wrap(~age)



# one thing to be wary of here is that we have fixed the values of F
# in the final year and oldest age to 1

# it is probably a good idea to test the sensitivity of these assumptions
# and to do this it could be a good idea to write a few lines of code that do the job
# and repeat them.
# When you have code that is repeated often it is a good idea to
# combine it into one job or function


myfunc <- function(x) {
  y <- x ^ 2
  return(y)
}

# pass a number to the function
myfunc(1)

myfunc(x = 2)

value <- 2
myfunc(value)



myfunc <- function(x, power) {
  y <- x ^ power
  return(y)
}


# pass in numbers - getting them in the right order!
myfunc(2, 3)

# note this is not the same
myfunc(3, 2)

# but this is
myfunc(power = 3, x = 2)

myfunc(x = 2)

# so to summarise,
# functions are a very useful way to put a task into
# the one place... a bit like a macro in Excel
# But in R we can pass in different arguements.
# functions are very flexible tools.



#--------------------------------------------------------------------
# sensitivity to final values
#--------------------------------------------------------------------

# lets write a function that takes in a stock and
# a value for the final year F

runSensitivity <- function(stock, val) 
{
  harvest(stock)[as.character(range(stock)["max"]), ] <- val
  harvest(stock)[, as.character(range(stock)["maxyear"])] <- val
  fitted.stock <- stock + VPA(stock)
  
  return(fitted.stock)
}

# lets test it
stk1 <- runSensitivity(ple4, 1)
plot(stk1)

stk2 <- runSensitivity(ple4, 1.5)
plot(stk2)

# A FLStocks object is a collection of FLStocks
stocks <- FLStocks(stk1, stk2)

# and we can plot it
stocks.zoom <- window(stocks, start = 2000)

plot(stocks.zoom)

# so it is a useful way to combine different stocks and even stock assessmnets


# but can we automate this process

stock.list <- list()

finals <- seq(0.5, 1.5, by = 0.1)
for (i in 1:length(finals)) {
  stock.list[[i]] <- runSensitivity(ple4, finals[i])
}

length(stock.list)

str(stock.list, 2)


stocks <- FLStocks(stock.list)

plot(window(stocks, start = 2000))

# Excercise,

# 1. write a function to do a VPA assessment which has a different value for final year F, as it does to Final age F.

# 2. run a sensitivity when final year F is 1 and final age F goes from 0.5 to 1.5 in steps of 0.1

# 3. plot the results as an FLStocks for the years 2001 to 2008





#====================================================================
# XSA
#====================================================================

library(FLXSA)
data(ple4.indices)


# FLIndices object:

plot(ple4.indices)

plot(ple4.indices[["SNS"]], type="ts")


#--------------------------------------------------------------------
# Select tuning fleets
#--------------------------------------------------------------------

ple4.tun.sel <- FLIndices(trim(ple4.indices[[1]],age=2:8), ple4.indices[[2]], trim(ple4.indices[[3]], year=1997:2003))
names(ple4.tun.sel) <- names(ple4.indices)

#--------------------------------------------------------------------
# Set plus group
#--------------------------------------------------------------------
# calculate the catch, landings and discards numbers in the plusgroup, as well as calculating the weights in the plusgroup, based on a weighted average of the ages in the plusgroup

ple4.sel <- setPlusGroup(ple4, plusgroup=10)

#--------------------------------------------------------------------
# Control file for XSA
#--------------------------------------------------------------------
# inspect, there are a default set of options, for full explanation of meaning read thoroghly the user manual of XSA and the help file
FLXSA.control()

# set
xsa.control <- FLXSA.control(tol = 1e-09, maxit = 30, min.nse = 0.3, fse = 2.0, rage = -1, qage = 6, shk.n = TRUE, shk.f = TRUE, shk.yrs = 5, shk.ages= 2, window = 100, tsrange = 99, tspower = 0)

#--------------------------------------------------------------------
# run
#--------------------------------------------------------------------
FLXSA method takes three arguments: FLStock object (catch-at-age matrix), FLIndices (tuning indices), and an FLXSA.control object (parameter settings for XSA)

xsa.results <- FLXSA(ple4.sel, ple4.tun.sel, xsa.control)


#--------------------------------------------------------------------
# now have a look at the XSA diagnostics
#--------------------------------------------------------------------
diagnostics(xsa.results)

# catchability Residuals by survey need to be extracted from the xsa.results 
# accessor is index.res, but there are no names so need to reassign them

names(index.res(xsa.results)) <- lapply(ple4.tun.sel,'name')
bubbles(age~year|qname, data=mcf(index.res(xsa.results)))

#--------------------------------------------------------------------
# incorporate results of XSA in FLQuant of ple4
#--------------------------------------------------------------------
ple4.sel <- ple4.sel + xsa.results
plot(ple4.sel)

#--------------------------------------------------------------------
# run a retrospective analysis
#--------------------------------------------------------------------
# what does it mean?
retro.years <- 2004:2008
ple4.retro <- tapply(retro.years, 1:length(retro.years), function(x){
  window(ple4,end=x)+FLXSA(window(ple4,end=x),ple4.indices)
})

# coerce into FLStocks object
ple4.retro <- FLStocks(ple4.retro)
# full retrospective summary plot
plot(ple4.retro)

#--------------------------------------------------------------------
#====================================================================
# Exercise on XSA
#====================================================================


#Run your own XSA on ple4 assess the levels in SSB and F 
