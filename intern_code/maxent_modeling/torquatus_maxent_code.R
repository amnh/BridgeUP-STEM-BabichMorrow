# BRADYPUS TORQUATUS 
# Maxent modeling code

# luna + Anjali 
# 3/19/19

# Required packages -------------------------------------------------------

# Load all the packages you need for the analyses
# You need 1) the package for spatial thinning, 2) the package for mapping,
# 3) the packages from background_region_tutorial.Rmd,
library(spThin)
library(ggmap)
library(rgeos)
library(sp)
library(raster)
library(dismo)

library(ENMeval)
# 4) the package used in partitioning occurrences


# Occurrence data ---------------------------------------------------------

# Import the dataset for B. torquatus from data/occurrence_data
torquatus <- read.csv("~/Desktop/Project3/Data/occurrence_data/torquatus.csv")
# torquatus <- read.csv("~/OneDrive - AMNH/BridgeUp/BridgeUP-STEM-BabichMorrow/data/occurrence_data/torquatus.csv")
## ANJALI FILE PATH
torquatus <- read.csv("~/Desktop/bridgeup\ year\ 2/Main\ Sloth\ Squad\ Repository/Data/occurrence_data/torquatus.csv")
View(torquatus)
#fixing the data
torquatus$name <- "Bradypus_torquatus"

# Visualize occurrence data -----------------------------------------------

# Use the ggmap package to plot the occurrence points for your species on a map
# Share this map in Slack

#Set the API key again
api_key = "AIzaSyBK7lLbqoqnYFdzf-idYYposb-1gwyRAlQ"
register_google(key = api_key)
bound_box <- make_bbox(lon = torquatus$longitude, lat = torquatus$latitude, f = 2)
#Get a satellite map at the location of the bounding box you made:
bbox_map <- get_map(location = bound_box, maptype = "satellite", source = "google")

ggmap(bbox_map) +
  geom_point(data = torquatus, aes(x = longitude, y = latitude),
             color = "green",
             size =1)


# Spatial thinning --------------------------------------------------------

# Refer to your code from intern_code/occ_data_cleaning.R
# (and also lesson_plans/s2_process_occ_data/sloth_cleaning_pt3.Rmd)

# Thin your occurrence data to a distance of 40 km
thinned_torquatus <- thin(loc.data = torquatus, lat.col = "latitude", long.col = "longitude", spec.col = "name", thin.par = 40, reps = 100, locs.thinned.list.return = TRUE, write.files = FALSE, verbose = FALSE)
torquatus_maxThin <- which(sapply(thinned_torquatus, nrow) == max(sapply(thinned_torquatus, nrow)))
if(length(torquatus_maxThin) > 1){
  torquatus_maxThin <- thinned_torquatus[[torquatus_maxThin[1]]]
} else{
  torquatus_maxThin <- thinned_torquatus[[torquatus_maxThin]]
}
thinned_torquatus <- torquatus[rownames(torquatus_maxThin),]
# Check how many rows were removed by spatial thinning
View(thinned_torquatus)
#removed 28
# Share this number in Slack


# Visualize which points were removed using ggmap
bound_box <- make_bbox(lon = thinned_torquatus$longitude, lat = thinned_torquatus$latitude, f = 2)
#Get a satellite map at the location of the bounding box you made:
bbox_map <- get_map(location = bound_box, maptype = "satellite", source = "google")

ggmap(bbox_map) +
  geom_point(data = thinned_torquatus, aes(x = longitude, y = latitude),
             color = "green",
             size =1)

# Save the thinned occurrence data as a csv in the data/occurrence_data/ folder
# Name it with your species name and the word "thinned"


# Create background region ------------------------------------------------

# Refer to lesson_plans/s4_process_env_data/background_region_tutorial.Rmd  https://github.com/deathbunbun/BridgeUP-STEM-BabichMorrow/blob/master/lesson_plans/s4_process_env_data/background_region_tutorial.Rmd

# Create a background region for your species (based on the thinned occurrence data!):
## B. torquatus: points buffered by 1 degree
occs.sp <- SpatialPoints(thinned_torquatus[,2:3])
View(occs.sp)
plot(occs.sp)
# Create buffered points background extent
torquatus_buffer <- gBuffer(occs.sp, width = 1.0)
# Plot buffered MCP
plot(torquatus_buffer)

# Create cropped raster
## LUNA BIOCLIM FILES
bioclim_files <- list.files("/Users/lunaeve/Desktop/wc2/")
## ANJALI BIOCLIM FILES
bioclim_files <- list.files("/Users/student/Desktop/wc2.0_2.5m_bio/")
bioclim_files
## LUNA ENV STACK
env_stack <- stack(paste0("/Users/lunaeve/Desktop/wc2/", bioclim_files))
## ANJALI ENV STACK
env_stack <- stack(paste0("/Users/student/Desktop/wc2.0_2.5m_bio/", bioclim_files))
plot(env_stack)

torquatus_BgCrop <-  crop(env_stack, torquatus_buffer)
plot(torquatus_BgCrop)

torquatus_BgMsk <- mask(torquatus_BgCrop, torquatus_buffer)
# Sample 10000 points from the MCP
bg.xy <- randomPoints(torquatus_BgMsk, 10000)
# Convert these points into a dataframe using as.data.frame
bg.xy <- as.data.frame(bg.xy)
# Make a map of your background region
plot(torquatus_BgMsk)
# Share that map in Slack
#done 

# Remember to sample background points from your background region

# Partition occurrence data -----------------------------------------------

# Refer to lesson_plans/s5_partition_occ_data.Rmd

# Partition your thinned occurrence data:
## if your species has 25 or fewer thinned occurrences, use a jackknife partition
## if your species has >25 thinned occurrences, use a block partition
torquatus_Partition <- get.jackknife(occs.sp, bg.xy)
occs.grp <- torquatus_Partition[[1]]
bg.grp <- torquatus_Partition[[2]]

# Visualize the partitioned occurrence data on a map
api_key = "AIzaSyBK7lLbqoqnYFdzf-idYYposb-1gwyRAlQ"
register_google(key = api_key)
# Create bounding box to view South America
torquatus_bbox <- make_bbox(lon = c(-95, -25), lat = c(-35,20), f = 0.1)
torquatus_map <- get_map(location = torquatus_bbox, source = "google", maptype = "satellite")
ggmap(torquatus_map)

ggmap(torquatus_map) +
  geom_point(data = thinned_torquatus, aes(x = longitude, y = latitude), color = occs.grp ,
             size =.5)
# Share this map in Slack


# Build Maxent models -----------------------------------------------------

# Refer to lesson_plans/s6_build_eval_niche_model/ENMeval_tutorial.Rmd

# Use regularization multiples from 1 to 5 with a step value of 1


max_rms <- seq(from = 1, to = 5, by = 1)

# Use feature classes "L", "LQ", "H", and "LQH")
max_fcs <- c("L", "LQ", "H", "LQH")


# Run ENMevaluate()
# and unpack results data frame, list of models, and RasterStack of raw predictions

max_enm <- ENMevaluate(occ = thinned_torquatus[,2:3], env = torquatus_BgMsk, bg.coords = bg.xy , RMvalues = max_rms, fc = max_fcs, method = "jackknife", clamp = TRUE)
max_evalTbl <- enm@results
max_evalMods <- enm@models
max_evalPreds <- enm@predictions
View(max_evalTbl)

# Save the object you create using ENMevaluate using saveRDS()
# Name it with the species name and your initials
saveRDS(object = max_enm, file = "torquatusLA.rds", ascii = FALSE, version = NULL, compress = TRUE, refhook = NULL)
# Upload it to GitHub


# Select Maxent model -----------------------------------------------------

# Refer to lesson_plans/s6_build_eval_niche_model/model_selection_tutorial.Rmd

# Sort the results data frame using AUC, OR, and/or AIC
# Select the "best" model according to your criteria
## WE WANT HIGHER AUC, LOWER 10PCT, LOWER AIC VALUES
max_sorted <- max_evalTbl[order(-max_evalTbl$avg.test.AUC, max_evalTbl$avg.test.or10pct, max_evalTbl$delta.AICc),]
View(max_sorted)
## LQH_3 IS THE BEST MODEL FOR AUC AND 10PCT AND DOES PRETTY WELL WITH DELTA AIC

# Slack the name of the best model and the criteria you used to select it

# Visualize model ---------------------------------------------------------

# Generate the model prediction and plot it WITH BUFFERED MASKED RASTER
# Share this map in Slack
torquatus_model <- max_evalMods[[9]]
maxprediction_bufferBgRegion <- maxnet.predictRaster(mod = torquatus_model, env = torquatus_BgMsk, type = "cloglog", clamp = TRUE)
plot(maxprediction_bufferBgRegion)
points(thinned_torquatus[2:3])

# Project in space --------------------------------------------------------

# Project the model to a bounding box for your species and plot the projection WITH BBOX MASKED RASTER
# Share this map in Slack

## creating a bounding box:
torquatus_bbox <- bbox(as.matrix(thinned_torquatus[2:3]))
torquatus_bbox <- as(extent(torquatus_bbox), "SpatialPolygons")
plot(torquatus_bbox)
torquatus_bboxcrop <- crop(env_stack, torquatus_bbox)
plot(torquatus_bboxcrop)

maxprediction_bboxBgRegion <- maxnet.predictRaster(mod = torquatus_model, env = torquatus_bboxcrop, type = "cloglog", clamp = TRUE)
plot(maxprediction_bboxBgRegion)
points(thinned_torquatus[2:3])

# Project forward in time --------------------------------------------------------

# Find the resolution of your masked environmental data
envsRes <- res(torquatus_BgMsk)[1]
View(envsRes)
## 0.04166667

# Set two different GCMs: HadGEM2-ES and CCSM4 (we are going to project to 2 different GCMs to compare the results)
GCM_1 <- "HE"
GCM_2 <- "CC"

# Set three different RCPs: 2.6, 6, and 8.5
RCP_1 <- 26
RCP_2 <- 60
RCP_3 <- 85

# Set the year to be 2070
year <- 70

# Download the data for the 6 different combinations of GCM and RCP (all at the year 2070)
projTimeEnvs_1 <- getData('CMIP5', var = "bio", res = 2.5, rcp = RCP_1, model = GCM_1, year = year)
projTimeEnvs_2 <- getData('CMIP5', var = "bio", res = 2.5, rcp = RCP_2, model = GCM_1, year = year)
projTimeEnvs_3 <- getData('CMIP5', var = "bio", res = 2.5, rcp = RCP_3, model = GCM_1, year = year)
projTimeEnvs_4 <- getData('CMIP5', var = "bio", res = 2.5, rcp = RCP_1, model = GCM_2, year = year)
projTimeEnvs_5 <- getData('CMIP5', var = "bio", res = 2.5, rcp = RCP_2, model = GCM_2, year = year)
projTimeEnvs_6 <- getData('CMIP5', var = "bio", res = 2.5, rcp = RCP_3, model = GCM_2, year = year)

# Set the names of your environmental data
names(projTimeEnvs_1) <- c(paste0("wc2.0_bio_2.5m_0",1:9) , paste0("wc2.0_bio_2.5m_", 10:19))
names(projTimeEnvs_2) <- c(paste0("wc2.0_bio_2.5m_0",1:9) , paste0("wc2.0_bio_2.5m_", 10:19))
names(projTimeEnvs_3) <- c(paste0("wc2.0_bio_2.5m_0",1:9) , paste0("wc2.0_bio_2.5m_", 10:19))
names(projTimeEnvs_4) <- c(paste0("wc2.0_bio_2.5m_0",1:9) , paste0("wc2.0_bio_2.5m_", 10:19))
names(projTimeEnvs_5) <- c(paste0("wc2.0_bio_2.5m_0",1:9) , paste0("wc2.0_bio_2.5m_", 10:19))
names(projTimeEnvs_6) <- c(paste0("wc2.0_bio_2.5m_0",1:9) , paste0("wc2.0_bio_2.5m_", 10:19))

# Crop and mask the environmental data to the bounding box for your species
projTimeEnvs_1_bboxCrop <- crop(projTimeEnvs_1, torquatus_bboxcrop)
projTimeEnvs_1_bboxMsk <- mask(projTimeEnvs_1_bboxCrop, torquatus_bboxcrop)
plot(projTimeEnvs_1_bboxMsk)
  
projTimeEnvs_2_bboxCrop <- crop(projTimeEnvs_2, torquatus_bboxcrop)
projTimeEnvs_2_bboxMsk <- mask(projTimeEnvs_2_bboxCrop, torquatus_bboxcrop)
plot(projTimeEnvs_2_bboxMsk)

projTimeEnvs_3_bboxCrop <- crop(projTimeEnvs_3, torquatus_bboxcrop)
projTimeEnvs_3_bboxMsk <- mask(projTimeEnvs_3_bboxCrop, torquatus_bboxcrop)
plot(projTimeEnvs_3_bboxMsk)

projTimeEnvs_4_bboxCrop <- crop(projTimeEnvs_4, torquatus_bboxcrop)
projTimeEnvs_4_bboxMsk <- mask(projTimeEnvs_4_bboxCrop, torquatus_bboxcrop)
plot(projTimeEnvs_4_bboxMsk)

projTimeEnvs_5_bboxCrop <- crop(projTimeEnvs_5, torquatus_bboxcrop)
projTimeEnvs_5_bboxMsk <- mask(projTimeEnvs_5_bboxCrop, torquatus_bboxcrop)
plot(projTimeEnvs_5_bboxMsk)

projTimeEnvs_6_bboxCrop <- crop(projTimeEnvs_6, torquatus_bboxcrop)
projTimeEnvs_6_bboxMsk <- mask(projTimeEnvs_6_bboxCrop, torquatus_bboxcrop)
plot(projTimeEnvs_6_bboxMsk)

# Project the model into the future -- you will end up with 6 different projected models
projTimeEnvs_1_bboxRegion <- maxnet.predictRaster(mod = torquatus_model, env = projTimeEnvs_1_bboxMsk, type = "cloglog", clamp = TRUE)
projTimeEnvs_2_bboxRegion <- maxnet.predictRaster(mod = torquatus_model, env = projTimeEnvs_2_bboxMsk, type = "cloglog", clamp = TRUE)
projTimeEnvs_3_bboxRegion <- maxnet.predictRaster(mod = torquatus_model, env = projTimeEnvs_3_bboxMsk, type = "cloglog", clamp = TRUE)
projTimeEnvs_4_bboxRegion <- maxnet.predictRaster(mod = torquatus_model, env = projTimeEnvs_4_bboxMsk, type = "cloglog", clamp = TRUE)
projTimeEnvs_5_bboxRegion <- maxnet.predictRaster(mod = torquatus_model, env = projTimeEnvs_5_bboxMsk, type = "cloglog", clamp = TRUE)
projTimeEnvs_6_bboxRegion <- maxnet.predictRaster(mod = torquatus_model, env = projTimeEnvs_6_bboxMsk, type = "cloglog", clamp = TRUE)

# Plot the projected models
plot(projTimeEnvs_1_bboxRegion, main = "2070 Worst Case Scenario HE")
points(thinned_torquatus[,2:3])

plot(projTimeEnvs_2_bboxRegion, main = "2070 Moderate Case Scenario HE")
points(thinned_torquatus[,2:3])

plot(projTimeEnvs_3_bboxRegion, main = "2070 Best Case Scenario HE")
points(thinned_torquatus[,2:3])

plot(projTimeEnvs_4_bboxRegion, main = "2070 Worst Case Scenario CC")
points(thinned_torquatus[,2:3])

plot(projTimeEnvs_5_bboxRegion, main = "2070 Moderate Case Scenario CC")
points(thinned_torquatus[,2:3])

plot(projTimeEnvs_6_bboxRegion, main = "2070 Best Case Scenario CC")
points(thinned_torquatus[,2:3])

# Response curves --------------------------------------------------------

# Check which variables in the model have non-zero coefficients

# Plot response curves

