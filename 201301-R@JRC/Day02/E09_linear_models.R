# E0X_linear_models.R
# Day02/E0X_linear_models.R

# Copyright 2011-13 JRC FishReg. Distributed under the GPL 2 or later
# Maintainer: FishReg, JRC

# Introduction to R for Fisheries Science

# Exercise

# 1.
#   simulate some data: using the model
#
#     y = 0.1x + 1 + e
#
#   where e is normal(mean = 0, sd = 1)
#
#   and x = 1, 2, 3, ..., 100


# 2. inspect the relationship by plotting x against y

# basic models:
# intercept only      : y ~ 1
# slope only          : y ~ x - 1
# intercept and slope : y ~ x, or y ~ x + 1  (either will do)

# 3. fit a linear model (lm) and check the fitted parameters are close to the truth
# functions to use:  lm, coef, and/or confint

# 4. plot the data (x and y) and plot the fit using predict()

