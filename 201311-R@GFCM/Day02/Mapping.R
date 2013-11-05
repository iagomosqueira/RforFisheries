# T08_Mapping.R - DESC
# T08_Mapping.R

# Copyright 2003-2013 FLR Team. Distributed under the GPL 2 or later
# Maintainer: Iago Mosqueira, JRC
# $Id: $
# Created:
# Modified:
# MAPPING

# often it is useful to plot a spatial dataset that comes with geographical positions such as Latitude
# and Longitude without having to use ARCGis or other stand alone packages. In R there are several mapping facilities
# that allow increasingly sophisticated mappings
library(maps) ; library(mapdata) ; library(mapproj)

?map
data(ozone)
ozone # have a look at the lat and long data

# how do the positions look on a plot
plot(ozone$x, ozone$y)

# to plot Lat and Long on a map we can't just plot them as is and expect things to work
map("world") # this uses as default a rectangular projection with the aspect ratio chosen so that
# longitude and latitude scales are equivalent at the center of the picture

# other types of projections
map("world", projection='bonne', par=45) # Bonne equal-area projection of states
map("world", projection='albers', par=c(-20,45))

#type of coordinates
# different standards exist depending on measuring equipment and cartographic reference system, one important difference is between
# Degrees Minutes Seconds and Decimal Degrees

#For example take the last points of the ozone dataset, these are expressed as Decimal Degrees
ozone[41,]

#which correspond in Degrees Minutes Seconds to:
# Latitude: -73 37' 30.36" Longitude: 43 19' 17.0394"

# Conversion made using online tool (http://transition.fcc.gov/mb/audio/bickel/DDDMMSS-decimal.html)
# but you can also use existing R scripts to perform batch conversions from Degrees Minutes Seconds (which are a common GPS format) to Decimal Degrees

# R Script to convert from Degrees Minutes Seconds to Decimal Degrees (which is what you need for plotting)

lat_start # Latitute in Degrees Minutes
lon_start # Longitude in Degrees Minutes
lat_d = floor(lat_start/100);
lon_d = floor(lon_start/100);
lat_m = (lat_start/100-lat_d)/60*100;
lon_m = (lon_start/100-lon_d)/60*100;
lat = lat_d + lat_m;
lon = lon_d + lon_m;


# back to the ozone example, in maps we need to define the lat and long box for plotting at the appropriate scale by using x and ylim
map("state", xlim = range(ozone$x), ylim = range(ozone$y))

# add the values of ozone concentration median with the text command
text(ozone$x, ozone$y, ozone$median)
box()
mymap<-map("state", xlim = range(ozone$x), ylim = range(ozone$y))

symbols(ozone$x, ozone$y, circles=ozone$median/500, add=T,inches=FALSE, fg="red")

symbols(ozone$x, ozone$y, circles=ozone$median/500, add=T,inches=FALSE, fg=1:10)
box()




###########################################################################################################################
# Exercise on mapping
# 1 Make a map of the ozone data with margins larger 1 Degree more than the actual data limits in order to get a better map
# (hint use min and max) and make state contours blue.

# 2 plot squared symbols for the ozone density

# 3 fill the squares with a green color and add map axes

# 4 Add a legend where the size of the bubbles as a scale, hints use pt.cex in legend command and define few values of ozone to
# reduce the legend size


############################################################################################################################


# Introducing ggmap

geocode("rome via colonna 1")

map<-ggmap(
	   get_googlemap(
	        center=c(12.47284, 41.90513), #Long/lat of centre, or "Edinburgh"
	         zoom=4, 
	        maptype='roadmap', #also hybrid/terrain/roadmap
	         scale = 2), #resolution scaling, 1 (low) or 2 (high)
	     size = c(600, 600), #size of the image to grab
	     extent='device', #can also be "normal" etc
	     darken = 0) #you can dim the map when plotting on top

#Generate some data
long = c(0, 1, 12, 14)
lat = c(44, 41, 45, 40)
who = c("Tommaso", "Finlay", "Frida", "Paolo")
data = data.frame (long, lat, who)


map+geom_point(data=data, aes(y=lat, x=long, fill = factor (who)), 
							 pch = 21, 
							 colour = "white", 
							 size = 6) 


# Assignment

Plot the ozone data on a with on a google map !

# Nice tutorial
#http://journal.r-project.org/archive/2013-1/kahle-wickham.pdf

#The most attractive aspect of using different map sources (Google Maps, OpenStreetMap, StamenMaps, and CloudMade Maps) is

