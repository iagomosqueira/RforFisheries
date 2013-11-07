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

##################################
# here is a fairly complicated plot of the data in the hake stock object.  Please don't worry about understanding the code.  If you want to understand what it is doing you can always ask - otherwise you can reuse it or forget it or whatever.
##################################

# choose what slots to display
slots <- c("catch.n", "catch.wt", "mat", "m")

# choose what you want them labelled as
snames <- c("Catch Numbers", "Catch Weight", "Maturity", "Natural Mortality")

# create the plot  - dont worry about the details
xyplot(data ~ year | factor(slot, levels = slots, labels = snames), group = age, 
       data = hakeGSA7, subset = slot %in% slots, drop.unused.levels = TRUE,
       panel = function(x, y, ...) {
         panel.xyplot(x, y, type = c("g", "p", "l"), ...)
         if (current.column() == 2) 
           panel.xyplot(x, y, type = "smooth", lty = 2, col = grey(0.4), ...)
       }, scales = list(relation = "free"), pch = 16, cex = 0.7,
       layout = c(4,1), auto.key = list(columns = 4, lines = 1, points = FALSE, title = "Ages"))



# But we are not here for that!  Maybe another lattice plot later ;)




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

# and the residuals
# residuals about what the model predicts the catch should be
xyplot(data ~ year | paste("age", age), data = catch.lres(simplefit), type = c("g","p","smooth"), 
     lty = 2, col = 1, ylab = "standardised residual", as.table = TRUE, main = "log (Catch) Residuals")

# residuals about what the model predicts the survey indices should be
xyplot(data ~ year | paste("age", age), data = index.lres(simplefit)[[1]], type = c("g","p","smooth"), 
     lty = 2, col = 1, ylab = "standardised residual", as.table = TRUE, main = "log (Index) Residuals")



# if we want we can look at the raw residuals
xyplot(data ~ year | paste("age", age), data = catch.lres(simplefit, type = "unscaled"), type = c("g","p","smooth"), 
     lty = 2, col = 1, ylab = "standardised residual", as.table = TRUE, main = "log (Catch) Residuals")



# ***********************************************
# ***********************************************
#
#   Exercise 1
#
# ***********************************************
# ***********************************************

#  part 1
# --------

# load in the Hake data: both the stock and the suvey


# define the Fishing mortality and survey catchability models to be intercept only models



# fit the model



# look at the summary of the model




#  part 2
# --------

# try fitting some other fishing mortality models, using year and age:  these are intercept and slope models
#
# save each fit in a different object (e.g call the myfit1, myfit2, etc.)
#
# look at the summaries of each one -  
#
#   Is the introduction of a linear effect of age significant?
#
#   Is the introduction of a linear effect of year significant?
#





# ***********************************************
# ***********************************************
#
#   End of exercise 1
#
# ***********************************************
# ***********************************************


# So where were we...
simplefit


# But we can do better! 
# We should probably allow the exploitation pattern to vary with time.
# Lets try including age
# ----------------------------------

# choose a model for log Fishing mortality
fmodel <- ~ age

# choose a model for survey catchablity
qmodel <- list( ~ 1 )

# fit the model
fit2 <- a4aFit(fmodel, qmodel, stock = hakeGSA7,  indices = hakeGSA7.idx)
AIC(simplefit, fit2)



# look at residuals again
xyplot(data ~ year | paste("age", age), data = catch.lres(fit2), type = c("g","p","smooth"), 
     lty = 2, col = 1, ylab = "standardised residual", as.table = TRUE, main = "log (Catch) Residuals")

xyplot(data ~ year | paste("age", age), data = index.lres(fit2), type = c("g","p","smooth"), 
     lty = 2, col = 1, ylab = "standardised residual", as.table = TRUE, main = "log (Index) Residuals")





# ###############################################
#
# Here are some functions to make diagnostic plots more easily
#
# ###############################################

# residuals
plot(fit2, hakeGSA7, what = "Res")

# Fishing mortality
plot(fit2, hakeGSA7, what = "F", Ftext = TRUE)

# survey catchability
plot(fit2, hakeGSA7, what = "Q")

# Stock Numbers
plot(fit2, hakeGSA7, what = "N")

# all at once!!
# plot(fit2, hakeGSA7)




# ###############################################
#
# One thing we could do is add in age into the survey model,
# But i am goint to keep working on the F model for now
# Lets try adding year
#
# ###############################################


# fit the model including year in there
fit3 <- a4aFit(~ age + year, list( ~ 1 ), stock = hakeGSA7,  indices = hakeGSA7.idx)
AIC(simplefit, fit2, fit3)

# look at residuals again
xyplot(data ~ year | paste("age", age), data = catch.lres(fit3), type = c("g","p","smooth"), 
     lty = 2, col = 1, ylab = "standardised residual", as.table = TRUE, main = "log (Catch) Residuals")

# residuals look better
xyplot(data ~ age, data = harvest(fit3), groups = year, type = "l", auto.key = list(columns = 4))


# ** We can do better !!**


# ###############################################
#
# Lets try modelling F at age using a smoother
#
# ###############################################

# fit the model
fit4 <- a4aFit(~ s(age, k = 4) + year, list( ~ 1 ), stock = hakeGSA7,  indices = hakeGSA7.idx)


# compare the fit to previous ones
AIC(simplefit, fit2, fit3, fit4)

# check out the F predicitons
xyplot(data ~ age, data = harvest(fit4), groups = year, type = "l", auto.key = list(columns = 4))



# ***********************************************
# ***********************************************
#
#   Exercise 2
#
# ***********************************************
# ***********************************************

#  part 1
# --------

# define a Fishing mortality that has a smooth expoitation pattern with age
# and also for year. Note that there are only 14 years of data, so you cant go more that k = 14 for year


# fit the model



# look at the summary of the model and compare to fit4



# try out some of the plotting options
#
# e.g. plot(fit4, hakeGSA7, what = "F", Ftext = TRUE)
#
# remember to substitute fit4, for your model!
#




#  part 2
# --------

# try fitting some other fishing mortality models, varying the degrees of freedom on year and age
#
# save each fit in a different object (e.g call the myfit1, myfit2, etc.)
#
# look at the summaries of each one -  
#
#   What is the best values of k for the F model you can find?
#





# ***********************************************
# ***********************************************
#
#   End of exercise 2
#
# ***********************************************
# ***********************************************




# ###############################################
#
# Lets try to find a good set of k values for the fishing mortality model
# and the survey catchability model
#
# ###############################################



# lets try some other models - we will increase the degrees of freedom (or the bendyness) of the smoothers in a stepwise procedure
fit5 <- a4aFit(~ s(age, k = 4) + year, list( ~ age ), stock = hakeGSA7,  indices = hakeGSA7.idx)
fit6 <- a4aFit(~ s(age, k = 4) + year, list( ~ s(age, k=4) ), stock = hakeGSA7,  indices = hakeGSA7.idx)
fit7 <- a4aFit(~ s(age, k = 4) + s(year, k = 6), list( ~ s(age, k=4) ), stock = hakeGSA7,  indices = hakeGSA7.idx)

# compare these to previous fits
AIC(simplefit, fit2, fit3, fit4, fit5, fit6, fit7)
# and we can select the best one of these
# NOTE that this is NOT an assessment - just a demonstration of the model!!
bestfit <- fit7



# ###############################################
#
# So you might think that if we keep adding stuff the fit will just get better and better...
#
# ###############################################


# lets try andding more bendyness and see what happens
fit8 <- a4aFit(~ s(age, k = 5) + s(year, k = 6), list( ~ s(age, k = 4) ), stock = hakeGSA7,  indices = hakeGSA7.idx)
fit9 <- a4aFit(~ s(age, k = 4) + s(year, k = 7), list( ~ s(age, k = 4) ), stock = hakeGSA7,  indices = hakeGSA7.idx)
fit10 <- a4aFit(~ s(age, k = 4) + s(year, k = 6), list( ~ s(age, k = 5) ), stock = hakeGSA7,  indices = hakeGSA7.idx)
AIC(bestfit, fit8, fit9, fit10)

# And the best fit is!!!
bestfit

# and the F pattern is a bit more beleivable
xyplot(data ~ age, data = harvest(fit4), groups = year, type = "l", auto.key = list(columns = 4))
plot(hakeGSA7 + bestfit)

# Lets have a look at the residuals
#----------------------------------

# residuals about what the model predicts the catch should be
xyplot(data ~ year | paste("age", age), data = catch.lres(bestfit), type = c("g","p","smooth"), 
     lty = 2, col = 1, ylab = "standardised residual", as.table = TRUE, main = "log (Catch) Residuals")

# residuals about what the model predicts the survey indices should be
xyplot(data ~ year | paste("age", age), data = index.lres(bestfit)[[1]], type = c("g","p","smooth"), 
     lty = 2, col = 1, ylab = "standardised residual", as.table = TRUE, main = "log (Index) Residuals")




# ###############################################
#
# What happens if we go mad and have a seperate parameter for each age
#
# ###############################################

fitF <- a4aFit(~ factor(age), list( ~ 1 ), stock = hakeGSA7,  indices = hakeGSA7.idx)
AIC(bestfit, fitF)


# Whats going on!  The F at age estimates are a bit weird...
# ----------------------------------
#
#   It is likey that the model is too flexible with respect to age - 
#   this is why in other models such as XSA you have to set a rule for calculating the F at the older ages.
#





# ###############################################
#
# Some examples of an improved user interface NOT YET IMPLEMENTED
#
# ###############################################


# we plan to improve the interface so that models can be specified more intuitively

# an example of this is, 
# Sayyou want to model a survey in which there is some technical creep: e.g.
qmodel <- ~ s(age, k = 4) + year

# you would specify
qmodel <- ~ trawl(trend = "linear")






# ###############################################
#
# Some examples of extensions
#
# ###############################################


fmodel <- ~ s(age, k = 4) + te(age, year, k = c(3, 6))
qmodel <- list( ~ s(age, k = 4) )

fit12 <- a4aFit(fmodel, qmodel, stock = hakeGSA7,  indices = hakeGSA7.idx)
AIC(bestfit, fit12)

# And the best fit is!!!
fit12

# and the F pattern now varies with age
plot(fit12, hakeGSA7, what = "F", Ftext = TRUE)

# what does Fbar, recruitment and SSB look like
plot(hakeGSA7 + fit12)



#Lets have a look at the residuals
#----------------------------------

# residuals about what the model predicts the catch should be
xyplot(data ~ year | paste("age", age), data = catch.lres(fit12), type = c("g","p","smooth"), 
     lty = 2, col = 1, ylab = "standardised residual", as.table = TRUE, main = "log (Catch) Residuals")

# residuals about what the model predicts the survey indices should be
xyplot(data ~ year | paste("age", age), data = index.lres(fit12)[[1]], type = c("g","p","smooth"), 
     lty = 2, col = 1, ylab = "standardised residual", as.table = TRUE, main = "log (Index) Residuals")






# ###############################################
#
# Here are some more advances trellis plots
#
# ###############################################

# lets look at the cohort plots from the catches

xyplot(data ~ year | factor(year - age), data = log(catch.n(hakeGSA7)), 
       type = c("g","l","p"), as.table = TRUE, 
       group = (year - age) %in% c(2011 - 2:3), 
       lwd = c(1,3), col = 1, pch = 16, cex = 0.5, main = "Cohorts in Catches")

# lets look at the cohort plots from the indices

xyplot(data ~ year | factor(year - age), data = log(index(hakeGSA7.idx[[1]])), 
       type = c("g","l","p"), as.table = TRUE, 
       group = (year - age) %in% c(2011 - 2:3), 
       lwd = c(1,3), col = 1, pch = 16, cex = 0.5, main = "Cohorts in Indices")






# ###############################################
#
# Here are some more very advanced trellis plots
#
# ###############################################

# NB requires you to download latticeExtra from CRAN 

library(LatticeExtra)


# lets look at the cohort plots from the catches

p <- xyplot(data ~ year, data = log(catch.n(hakeGSA7)), 
       type = c("g","l"), as.table = TRUE, col = 1,
       group = factor(year - age), main = "Cohorts in Catches")

p <- p + as.layer(xyplot(data ~ year, data = log(catch.n(hakeGSA7)), 
       type = "l", as.table = TRUE, lwd = c(1,1,3,3,1,1,1), col = 1,
       group = age, lty = 2))

print(p)


# lets look at the cohort plots from the indices

p2 <- xyplot(data ~ year, data = log(index(hakeGSA7.idx[[1]])), 
       type = c("g","l"), as.table = TRUE, col = 1,
       group = factor(year - age), main = "Cohorts in Indices")

p2 <- p2 + as.layer(xyplot(data ~ year, data = log(index(hakeGSA7.idx[[1]])), 
       type = "l", as.table = TRUE, lwd = c(1,1,3,3,1,1,1), col = 1,
       group = age, lty = 2))

print(p2)











