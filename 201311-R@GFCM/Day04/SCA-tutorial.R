###############################################
# Statistical catch at age models with FLa4a
# =========================
#
# Ispra, 18th - 22nd March, 2013
# -------------------------
################################################

# Install FLa4a

# only run if you do not have these packages installed on your computer

#install.packages("RcppArmadillo")
#install.packages("FLa4a", repos="http://flr-project.org/Rdevel")


# load the libary and some data
library(FLa4a)
data(hakeGSA7)
data(hakeGSA7.idx)



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
?formula

# and for the a4a model have a look at
?a4aFit


# okay! now lets fit a stock assessment:


# lets remind ourselves of the data we are going to use
summary(hakeGSA7)
summary(hakeGSA7.idx)

# choose a model for log Fishing mortality
fmodel <- ~ 1

# choose a model for survey catchablity - this has to be a list of formulas (Models) - one for each survey

qmodel <- list( ~ 1 )

# fit the model
simplefit <- a4aFit(fmodel, qmodel, stock = hakeGSA7,  indices = hakeGSA7.idx)

# look at a quick summary
simplefit


# lets look at the estimates of recruitment, Fbar, and SSB are

# A good way is to add the predictions to the origional stock object this fill in stock.n and harvest
simpleHake <- hakeGSA7 + simplefit

# plot the fitted stock object
plot(simpleHake)








