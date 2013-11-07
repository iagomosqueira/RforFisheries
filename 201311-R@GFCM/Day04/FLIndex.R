# Introduction to FLIndex
# Copyright 2013 FISHREG. Distributed under the GPL 2 or later
# Maintainer: FISHREG, JRC

# In this tutorial we take a look at the FLIndex class.
# The FLIndex class is used to store information on a
# survey of a fish stock. This includes information
# such as catches and hours fished rates, and also 
# when in the year a fishery took place.

#-----------------------------------------------------
# Getting started
#-----------------------------------------------------

# Load FLCore
library(FLCore)

# Load the example FLindex object: ple4.index, plaice in the North Sea
data(ple4.index)

# Is it an FLIndex?
class(ple4.index)
# Yes

#-----------------------------------------------------
# FLIndex demo
#-----------------------------------------------------

# Why do we need an FLStock?
# THe most important bits are the index (CPUE) values

index(ple4.index)

# And when the fishery took place, which is set up in the range

range(ple4.index)

# And plot it for a quick look

plot(ple4.index)

#-----------------------------------------------------
# Inside an FLIndex
#-----------------------------------------------------

# help("FLIndex-class")

# If you want to inspect the whole object you can try:

ple4.index

# But you just get pages of text that is difficult to read
# An easier way to look inside is to use summary()

summary(ple4.index)

# You get a:
#     Name
#     Description
#     Range
#     and then lots of other things like index, index.var etc
# These all have 6 numbers after them
# These are the sizes of the dimensions of the FLQuant that is used to store that information
# (remember an FLQuant has 6 dimensions)
# An FLIndex is really just a collection of FLQuant objects
# Each of these FLQuant objects is known as a 'slot'
# An FLStock has 12 slots
# 7 of them are FLQuant objects
# + name (character string)
# + desc (character string)
# + range (numeric vector)
# + type (character string)
# + distribution (character string)

# We can see this by using the getSlots() method

getSlots("FLIndex")

# Or str()

str(ple4.index, 2)

#-----------------------------------------------------
# Accessing the slots
#-----------------------------------------------------

# There are at least two ways of accessing a slot
# Using the '@' operator

ple4.index @ index

# using the name of the slot (e.g. catch())

index(ple4.index)

# Using the second method is recommended

# As these slots are FLQuant objects they can accessed in the usual way:

index(ple4.index)[, as.character(2005:2008)]

# All the FLQuant slots have an age (quant) structure

# You can also access the non-FLQuant slots in this way
name(ple4.index)
desc(ple4.index)
range(ple4.index)
# The range is important as it sets the values for the plusgroup and the range over which the survey took place

# Here fishing takes place between 0.66 and 0.75.
# Let's change that so the survey took place in the first quarter of the year
range(ple4.index)["startf"] <- 0
range(ple4.index)["endf"] <- 0.25
range(ple4.index)

# We have already seen plot() and summary()
summary(ple4.index)
plot(ple4.index)
# We can plot individual slots
plot(index(ple4.index))

# we can make it look a bit nicer
ple4.index.df <- as.data.frame(index(ple4.index))

# which looks like this
head(ple4.index.df)

# and we can use ggplot2 library to make nice plots :)
library(ggplot2)
ggplot(ple4.index.df, aes(x = year - age, y = log(data), color = factor(age))) + geom_line()


#-----------------------------------------------------
# Manipulating FLIndex objects
#-----------------------------------------------------

# Many FLQuant methods also available at this level
# For example window and trim

# window() - similar to how we used it with an FLQuant
range(ple4.index)
smallple4 <- window(ple4.index, start = 2000, end = 2008)
# Check new year range
range(smallple4)

# Use window to make it bigger
bigple4 <- window(ple4.index, start = 2000, end = 2015)
range(bigple4)
# What does it fill the extra years up with?
index(bigple4)

# Can also use subsetting with []
temp <- ple4.index[,as.character(1998:2001)]
summary(temp)

# summary(propagate(ple4, 10)) # Ignore for now
summary(trim(ple4, year=1990:1999))



#-----------------------------------------------------
# Reading in data to make an FLIndex
#-----------------------------------------------------

# There are several ways of creating an FLIndex object
# One method is to create an empty FLStock of the required size
# and then fill up the slots by hand

# We saw in the FLQuant tutorial how to read in data from a *.csv file.
# Here we look at a similar process for reading in data to create an FLStock

# Lets pretend we have read some data in already and created some FLQuants

cpue <- index(ple4.index)
cpue

# We can make an FLIndex of the correct dimensions using the FLIndex() constructor
# and passing in the FLQuant and other slots (where available)

indx <- FLIndex(index = cpue,
               name = "My survey",
               desc = "A survey I made")
summary(indx)

# We have created an FLStock with the same dimensions as the FLQuant we passed in
# We have also filled up the stock.n slot
index(indx)

# But the other slots are currently empty
index.var(indx)

# the only other thing to do is to make sure the range slot is correct
range(indx)

# Let's change that so the survey took place in june
range(indx)["startf"] <- 5/12
range(indx)["endf"] <- 6/12
range(indx)

# and we can now plot it as before
plot(indx)
summary(indx)


ggplot(as.data.frame(index(indx)), 
       aes(x = year - age, y = log(data), color = factor(age))) + 
  geom_line()

