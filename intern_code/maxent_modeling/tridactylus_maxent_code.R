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
library(raster)
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


# Create background region ------------------------------------------------

# Refer to lesson_plans/s4_process_env_data/background_region_tutorial.Rmd

# Create a background region for your species (based on the thinned occurrence data!):
## B. tridactylus: MCP buffered by 1 degree


# Make a map of your background region
# Share that map in Slack


# Remember to sample background points from your background region

# Partition occurrence data -----------------------------------------------

# Refer to lesson_plans/s5_partition_occ_data.Rmd

# Partition your thinned occurrence data:
## if your species has 25 or fewer thinned occurrences, use a jackknife partition
## if your species has >25 thinned occurrences, use a block partition


# Visualize the partitioned occurrence data on a map
# Share this map in Slack



