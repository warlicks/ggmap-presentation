# Sean Warlick
# ggmap presentation: Live Code Portion
# March 12, 2015
###############################################################################
#Install Needed Packages
install.packages("ggmap", "data.table")

#Load Library and Set Working Directory
###############################################################################
library(data.table)
library(ggmap)
library(ggplot2)

# Load Data
###############################################################################
bike<-fread("presentation_data.csv", header = TRUE, sep = ',')

##Cluster Cirlce Data
angle<-seq(-pi,pi,length=50)
df<-data.frame(x= 0.01351351 * sin(angle) - 77.038319, y = 0.01351351 * cos(angle) + 38.931150)
df$type = rep("Departure", 50)

# Getting The Map
###############################################################################

## Name a Landmark
map<-get_map(location = "White House")
map<-ggmap(map)
map

## Provide and Address
map<-ggmap(get_map(location = '1600 Pennslyvainia Ave NW, Washington, DC')) 

## Provide a Longitude and Latitude to Cetner The Map
map<-ggmap(get_map(location=c(lon = -77.00455, lat = 38.90893), zoom = 12, maptype = "roadmap", source = 'google')) #Using Latitude and Longitude
map

## Provide Four Corners of The Map
box<-make_bbox(lon = longitude, lat = latitude, data = bike)
map<-ggmap(get_map(location = box, source = 'google', zoom = 12, maptype = 'roadmap'))

## Add Detail to the map
map + geom_point(data = bike, aes(x = longitude, y = latitude, size = average))

map + geom_point(data = bike, aes(x = longitude, y = latitude, colour = average))

map + geom_point(data = bike, aes(x = longitude, y = latitude)) + geom_polygon(aes(x, y, linetype = type), data = df, fill = NA, colour = "black", inherit.aes = TRUE)


# Geo Coding
###############################################################################
## Name a Landmark
geocode(location = "White House")

## Set an Address
address<-geocode(location = "2201 G St. NW, Washington, DC")
address

## Create an Intersection
geocode(location = "G St NW & 22nd St NW, Washington, DC")
map2<-ggmap(get_map(location = c(lon = -98.01001, lat = 41.11103)))
map2  #Intersections Don't Seem to Work.

# Geocode a State
geocode(location = 'Iowa')
map3<-ggmap(get_map(location = c(lon = -93.0977, lat = 41.874), source = 'google', zoom = 7))
map3

## Geocode Several Locations At Once
cordinates<-geocode(location = c("Hartsfield - Jackson Atlanta International", "LAX", 'ORD', 'DFW', 'Denver International', 'JFK', 'SFO', 'CLT', 'LAS', 'PHX', 'Miami International', 'IAH', 'EWR', 'MCO', 'SEA', 'MSP', 'DTW', 'BOS', 'PHL', 'LGA'))

##  Check to see how many calls too Google API we have left. 
geocodeQueryCheck()

#Compute Distances
###############################################################################
distance<-mapdist(bike[name == "Kennedy Center", as.numeric(list(longitude, latitude))], bike[name == "White House", as.numeric(list(longitude, latitude))], mode = 'bicycling')

#Get Directions
###############################################################################
directions<-route(bike[name == "Kennedy Center", as.numeric(list(longitude, latitude))], bike[name == "White House", as.numeric(list(longitude, latitude))], mode = 'bicycling')

map + geom_segment(data = directions, aes(x = startLon, y = startLat, xend = endLon, yend = endLat))

# Layer a Shape File on Top of Google Map If There is Time
###############################################################################
## Load needed library & Set WD
library(gpclib)
library(maptools)
setwd("zipcode_shapefile") #Folder with shape files.

## Load Shape File and Prepare for Plotting
gpclibPermit() #Needed to get the fortify function to work
shapefile<-readShapeSpatial("tl_2010_11_zcta510.shp") #Load Shape File
shapefile@data$id = rownames(shapefile@data) #Prep Shape File
dc.points<-fortify(shapefile, region = "id") #Prepare to work with ggplot

## Add Stations and zipcodes
map + geom_path(aes(x = long, y = lat, group = group), data = dc.points, size = .3) + geom_point(data = bike, aes(x = longitude, y = latitude))

#End of File