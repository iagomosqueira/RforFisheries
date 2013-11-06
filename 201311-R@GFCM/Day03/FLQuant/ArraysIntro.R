# A very, very short introduction to arrays

# So far we have dealt with objects that have a single value

x <- 1

# Vectors (that have one dimension)

x <- c(1,2,3)

# You access vectors using [] and specifying the elements
# we want to access
x[1:2]

# We are now moving into the world of arrays...
# An array is an n-dimensional table for storing one type of data
# This is more restrictive than a data.frame
# Each column of a data.frame must store same type of data
# But columns can be different types (numeric, character etc)
# Example data.frame
data(ToothGrowth)
ToothGrowth


# Arrays are created by array(), specifying the dimensions with dim

# Let's create a 2D array with 4 x 5 values
# Think of a 2D array as a table
x <- array(1:20,dim=c(4,5))

# x has 4 rows and 5 columns

# You access arrays using []
# Here we have two dimensions, so we have to specify the
# row and column number when accessing
# They are seperated by a ,
# e.g. to access the 2nd column of the 4th row
x[4,2]

# You can access multiple values
x[3:4,2]

# If you miss out a coordinate (but keep the ,)
# you get the whole row or column
x[,2]
# Gets all of column 2

# You can assign values too
x[4,2] <- 700
x
# And assign multiple values
x[3:4,2] <- c(600,700)

# Can also specify dimnames 
x <- array(1:20, dim=c(4,5), dimnames=list(age = 2:5, year = 2000:2004))
# You can now access using dimnames
# These have to be CHARACTERS
x[,"2001"] 
x[,2001] # Trying to access the column 2001

x[2,]
x["2",]
# A very good way of making mistakes!

# Arrays do not have to be 2D...
