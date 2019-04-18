# BRADYPUS TRIDACTYLUS
# Maxent modeling code

# Yamile and Ula and Hanora 
# April 2019 

# Required packages -------------------------------------------------------

# Load all the packages you need for the analyses
# You need:
# 1) the package for spatial thinning, 
# 2) the package for mapping,
# 3) the packages from background_region_tutorial.Rmd,
# 4) the package used in partitioning occurrences.

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
tridactylus <- read_csv("~/Desktop/Project Repository clone/Data/occurrence_data/tridactylus.csv")
tridactylus$name <- "Bradypus_tridactylus"

# Visualize occurrence data -----------------------------------------------

# Use the ggmap package to plot the occurrence points for your species on a map

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
#Ula's
bioclim_files <- list.files("/Users/student/Desktop/wc2.0_2.5m_bio")
bioclim_files

env_stack <- stack(paste0("/Users/student/Desktop/wc2.0_2.5m_bio/", bioclim_files))

# Create a background region for your species (based on the thinned occurrence data!):
# B. tridactylus: MCP buffered by 1 degree

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

# Build Maxent models -----------------------------------------------------

# Refer to lesson_plans/s6_build_eval_niche_model/ENMeval_tutorial.Rmd

# Use regularization multiples from 1 to 5 with a step value of 1
# Use feature classes "L", "LQ", "H", and "LQH"
library(ENMeval)
View(thinned_occs)
rms <- seq(1,5,1)
fcs <- c("L", "LQ", "H", "LQH")

# Run ENMevaluate()
# and unpack results data frame, list of models, and RasterStack of raw predictions
View(thinned_occs)

#enm <- ENMevaluate(occ = thinned_occs[,3:4], env = envsBgMsk, bg.coords = bg.xy, RMvalues = rms, fc = fcs, method = "block", clamp = TRUE)
#Hanora
enm <- readRDS("tridactylus_enm_us.rds")

# Save the object you create using ENMevaluate using saveRDS()
# Name it with the specsaveRDS(enm, file = "tridactylus_enm_us.rds")
# Upload it to GitHub

# Save RDS object (Cecina) 
#Ula
saveRDS(enm, file = "tridactylus_enm_us.rds")

evalTbl <- enm@results
evalMods <- enm@models
evalPreds <- enm@predictions

# Select Maxent model -----------------------------------------------------

# Refer to lesson_plans/s6_build_eval_niche_model/model_selection_tutorial.Rmd

# Sort the results data frame using AUC, OR, and/or AIC
# Select the "best" model according to your criteria
sorted_data_tribest <- evalTbl[order(evalTbl$delta.AICc,evalTbl$avg.test.or10pct,-evalTbl$avg.test.AUC), ]
View(sorted_data_tribest)
#LQH_1 is the best

# Slack the name of the best model and the criteria you used to select it
#Lowest delta val
#Second highest avg test AUC
#Doesn't actually stand up well in 10th percentile

# Visualize model ---------------------------------------------------------

# Generate the model prediction and plot it
names(evalMods) <- enm@results$settings
model <- evalMods[["LQH_1"]]

occs.sp <- SpatialPoints(thinned_occs[, 3:4])
bgExt_enm <- gBuffer(occs.sp, width = 1.0)

# Create cropped raster
envsBgCrop_enm <- crop(env_stack, bgExt_enm)

# Create masked raster
envsBgMsk_enm <- mask(envsBgCrop_enm, bgExt_enm)

# Project the model to the background region you selected and plot the projection

# create prediction
prediction_bgRegion <- maxnet.predictRaster(model, envsBgMsk_enm, type = "cloglog", clamp = TRUE)

# plot prediction
plot(prediction_bgRegion)

# Project in space --------------------------------------------------------

# Project the model to a bounding box for your species and plot the projection

bgExt_ftri <- bbox(as.matrix(thinned_occs[, 3:4]))
envsBgCrop_ftri <- crop(env_stack, extent(bgExt_ftri))

prediction_bgRegion_tri <- maxnet.predictRaster(model,envsBgCrop_ftri , type = "cloglog", clamp = TRUE)

# plot prediction
plot(prediction_bgRegion_tri)
points(thinned_occs[,3:4])

# Project forward in time --------------------------------------------------------

# Find the resolution of your masked environmental data


# Set two different GCMs: HadGEM2-ES and CCSM4 (we are going to project to 2 different GCMs to compare the results)


# Set three different RCPs: 2.6, 6, and 8.5


# Set the year to be 2070


# Download the data for the 6 different combinations of GCM and RCP (all at the year 2070)

# Set the names of your environmental data

# Crop and mask the environmental data to the bounding box for your species


# Project the model into the future -- you will end up with 6 different projected models
# Plot the projected models

