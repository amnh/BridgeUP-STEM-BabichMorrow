#Required packages
library(ggmap)

#Set the API key again
api_key = "AIzaSyBK7lLbqoqnYFdzf-idYYposb-1gwyRAlQ"
register_google(key = api_key)

#Load dataset:
library(readr)
ufo_data <- read_csv("data/ufo_data.csv")
View(ufo_data)
#Need to make latitude a numeric
ufo_data$latitude = as.numeric(ufo_data$latitude)

#reorder columns so longitude and latitude are the first two columns
ufo_data <- ufo_data[c(11, 10, 1:9)]

#Make dataframe:
world_map <- map_data("world")

#Assign the world map plot to the variable "world"
world <- ggplot() + 
  geom_polygon(data = world_map, aes(x=long, y = lat, group = group), fill = "grey", color = "darkgrey")
#plot the world map
world

#add UFO sightings to map
world +
  geom_point(data = ufo_data, aes(x = longitude, y = latitude),
             color = "green",
             size = 1)
#lotsssss in the US

#check for NA values in latitude and longitude columns
ufo_data$longitude[is.na(ufo_data$longitude)]
ufo_data$latitude[is.na(ufo_data$latitude)]
which(is.na(ufo_data$latitude))
View(ufo_data[which(is.na(ufo_data$latitude)),])

#get rid of the rows that have NA in the latitude column
ufo_data <- ufo_data[!is.na(ufo_data$latitude),]

#add UFO sightings to map
world +
  geom_point(data = ufo_data, aes(x = longitude, y = latitude),
             color = "green",
             size = 1)

#Check out unique values for columns
unique(ufo_data$state)
unique(ufo_data$country)
unique(ufo_data$shape)

#bar graph of sightings by shape
counts <- table(ufo_data$shape)
#with vertical x-axis labels
barplot(counts, main="UFO Sightings by shape", las = 2)
#doesn't look all that nice: want to rank from most to least
#Use ggplot



