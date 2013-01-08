# T0X_linear_models.R
# Day02/T0X_linear_models.R

# Copyright 2011-13 JRC FishReg. Distributed under the GPL 2 or later
# Maintainer: FishReg, JRC

# Introduction to R for Fisheries Science

# linear models

# lets get some data

# http://data.gov.uk//dataset/annual-levels-of-particles-and-ozone-1987-to-2010

dat <- read.table("http://data.defra.gov.uk/env/aqfg02a-apart-201202.csv", 
                  sep = ",", skip = 17, header = TRUE)


# tidy data
head(dat)
names(dat)
names(dat) <- c("year", "roadsidePM", "urbanPM", "ruralO", "urbanO")
head(dat)


# plot data (we only consider urban background ozone)
plot(dat$year, dat$urbanO)


# try some linear models:

# intercept only model
mod0 <- lm(urbanO ~ 1, data = dat)

# model with intercept and linear term in year
mod1 <- lm(urbanO ~ year, data = dat)

# a quick F test
anova(mod0, mod1, test = "F")
# linear effect of year is highly significant

# some diagnostics
plot(mod1)

# parameter estimates and confidence intervals
coef(mod1)
confint(mod1)


# how about plotting the fit?

# predict the model over a range of years - we will project up to 2020
newdata <- data.frame(year = seq(1987, 2020, length = 100))
pred <- predict(mod1, newdata, se.fit = TRUE)

# add predictions with approximate 95% confidence interval to prediction data.frame
newdata$fit <- pred $ fit
newdata$ciu <- pred $ fit + 2*pred $ se
newdata$cil <- pred $ fit - 2*pred $ se

# we plot the data, the fit and the upper and lower confidence intervals
plot(dat$year, dat$urbanO, xlim = c(1987, 2020), ylim = c(35, 72), pch = 19)
lines(newdata$year, newdata$fit, col = "blue", lwd = 2)
lines(newdata$year, newdata$ciu, col = "blue", lwd = 2, lty = 2)
lines(newdata$year, newdata$cil, col = "blue", lwd = 2, lty = 2)

# A candidate for a function perhaps??


plotPredictions <- function(mod, data, col = "blue", lwd = 2)
{
  # predict 
  pred <- predict(mod, data, se.fit = TRUE)

  # add predictions with approximate 95% confidence interval
  data$fit <- pred$fit
  data$ciu <- pred$fit + 2*pred$se
  data$cil <- pred$fit - 2*pred$se

  # draw lines
  lines(data$year, data$fit, col = col, lwd = lwd)
  lines(data$year, data$ciu, lty = 2, col = col, lwd = lwd)
  lines(data$year, data$cil, lty = 2, col = col, lwd = lwd)
}

# repeat the last plot using our new function!

# plot data
plot(dat$year, dat$urbanO, xlim = c(1987, 2020), ylim = c(35, 72), pch = 19)
# plot predictions
newdata <- data.frame(year = seq(1987, 2020, length = 100))
plotPredictions(mod1, newdata, col = "blue", lwd = 2)


##############
# Finito!.... 
#   unless you want to try a quick gam?
##############





# we could maybe do better
# what about a smooth trend over years ?
# first load the gam library called mgcv
library(mgcv)
# a model with a smoother over years
mod2 <- gam(urbanO ~ s(year), data = dat)

anova(mod1, mod2, test = "F")
# so smooth deviation away from a straight line is significant at 5% level

# lets plot the fit using our function!

# plot data
plot(dat$year, dat$urbanO, xlim = c(1987, 2020), ylim = c(35, 72), pch = 19)

# plot predictions from gam model
plotPredictions(mod2, newdata, col = "red", lwd = 2)

# compare with linear model ...
plotPredictions(mod1, newdata, col = "blue", lwd = 1)


# see below for a fancy version of plotPredictions


#####  EYE CANDY - use this function and redo plots ...
plotPredictions <- function(mod, data, col = "blue", lwd = 2)
{
  # predict 
  pred <- predict(mod, data, se.fit = TRUE)

  # add predictions with approximate 95% confidence interval
  data$fit <- pred$fit
  data$ciu <- pred$fit + 2*pred$se
  data$cil <- pred$fit - 2*pred$se

  # draw confidence intervals as polygons with see through colour
  polygon(c(data$year, rev(data$year)), c(data$ciu, rev(data$cil)), 
          border = NA, lwd = lwd,
          col = paste(rgb(t(col2rgb(col)), maxColorValue = 255), "44", sep = ""))

  lines(data$year, data$fit, col = col, lwd = 2)
}




