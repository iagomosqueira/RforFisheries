# Here is one solution.
# There are many others

library(FLCore)
getwd()

# Read stock numbers into an FLQuant 
sn <- read.csv("stock_n.csv", row.names = 1)
sn <- as(sn,'matrix')
sn_fq <- FLQuant(sn, dimnames = list(age = 1:8, year = 1957:2008), quant='age')



# Read stock weights into an FLQuant
sw <- read.csv("stock_wt.csv", row.names = 1)
sw <- as(sw,'matrix')
# But note that this data is the wrong way round! i.e. year by age, not age by year
# So you could transpose the data in the *.csv file and save again (e.g. using Excel)
# Or use the t() function to transpose it
sw <- t(sw) 
# Now make the FLQuant
# Note that the age and year range are different to the stock numbers
sw_fq <- FLQuant(sw, dimnames = list(age = 1:10, year = 1970:2008), quant='age')

# Make a new FLQuant of biomass by age
# numbers * weight
b <- sn_fq * sw_fq

# But they are different sizes
dim(sn_fq)
dim(sw_fq)

# Use trim
sn_fq <- trim(sn_fq, year = 1970:2008)
sw_fq <- trim(sw_fq, age = 1:8)

# Try again
b <- sn_fq * sw_fq

# To get the total biomass, sum over the ages.
# At least two ways.

tb <- quantSums(b)

# Or
tb <- apply(b,2,sum)

# Finally, take the mean of the last 3 years
tb[,as.character(2006:2008)]
mean(tb[,as.character(2006:2008)])

