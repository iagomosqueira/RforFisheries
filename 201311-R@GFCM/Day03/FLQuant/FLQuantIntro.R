# Tutorial: Introduction to FLQuant objects
# Copyright 2013 FLR Core Development Team
# Distributed under the GPL 2 or later

#-------------------------------------------------------
# Installing FLCore
#-------------------------------------------------------
# Start R or RStudio 

# You should only need to do this once...

install.packages(repos="http://flr-project.org/R", pkgs="FLCore")

#-------------------------------------------------------
# Looking inside an FLQuant
#-------------------------------------------------------

# The first practical covers the most basic class in the `FLCore` library: `FLQuant`.
# `FLQuant`s are the building blocks of nearly all of the
# objects used in FLR and consequently understanding them is important.
# The following tutorial should provide a good foundation on which build.

# The `FLQuant` class is essentially a six-dimensional array used to store
# data of one particular type (e.g. catch data).

# We use FLQuant objects to hold our data because they provide a common structure.
# This makes analysing data and building models easier as functions know what to expect.

# To help us understand the structure of the `FLQuant` class we will
# look at an example object.

# Load the FLCore library

library(FLCore)

# and then load the included dataset, `ple4`.

data(ple4)

# Don't worry about what `ple4` is for the moment (it is actually an
# object of the composite class `FLStock` and will be covered later.
# ple4 is plaice in the North Sea.).

# We can extract a single `FLQuant` from this object to use in our
# exploration. Let's call it `fq`.

fq <- catch.n(ple4)

# fq contains the catch numbers of North Sea plaice, by age and year.
# Again, don't worry about the catch.n() function - all will become clear
# To have a look at `fq` simply type:

fq

# You may find that `fq` does not all fit on the screen at once.
# Use the scroll bars to look at it if necessary.
# You should see that `fq` looks like a two-dimensional array, with dimension names:
# `age` (from 1 to 10) and
# `year` (from 1957 to 2008).

# What kind of object is it?
class(fq)

# Although the data in `fq` only appears to have two dimensions,
# an `FLQuant` actually always has six dimensions.
# However, often one or more of them will be collapsed.

dim(fq)

# For example, the data stored in the `fq` object is only
# disaggregated by two dimensions `age` and `year`. The remaining four
# dimensions have length 1 (they are collapsed).

# So our example FLQuant is essentially a two dimensional array: age by year.

# What are the names of the dimensions?

dimnames(fq)

# The dimension names: year, unit, season, area and iter are fixed
# The name of the first dimension of the data is not fixed.
# It can be altered by the user.
# For example, the name could be `age`, `length`, `vesselclass` etc.
# In `fq` the first dimension is named `age`. Any character string
# is accepted, but it should contain no spaces.
# When not set it is usually refered to as the `quant` of the FLQuant.

# The remaining five dimensions have fixed names. The six dimensions of an
# FLQuant are, in this order:
# 
# -   user defined (or `quant`)
# -   `year`
# -   `unit`
# -   `season`
# -   `area`
# -   `iter`
# 
# `year` needs no explanation. `unit` is open to any sort of division that
# might be of use, like male/female disaggregation, substocks etc.
# `season` and `area` allow for time and space subdivisions. `iter` is for
# storing iterations, for example, as the result of a Monte Carlo
# simulation.

# For most of this course we will only be using the first two dimensions.

# As well as the data `FLQuant` also has an attribute, called `units`.
# This is a character string that stores information about the units of
# measurement of the data.
# The units of `fq` are currently set as “thousands”.
# You can access and set the units using the units() function.

units(fq)

# Do not confuse units with the `unit` dimension.

# Users are allowed to use any name they wish, but standard names are
# encouraged as they allow for clear interpretation. 
# 
# -   Mass: `“kg”`, `“t”`
# -   Length: `“cm”`, `“m”`


#-------------------------------------------------------
# Summarising an FLQuant
#-------------------------------------------------------

# There is a default plot for an FLQuant

plot(fq)

# FLR plots use the 'lattice' package
# It is also possible to use 'ggplot2' using the 'ggplotFL' package
# We will look at this later

summary(fq)

#-------------------------------------------------------
# Accessing and manipulating data in an FLQuant
#-------------------------------------------------------

# An FLQuant is really just a 6D array.
# That means we can use normal methods for accessing and manipulating
# the contents of an FLQuant

# Operations on an FLQuant almost always return an object that is
# also an FLQuant

# Let's remind ourselves of the dimensions of our FLQuant
dim(fq)

#The main method for accessing part of the data contained in an `FLQuant`
#is through the subsetting operator ”[”, for example:

fq[1:4,1:8,1,1,1,1]

# The returned object is also an `FLQuant`.
# Numbers can be ommited for any dimension that is not to be subset
# (note that this is not standard array behaviour and is special to FLR):

fq[1:4,1:8] 

# An important consideration is the use of numbers or characters when
# subsetting. The previous example used numbers to refer to the positions
# along the dimensions in the object.
# It is also possible to use characters. For example, if we were to select
# the last five years from the `fq` object, we could do any of these:

fq[,41:45]
fq[,c('1997', '1998', '1999', '2000', '2001')]
fq[,as.character(1997:2001)]

# as.character() is a function to turn numeric values into characters.


# To assign values to the data array the subsetting operator is also used.
# For example, a selected part of an `FLQuant` can be modified:

fq[,41:45] <- 99
fq[,40:46]

# Logical subsetting can also be used to reference particular elements in the array.
# For example we can find the positions of the elements that are equal to 99
# Note the use of 2 '='.
# This means 'test for equality' and is different to the assignment operator

fq == 99

# We can then use these positions to assign new values
# For example, to assign a zero to every element in the array that is currently equal to 99 use:

fq[fq==99] <- 0
fq

#-------------------------------------------------------
# Operators on FLQuant objects
#-------------------------------------------------------

# You can use normal arithmetic operators on FLQuant objects

fq * 1000
fq / 1000
fq + 1000

# These operations all return FLQuant objects
fq2 <- fq + 1000
class(fq2)

# You can also use them on two FLQuant objects if their dimensions are the same

fq + fq2

# There are many other operators available.
# Some that are useful are:
# quantSums()
# quantMeans()
# quantVars()

# These return the sum, mean and variance over the first dimension (remember the first dimension is called 'quant' by default).
quantSums(fq)
quantMeans(fq)
quantVars(fq)

#-------------------------------------------------------
# Creating a new FLQuant
#-------------------------------------------------------

# It's possible to make an FLQuant in several ways
# Using 'new'
fq <- new("FLQuant")
# It's empty and all dimensions are length 1

# Passing in a dim argument
fq <- FLQuant(dim=c(8,15))
# This is equivalent to
fq <- FLQuant(dim=c(8,15,1,1,1,1))
# But we ignore dimensions with length 1

# Set the name of the quant dimension
fq <- FLQuant(dim=c(6,8), quant='length')
# Set the name of the quant dimension and units
fq <- FLQuant(dim=c(6,8), quant='age', units = "kg")

# Passing in a dimnames argument
fq <- FLQuant(dimnames=list(age = 1:8, year = 1998:2005))

# Can fill it up with something
fq <- FLQuant(0.2, dim=c(8,15))
# Recycling the input vector
fq <- FLQuant(3:10, dim=c(8,15))

#-------------------------------------------------------
# Reading in data into a FLQuant
#-------------------------------------------------------

# Often we have our data outside R and we want to read it in
# Here we look at how to read data into an FLQuant
# You should be able to see the file 'stock_n.csv'
# This is the estimated stock abundance of North Sea plaice by age and year
# Load this into Excel or OpenOffice or some other spreadsheet
# By saving your data as a *.csv file you can then import it easily into R

# read.table and its friends
?read.table

# Key options to look out for:
# file (obviously)
# header
# sep
# row.names
# col.names

# Save your data as a *.csv file (comma separated file)
# Example file in /Data/catch_numbers.csv
# Note that we have row and column names (ages and years)

# Read this in using read.table() with default options
catch_n <- read.table("catch_numbers.csv")
catch_n

# Looks terrible
# what just happened?
# The separator in our file is a comma , so we need to specify that
catch_n <- read.table("catch_numbers.csv", sep=',')

# Better but the column and row names have been included as data
# We can try to fix this using the header and row.names options
catch_n <- read.table("catch_numbers.csv", header=TRUE, sep=',')

# Specify which column has the row names 
catch_n <- read.table("catch_numbers.csv", header=TRUE, sep=',', row.names=1)

# The column names are ugly (with the Xs) but that is OK for now
# Can use read.csv() instead - same as read.table() but different default options
catch_n <- read.csv("catch_numbers.csv",row=1)

# We have read in the data as a data.frame
class(catch_n)
# There is an FLQuant constructor that uses a data.frame, but here our data.frame is not set up the right way
# Instead we can convert the object to a matrix
catch_n_matrix <- as.matrix(catch_n)
catch_n_matrix
# We need to specify the dimnames
catch_n_flq <- FLQuant(catch_n_matrix, dimnames=list(age=1:7, year = 1957:2011))
catch_n_flq

# If you get get your data into R you can get it into an FLQuant.
# If you get your data into an FLQuant you get it into any FLR object!

#-------------------------------------------------------
# Altering the size of an FLQuant
#-------------------------------------------------------

# The size of an FLQuant can be changed
# This can be necessary when dealing with multiple FLQuant objects that come from different sources

# window() can be used to shrink or expand along the year dimension
dimnames(catch_n_flq)
# shrink
window(catch_n_flq, start=2006, end=2008)
# grow - new years are filled with NA
window(catch_n_flq, start=2006, end=2013)

# trim() can only be used to shrink, but can work along any dimension
trim(catch_n_flq, age = 1:4)
trim(catch_n_flq, year = 2007:2009) # Note that for year, the as.character() conversion happens implicitly

#-------------------------------------------------------
# Bonus section (if really keen)
#-------------------------------------------------------

# Refresh fq
fq <- catch.n(ple4)

# Checking and changing quant and units
# Both the name of the first dimension (the quant) and the content of the
# units attribute slot can be checked and altered using the `quant()` and
# `units()` methods:

quant(fq)
quant(fq) <- 'age'
units(fq)
units(fq) <- 't'

# as.data.frame

# `FLQuant`s can be transformed into a plain table representation by using
# the `as.data.frame()` method. This allows the data contained in an
# `FLQuant` to be transferred to a spreadsheet or used as an input in
# other programs. The output format of the method is a table with rows
# representing all datapoints and columns for the various subsetting
# dimensions (quant, year,…) plus a final column for the data itself. For
# example, `fq` used in the previous example can be output using:

ft <- as.data.frame(fq)

# apply

# To use a certain function over a numbers of dimensions of an array or
# `FLQuant` object, the `apply` method can be used. The function to apply
# should calculate a summary of the input data, such as `mean` or `sum`.
# The second argument is the dimension over which apply works, this can be any numeric vector 
apply(fq, 2:6, sum)
apply(fq, c(1,3), mean)

# Using `apply` with `FLQuant` objects is intended to behave as using
# `apply` with standard R arrays.


# show

# The show method controls the output obtained when an object name is
# invoked directly at the prompt. It is the simplest method for visually
# inspecting an object contents.

show(fq)

# If an FLQuant has more than one iteration, `show` will display the
# median, followed by the median absolute deviation. For example,

fq2 <- FLQuant(rnorm(75), dim=c(5,3,1,1,1,5))
show(fq2)

# Useful functions for the 6th dimension

# We haven't really looked at the 6th dimension (iter) so far.
# However, it is very useful when you want to consider uncertainty
# There are several methods for showing or creating variance in FLQuants

# Quantiles can be estimated in the statistical distribution of the
# values in the 6th dimension

quantile(fq2, 0.05)
quantile(fq2, 0.95)

# Simplifying with FLQuantPoint

# Using FLQuantPoint can simplify FLQuant objects with multiple iterations

flq <- FLQuant(rnorm(200), dim=c(6,20,1,1,1,100), quant='age', units='kg')
flp <- FLQuantPoint(flq)

flp
summary(flp)
plot(flp)
 
# the 5 elements (mean, median, var, lowq, uppq) along iter can be inspected using
iters(flp)
 
# and each of them can be extracted
mean(flp)
lowq(flp)
 
# and modified
mean(flp) <- mean(flp)*2
 
# FLQuant objects can be generated once we assume a probability distribution
rnorm(20, flp)

# 
install.packages(repos="http://flr-project.org/R", pkgs="FLEDA")
library(FLEDA)
bubbles(age ~ year, data = fq, bub.scale = 10)

