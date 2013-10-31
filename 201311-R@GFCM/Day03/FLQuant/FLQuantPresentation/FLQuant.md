% The FLQuant class
%
% November 2013

# FLQuant

The building block of FLR

Used to store your data (catches, abundances, etc)

All other FLR classes (FLStock, FLIndex) etc. are made from collections of FLQuant objects

Fortunately, they are simple

# What is it?

FLQuant = Array with 6 dimensions

* `quant` - e.g. age or length
* `year`
* `unit` - e.g. sex disaggregation
* `season`
* `area`
* `iter` - iteration, for uncertainty

Plus `units`

# Installing FLR

install.packages(repos="htpp://flr-project.org/R")


