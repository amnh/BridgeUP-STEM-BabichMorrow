# BRADYPUS TRIDACTYLUS
# Maxent modeling code

# Yamile and Ula 
# March 2019 

# Required packages -------------------------------------------------------

# Load all the packages you need for the analyses
# You need:
# 1) the package for spatial thinning, 2) the package for mapping,
# 3) the packages from background_region_tutorial.Rmd,
# 4) the package used in partitioning occurrences

library(readr) # the package for reading csv files
library(spThin) # the package for spatial thinning
library(ggmap) # the package for mapping

# the packages from background_region_tutorial.Rmd
library(rgeos)
library(sp)
library(raster)a
library(dismo)

# the package used in partitioning occurrences
library(ENMeval)

# Occurrence data ---------------------------------------------------------

# Import the dataset for B. tridactylus from data/occurrence_data
tridactylus <- read_csv("~/Desktop/BridgeUP-STEM-BabichMorrow2/Data/occurrence_data/tridactylus.csv")
tridactylus$name <- "Bradypus_tridactylus"

# Visualize occurrence data -----------------------------------------------

# Use the ggmap package to plot the occurrence points for your species on a map
# Share this map in Slack

# permission from google to get map
api_key = "AIzaSyBK7lLbqoqnYFdzf-idYYposb-1gwyRAlQ"
register_google(key = api_key)

# this zooms into specific region of South America
# this region is near the area of border intersection of Northern Brazil & Southern French Guiana & Southern Suriname 
bound_box <- make_bbox(lon = tridactylus$longitude, lat = tridactylus$latitude, f = 0.5)
bbox_map <- get_map(location = bound_box, maptype = "satellite", source = "google")

#plots the area and the sloth occurence points 
ggmap(bbox_map) + 
  geom_point(data = tridactylus, aes(x = longitude, y = latitude),
             color = "yellow",
             size =0.25)
 
# Spatial thinning --------------------------------------------------------

# Refer to your code from intern_code/occ_data_cleaning.R
# (and also lesson_plans/s2_process_occ_data/sloth_cleaning_pt3.Rmd)

# Thin your occurrence data to a distance of 40 km

tridactylus$name <- "Bradypus_tridactylus"
thinned_output <- thin(loc.data = tridactylus, lat.col = "latitude", long.col ="longitude" , spec.col = "name", thin.par = 40, reps = 100, locs.thinned.list.return = TRUE, write.files = FALSE)
maxThin <- which(sapply(thinned_output, nrow) == max(sapply(thinned_output, nrow)))
if(length(maxThin) > 1){
  maxThin <- thinned_output[[ maxThin[1] ]]
} else {
  maxThin <- thinned_output[[maxThin]]
}

thinned_occs <- tridactylus[rownames(maxThin),]
nrow(thinned_occs)

# Check how many rows were removed by spatial thinning
# Share this number in Slack: 44
# Visualize which points were removed using ggmap

ggmap(bbox_map) + 
  geom_point(data = thinned_occs, aes(x = longitude, y = latitude),
             color = "yellow",
             size =0.25)

# Save the thinned occurrence data as a csv in the data/occurrence_data/ folder
# Name it with your species name and the word "thinned"

save(thinned_occs, file = "tridactylus_thinned")

# Create background region ------------------------------------------------

# Refer to lesson_plans/s4_process_env_data/background_region_tutorial.Rmd & lesson_plans/s3/worldclim_inR.Rmd 
bioclim_files <- list.files("/Users/student/Desktop/wc2.0_2.5m_bio")
bioclim_files

env_stack <- stack(paste0("/Users/student/Desktop/wc2.0_2.5m_bio/", bioclim_files))

# Create a background region for your species (based on the thinned occurrence data!):
## B. tridactylus: MCP buffered by 1 degree
mcp <- function(xy) {
  # convert the input coordinates into a spatial object
  xy <- as.data.frame(sp::coordinates(xy))
  # find the subset of occurrence points that lie on the convex hull around all of the points
  coords.t <- chull(xy[, 1], xy[, 2])
  xy.bord <- xy[coords.t, ]
  xy.bord <- rbind(xy.bord[nrow(xy.bord), ], xy.bord)
  # make a SpatialPolygon out of the convex polygon
  return(sp::SpatialPolygons(list(sp::Polygons(list(sp::Polygon(as.matrix(xy.bord))), 1))))
}

  bgExt <- mcp(thinned_occs[,3:4] )
  envsBgCrop <- crop(env_stack,bgExt)
  envsBgMsk <- mask(envsBgCrop, bgExt)
  plot(envsBgMsk)
  
# Make a map of your background region
# Share that map in Slack

# Remember to sample background points from your background region
  
  bg.xy <- randomPoints(envsBgMsk, 10000)
  # Convert these points into a dataframe using as.data.frame
  bg.xy <- as.data.frame(bg.xy)
  View(bg.xy)

# Partition occurrence data -----------------------------------------------

# Refer to lesson_plans/s5_partition_occ_data.Rmd

# Partition your thinned occurrence data:
## if your species has 25 or fewer thinned occurrences, use a jackknife partition
## if your species has >25 thinned occurrences, use a block partition

group.data <- get.block (thinned_occs[,3:4], bg.xy)
group.data
occs.grp <- group.data[[1]]
bg.grp <- group.data[[2]]
  
# Visualize the partitioned occurrence data on a map

SA_bbox <- make_bbox(lon = c(-95, -25), lat = c(-35,20), f = 0.1)
SA_map <- get_map(location = SA_bbox, source = "google", maptype = "satellite")
ggmap(SA_map)

ggmap(SA_map) +
  geom_point(data = thinned_occs[,3:4], aes(x=longitude, y=latitude), color = occs.grp )

# Modify the above code to instead see the background points (`bg.xy`) you created colored by their group number (`bg.grp`). You will have to change the x and y column names.

ggmap(SA_map) +
  geom_point(data = bg.xy, aes(x=x, y=y), color = bg.grp)

# Share this map in Slack



