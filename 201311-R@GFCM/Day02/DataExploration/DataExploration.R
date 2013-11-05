# Tutorial: Introduction to FLQuant objects
# Copyright 2013 FLR Core Development Team
# Distributed under the GPL 2 or later

#-------------------------------------------------------
# Exploring data
#-------------------------------------------------------

# first we will read in some data...

# the data file is on our github page - the address of the file is
# https://github.com/iagomosqueira/RforFisheries/tree/master/201311-R%40GFCM

catch_wt <- read.csv("catch_wt.csv")
catch_n <- read.csv("catch_n.csv")

str(catch_wt)

head(catch_wt)

tail(catch_wt)

#  Lets take one column
age1 <- sn $ age1

# the simplest way is to print it
age1
# or
print(age1)

# look at the start and end of the data
head(age1)


tail(age1)


# okay, but what is it?
str(age1)

# so we can do numerical summaries

# the sum of the data 
sum(age1)

# the number of values in the vector
length(age1)

# so we can now calculate the mean
sum(age1) / length(age1)

# or more simply
mean(age1)

# the sample standard deviation
sd(age1)

# or written out in full
sqrt( sum( (age1 - mean(age1))^2 ) / (length(age1) - 1) )

# so shortcuts are nice!


# there are lots of summaries of data vectors
median(age1)

quantile(age1, .5)

quantile(age1, c(.25, .75))

min(age1)

max(age1)

summary(age1)

signif(mean(age1), 3)


# plotting the data is also useful
plot(age1)

# to get a line plot
plot(age1, type = "l")

abline(h = median(age1), col = "red")

abline(h = quantile(age1, c(.05, .95)), lty = 2)


# plotting with two vectors

# lets get catches at age 2
age2 <- sn $ X2

# plot age 2 agains age 1
plot(age1, age2)

#######################################
# working with matrices
#######################################


# The simplest way to look at your data is to print it
sn

# what is this?
is(sn)
# so it is a data.frame

# let's convert it to a matrix
sn.mat <- as.matrix(sn)
sn.mat




# We use FLQuant objects to hold our data because they provide a common structure.
# This makes analysing data and building models easier as functions know what to expect.

# To help us understand the structure of the `FLQuant` class we will
# look at an example object.

# Start R or RStudio and load the FLCore library

library(FLCore)

# and then load the included dataset, `ple4`.

data(ple4)

# Don't worry about what `ple4` is for the moment (it is actually a
# composite object of type `FLStock` and will be covered later).
# We can extract a single `FLQuant` from this object to use in our
# exploration. Let's call it `fq`.
# This contains the catch numbers of North Sea plaice, by age and year

fq <- catch.n(ple4)

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
# the data array of an `FLQuant` actually always has six dimensions.

dim(fq)

# However, often one or more of them will be collapsed.
# For example, the data stored in the `fq` object is only
# disaggregated by two dimensions `age` and `year`. The remaining four
# dimensions are collapsed and have length 1.

# So our example FLQuant is essentially a two dimensional array: age by year

# What are the names of the dimensions?

dimnames(fq)

# The name of the first dimension of the data is not set and can be
# altered by the user. For example, the name could be `age`, `length`,
# `vesselclass` etc. In `fq` the first dimension is named `age`. Any
# character string is accepted, but it should contain no spaces. When not
# set it is usually refered to as the `quant` of the FLQuant. The
# remaining five dimensions have fixed names. The six dimensions of an
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

units(fq)

# Do not confuse units with the `unit` dimension.
# Users are allowed to use any name they wish, but standard names are
# encouraged as they allow for clear interpretation. 
# 
# -   Mass: `“kg”`, `“t”`
# -   Length: `“cm”`, `“m”`

# There is a default plot for an FLQuant

plot(fq)

#-------------------------------------------------------
# Accessing and manipulating data in an FLQuant
#-------------------------------------------------------

# An FLQuant is really just a 6D array.
# That means we can use normal methods for accessing and manipulating
# the contents of an FLQuant

# Operations on an FLQuant almost always return an object that is also an FLQuant

# Let's remind ourselves of the dimensions of our FLQuant
dim(fq)

#The main method for accessing part of the data contained in an `FLQuant`
#is through the subsetting operator ”[”, for example:

fq[1:4,1:8,1,1,1,1]

# The returned object is also an `FLQuant`.
# Numbers can be ommited for any dimension that is not to be subset:

fq[1:4,1:8,,,] 

# An important consideration is the use of numbers or characters when
# subsetting. The previous example used numbers to refer to the positions
# along the dimensions in the object.
# It is also possible to use characters. For example, if we were to select
# the last five years from the `fq` object, we could do any of these:

fq[,41:45,,,,]
fq[,c('1997', '1998', '1999', '2000', '2001'),,,,]
fq[,as.character(1997:2001),,,,]


# To assign values to the data array the subsetting operator is also used.
# For example, a selected part of an `FLQuant` can be modified at will:

fq[,41:45,,,,] <- 99
fq[,40:46,,,,]


# Logical subsetting can also be used to reference particular elements in the array.
# For example we can find the positions of the elements that are equal to 99

fq == 99

# We can then use these positions to assign new values
# For example, to assign a zero to every element in the array that is currently equal to 99 use:

fq[fq==99] <- 0
fq

#-------------------------------------------------------
# Creating an FLQuant
#-------------------------------------------------------

# Possible to make an FLQuant in several ways
# Using 'new'
fq <- new("FLQuant")
# Passing in a dim argument
fq <- FLQuant(dim=c(8,15,1,1,1,1))
fq <- FLQuant(dim=c(6,8,1,1,1,1), quant='length')
fq <- FLQuant(dim=c(6,8,1,1,1,1), quant='age', units = "kg")
# Passing in a dimnames argument
fq <- FLQuant(dimnames=list(age = 1:8, year = 1998:2005, unit = 'unique', season = 'all', area = 'unique'))
# Can fill it up with something
fq <- FLQuant(0.2, dim=c(8,15,1,1,1,1))
# Recycling the input vector
fq <- FLQuant(1:8, dim=c(8,15,1,1,1,1))

# Often we have our data outside R and we want to read it in
# Here we look at how to read data into an FLQuant
# You should be able to see the file 'stock_n.csv'
# This is the estimated stock abundance of North Sea plaice by age and year
# Load this into Excel or OpenOffice or some other spreadsheet
# By saving your data as a *.csv file you can then import it easily into R
# Use the 'read.csv' function

sn <- read.csv("stock_n.csv", row.names = 1)
sn

# If your data is seperated by other seperators (;, " ", etc.) you can use the 'sep' argument
# See ?read.csv for more details

# The row.names argument tells R which column to use as the row names

# There is a small issue of the year names.
# You can see that R has added an X in front of the numbers

colnames(sn)

# This doesn't matter because we won't actually be using those columns names

# What kind of object is sn?

class(sn)

# It's a dataframe
# We want a matrix so we use 'as()'

sn <- as(sn,'matrix')
class(sn)

# We can use to make an FLQuant
# But we need to specify the dimnames

sn_fq <- FLQuant(sn, dimnames = list(age = 1:10, year = 1957:2008), quant='age')
class(sn_fq)
plot(sn_fq)

# If you get get your data into R you can get it into an FLQuant.
# If you get your data into an FLQuant you get it into any FLR object!

#-------------------------------------------------------
# Operators on FLQuant objects
#-------------------------------------------------------

# You use normal arithmetic operators on FLQuant objects

sn_fq * 1000
sn_fq / 1000
sn_fq + 1000

# You can also use them on two FLQuant objects if their dimensions are the same

sn_fq + sn_fq

# These operations all return FLQuant objects


#-------------------------------------------------------
# Bonus section (if really keen)
#-------------------------------------------------------

# Refresh fq
fq <- catch.n(ple4)

# window 
# Selection and extension of an `FLQuant` object along the `year`
# dimension can be carried out with the `window()` method.
# This can also be used for extending the year range of the FLQuant.
# Note the 'start' and 'end' arguments interpret the values as character strings.

window(fq, start=2006, end=2008)
window(fq, start=2006, end=2010)

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
# Many of the common `apply` methods have been defined for `FLQuant`
# objects including `quantSums`, and `quantMeans`.
# It should be noted that these `quantSums` methods are generally faster than apply.
# However, apply is more flexible in defining the dimensions over which
# functions will be applied.

quantSums(fq)
quantMeans(fq)

# Inspecting FLQuants

# Several methods exist for inspecting `FLQuant` objects.

# summary

# This method outputs to screen a brief summary of an object's dimensions
# as a named list:

summary(fq)

### show

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


