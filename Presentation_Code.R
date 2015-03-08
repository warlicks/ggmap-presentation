# Sean Warlick
# ggmap presentation: Live Code Portion
# March 12, 2015
###############################################################################

#Load Library and Set Working Directory
setwd("/Users/SeanWarlick/Documents/GitHub/ggmap-presentation")
library(data.table)
library(ggmap)
library(ggplot2)

# Load Data
###############################################################################
bike<-fread("bike2.csv", header = TRUE, sep = ',')
station<-fread("station_location.csv", header = TRUE, sep = ',')
setnames(station, "Station_Id", "Start_Id")

#Cluster Cirlce Data
angle<-seq(-pi,pi,length=50)
df<-data.frame(x= 0.01351351 * sin(angle) - 77.038319, y = 0.01351351 * cos(angle) + 38.931150)
df$type = rep("Departure", 50)

# Fast Data Manipulation
###############################################################################
weekday_bike<-bike[, length(Bike_Key) / 91, by = Start_Id] #Coup
weekday_bike<-merge(weekday_bike, station, by = "Start_Id")
setnames(weekday_bike, "V1", "average")

# Getting The Map
###############################################################################

## Name a Landmark
map<-get_map(location = "White House")
map<-ggmap(map)
map

## Provide and Address
map<-ggmap(get_map(location = '1600 Pennslyvainia Ave NW, Washington, DC')) 

## Provide a Longitude and Latitude to Cetner The Map
map<-ggmap(get_map(location=c(lon = -77.00455, lat = 38.90893), zoom = 12, maptype = "road", source = 'google')) #Using Latitude and Longitude
map

## Provide Four Corners of The Map
box<-make_bbox(lon = longitude, lat = latitude, data = weekday_bike)
map<-ggmap(get_map(location = box, source = 'google', zoom = 12, maptype = 'road'))
map<-ggplot(map, extent = "device", legend = "topright") #Convert to ggplot object

## Add Detail to the map
map + geom_point(data = weekday_bike, aes(x = longitude, y = latitude, size = average))

map + geom_point(data = weekday_bike, aes(x = longitude, y = latitude, colour = average))

map + geom_polygon(aes(x, y, linetype = type), data = df, fill = NA, colour = "black", inherit.aes = TRUE)


# Geo Coding
###############################################################################
## Name a Landmark
geocode(location = "White House")

## Set an Address
address<-geocode(location = "2201 G St. NW, Washington, DC")
address

## Create an Intersection
geocode(location = "G St NW & 22nd St NW, Washington, DC")
map<-ggmap(get_map(location = c(lon = -98.01001, lat = 41.11103)))
map

#Intersections Don't Seem to Work.  