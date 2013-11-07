###############################################
# Statistical catch at age models with FLa4a
# =========================
#
# GFCM HQ, 7th November, 2013
# -------------------------
################################################

# Install FLa4a

# you will need do download
install.packages("FLa4a", repos = "http://flr-project.org/Rdevel")

# and you will need to install these extra packages (if you do not have them already)
install.packages(c("triangle", "copula", "ADGofTest", "gsl", "latticeExtra", "mvtnorm", "np", "pspline", "RColorBrewer", "stabledist")) 

# you only need to install these packages once.  
#######

################################################


# load the libary and some data
library(FLa4a)
data(ple4)
data(ple4.indices)


# ################################
#
# Lets fit a very simple model :)
#
# ################################

# Always follow these steps:
# - choose a model for log Fishing mortality
# - choose a model for log survey catchability
# - fit the model
# - inspect the fit


# YOu need to be a little familiar with formulas:
# check out the details section in:
#?formula

# and for the a4a model have a look at
#?a4a


# okay! now lets fit a stock assessment:

# choose a model for log Fishing mortality
fmodel <- ~ 1

# choose a model for survey catchablity - this has to be a list of formulas (Models) - one for each survey

qmodel <- list( ~ 1 )

# fit the model
simplefit <- a4a(fmodel, qmodel, stock = ple4,  indices = ple4.indices[1], fit = "assessment")

# look at a quick summary
summary(simplefit)


# lets look at the estimates of recruitment, Fbar, and SSB are

# A good way is to add the predictions to the origional stock object this fill in stock.n and harvest
ple4.simple <- ple4 + simplefit

# plot the fitted stock object
plot(ple4.simple)

# we can add in confidence intervals
# in a4a we do this using simulation approach
# Which works using a stock object with iters
ple4.sim <- propagate(ple4, iter = 100)

# and we add the stock assessment to this new stock object
ple4.sim.fit <- ple4.sim + simplefit


# lets do a quick comparison with default XSA
library(FLXSA)
ple4.xsa <- FLXSA(ple4, ple4.indices[1], FLXSA.control())
ple4.xsa.fit <- ple4 + ple4.xsa

# and plot using FLStocks
plot(FLStocks(ple4.sim.fit, ple4.xsa.fit), col = c("black", "red"))


#  Excercise

# 1. try some different formulas for F
# like:

#  a) fmodel <- ~ year

#  b) fmodel <- ~ s(year)

#  c) fmodel <- ~ s(year) + age

#  d) fmodel <- ~ s(year) + s(age)

# by changing the code below:

# set up the model
fmodel <- ~ 1
qmodel <- list( ~ 1 )

# fit the model
myfit <- a4a(fmodel, qmodel, stock = ple4,  indices = ple4.indices[1])

# plot the fit
plot(ple4 + myfit)



