library(spocc)
library(ggmap)

# api_key = 
register_google(key = api_key)

variegatus <- occ(query = "Bradypus variegatus", from = 'gbif', limit = 1000)
tridactylus <- occ(query = "Bradypus tridactylus", from = 'gbif', limit = 1000)

variegatus_df <- occ2df(variegatus)
tridactylus_df <- occ2df(tridactylus)

#Make dataframe:
world_map <- map_data("world")

#Assign the world map plot to the variable "world"
world <- ggplot() + 
  geom_polygon(data = world_map, aes(x=long, y = lat, group = group), fill = "grey", color = "darkgrey")

#map sloth points on map
world +
  geom_point(data = variegatus_df, aes(x = longitude, y = latitude),
             color = "green",
             size = 1)

world +
  geom_point(data = tridactylus_df, aes(x = longitude, y = latitude),
             color = "green",
             size = 1)

#This time, we specify the bounding box using the latitude and longitude columns from our data
var_bound_box <- make_bbox(lon = variegatus_df$longitude, lat = variegatus_df$latitude, f = .5)
#Get a satellite map at the location of the bounding box you made:
var_bbox_map <- get_map(location = var_bound_box, maptype = "satellite", source = "google")

tri_bound_box <- make_bbox(lon = tridactylus_df$longitude, lat = tridactylus_df$latitude, f = .5)
#Get a satellite map at the location of the bounding box you made:
tri_bbox_map <- get_map(location = tri_bound_box, maptype = "satellite", source = "google")

ggmap(var_bbox_map) + 
  geom_point(data = variegatus_df, aes(x = longitude, y = latitude), 
             color = "red",
             size =1)

ggmap(tri_bbox_map) + 
  geom_point(data = tridactylus_df, aes(x = longitude, y = latitude), 
             color = "red",
             size =1)

ggmap(var_bbox_map) + 
  geom_point(data = variegatus_df, aes(x = longitude, y = latitude, color = date),
             size =1)

ggmap(tri_bbox_map) + 
  geom_point(data = tridactylus_df, aes(x = longitude, y = latitude, color = date),
             size =1)
