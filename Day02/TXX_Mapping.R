# TXX_Mapping.R - DESC
# TXX_Mapping.R

# Copyright 2003-2013 FLR Team. Distributed under the GPL 2 or later
# Maintainer: Iago Mosqueira, JRC
# $Id: $
# Created:
# Modified:

install.packages(c('maps', 'mapdata', 'mapproj'))


library(maps)
library(mapdata)
library(mapproj)

# ozone example dataset
data(ozone)

head(ozone)

# how do the positions look on a plot

plot(ozone$x, ozone$y)

# World map with default rectangular projection (latitude and longitude)
map("world")

# other types of projections
map("world", projection='bonne', par=45)  # Bonne equal-area projection of states
map("world", projection='albers', par=c(-20,45)) # Albers equal-area projection


# now for Europe
map("world", xlim = c(-10, 30), ylim = c(36, 65))
map("world", projection='bonne', par = 45, xlim = c(-10, 30), ylim = c(36, 65))
map("world", projection='albers', par = c(-20,45), xlim = c(-10, 30), ylim = c(36, 65))

