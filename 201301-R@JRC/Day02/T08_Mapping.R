# TXX_Mapping.R - DESC
# TXX_Mapping.R

# Copyright 2003-2013 FLR Team. Distributed under the GPL 2 or later
# Maintainer: Iago Mosqueira, JRC
# $Id: $
# Created:
# Modified:

# latitude and longitude can be plotted

land <- read.table("land.csv", header = TRUE, sep = ",")

plot(land$lon, land$lat, type = "l")

# lets read in some data locations and plot them
survey <- read.table("survey.csv", header = TRUE, sep = ",")

points(survey$lon, survey$lat, pch = 19, cex = 0.5)




# we can use for loops to show some extra detail
plot(land$lon, land$lat, type = "l")

ships <- unique(survey $ ship)
nships <- length( ships )
cols <- 1:nships

for (i in 1:nships) {
  sub <- survey[survey$ship == ships[i], ]
  points(sub$lon, sub$lat, pch = 19, cex = 0.5, col = cols[i])
}

# we can also color the land masses
polygon(land, col = "grey50")

legend(-12, 65, ships, col = cols, pch = 19)

# These packages can be useful if you want to use different projections

install.packages(c('maps', 'mapdata', 'mapproj'))

library(maps)
library(mapdata)
library(mapproj)


pdf("myplot.pdf")

# now for Europe
map("worldHires", xlim = c(-10, 30), ylim = c(36, 65))

dev.off()

# other types of projections
# Bonne equal-area projection of states
map("worldHires", projection='bonne', par = 45, xlim = c(-10, 30), ylim = c(36, 65))

# Albers equal-area conic projection
map("worldHires", projection='albers', par = c(-10,30), xlim = c(-10, 30), ylim = c(36, 65))


# now for Italy
map("italy", interior = FALSE)

# add Ispra
points(8.6306, 45.8000, pch = 19, col = "red") 
points(8.6306, 45.8000, pch = 1, col = "blue", cex = 2, lwd = 2) 


# also see this webpage for much better examples!
#
# http://blog.revolutionanalytics.com/2009/10/geographic-maps-in-r.html 
#



