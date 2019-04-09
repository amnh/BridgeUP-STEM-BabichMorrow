# BRADYPUS VARIEGATUS
# Maxent modeling code

# Hanora and Loralai
# 3/19/19
# Eat it Nerds

# Required packages -------------------------------------------------------

# Load all the packages you need for the analyses
# You need 1) the package for spatial thinning, 2) the package for mapping,
# 3) the packages from background_region_tutorial.Rmd,
# 4) the package used in partitioning occurrences

library(rgeos)
library(sp)
library(raster)
library(dismo)
library(ggmap)
library(spThin)
library(ENMeval)

# Occurrence data ---------------------------------------------------------

# Import the dataset for B. variegatus from data/occurrence_data
variegatus = read.csv("~/Desktop/Project Repository Clone/Data/occurrence_data/variegatus.csv")


# Visualize occurrence data -----------------------------------------------

# Use the ggmap package to plot the occurrence points for your species on a map

ggmap(v_map) +
  geom_point(data = variegatus, aes(x=longitude, y=latitude))

api_key = "AIzaSyBK7lLbqoqnYFdzf-idYYposb-1gwyRAlQ"
register_google(key = api_key)

boxing <- make_bbox(lon = c(-95, -25), lat = c(-35, 20), f = 0.1)

SA_map <- get_map(location = boxing, source = "google", maptype = "satellite")

ggmap(SA_map) +
geom_point(data = variegatus, aes(x = longitude, y = latitude))

# Spatial thinning --------------------------------------------------------

# Refer to your code from intern_code/occ_data_cleaning.R
# (and also lesson_plans/s2_process_occ_data/sloth_cleaning_pt3.Rmd)


# Thin your occurrence data to a distance of 40 km
variegatus_df <- as.data.frame(variegatus)
variegatus_df$name <- "Bradypus_variegatus"
View(variegatus_df)

thinned_output <- thin(loc.data = variegatus , lat.col = "latitude", long.col = "longitude", spec.col = "name", thin.par = 40, reps = 100, locs.thinned.list.return = TRUE, write.files = FALSE)
View(thinned_output)

maxThin <- which(sapply(thinned_output, nrow) == max(sapply(thinned_output, nrow)))
if(length(maxThin) > 1){
  maxThin <- thinned_output[[ maxThin[1] ]]
} else{
  maxThin <- thinned_output[[maxThin]]
}
View(maxThin)

thinned_occs <- variegatus_df[rownames(maxThin),]


# Check how many rows were removed by spatial thinning
# Share this number in Slack
nrow(variegatus_df)
nrow(thinned_occs)

# Visualize which points were removed using ggmap
ggmap(SA_map) +
  geom_point(data = thinned_occs, aes(x = longitude, y = latitude))


# Save the thinned occurrence data as a csv in the data/occurrence_data/ folder
# Name it with your species name and the word "thinned"

#Hanora's
csv_variegatus <- write.csv(thinned_occs, '~/Desktop/Project Repository clone/Data/occurrence_data/thinned_variegatus.csv')

#Loralai's
#csv_variegatus = write.csv(thinned_occs, '~/Desktop/Repository Clone/Data/occurrence_data/thinned_variegatus.csv')


# Create background region ------------------------------------------------

# Refer to lesson_plans/s4_process_env_data/background_region_tutorial.Rmd

# Create a background region for your species (based on the thinned occurrence data!):
## B. variegatus: points buffered by 2 degrees
# function to create a minimum convex polygon
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

mini_convex = mcp(thinned_occs[,3:4])
plot(mini_convex)

#Creating env_stack
#Lor
bioclim_files <- list.files("~/Desktop/wc2/")
bioclim_files
env_stack <- stack(paste0("~/Desktop/wc2/", bioclim_files))

#Han
bioclim_files <- list.files("~/Desktop/wc2.0_2.5m_bio/")
bioclim_files
env_stack <- stack(paste0("~/Desktop/wc2.0_2.5m_bio/", bioclim_files))


# Create cropped raster
env_convex <- crop(env_stack, mini_convex)
# Plot cropped raster
plot(env_convex)

# Create masked raster
mask_thin_varie <- mask(env_convex, mini_convex)

# Plot masked raster
plot(mask_thin_varie)

bg_varie = bbox(as.matrix(thinned_occs[,3:4]))
bg_variegatus = as(extent(bg_varie), "SpatialPolygons")

occs.variegatus = SpatialPoints(variegatus[,3:4])

#Create buffered points background extent
bg.varie.1 = gBuffer(occs.variegatus, width = 2.0)
#Create cropped raster
crop.varie.1 = crop(env_stack, bg.varie.1)
#Plot cropped raster
plot(crop.varie.1)
#create masked raster
mask.varie.1 = mask(crop.varie.1, bg.varie.1)
#Plot masked raster
plot(mask.varie.1)
#Sample 10000 points from MCP
points.varie = randomPoints(mask.varie.1, 10000)
#Convert these points into a dataframe using as.data.frame
final.points.varie = as.data.frame(points.varie)

# Remember to sample background points from your background region
#Done above

# Partition occurrence data -----------------------------------------------

# Refer to lesson_plans/s5_partition_occ_data.Rmd


# Partition your thinned occurrence data:
## if your species has 25 or fewer thinned occurrences, use a jackknife partition
## if your species has >25 thinned occurrences, use a block partition
View(thinned_occs)
thinned_occs<- na.omit(thinned_occs)
group.data <- get.block(thinned_occs[,3:4], points.varie)
 # Look at group.data
  group.data
  occs.grp <- group.data[[1]]
  bg.grp <- group.data[[2]]
# Visualize the partitioned occurrence data on a map
# Share this map in Slack
  ggmap(SA_map) +
    geom_point(data = thinned_occs, aes(x = longitude, y = latitude), color = occs.grp)



# Build Maxent models -----------------------------------------------------

# Refer to lesson_plans/s6_build_eval_niche_model/ENMeval_tutorial.Rmd

# Use regularization multiples from 1 to 5 with a step value of 1
rms = seq(from = 1, to = 5, by = 1)

# Use feature classes "L", "LQ", "H", and "LQH"
fcs <- c("L","LQ","LQH","H")
  
# Run ENMevaluate()
# and unpack results data frame, list of models, and RasterStack of raw predictions
enm <- ENMevaluate(occ = thinned_occs[,3:4], env = mask.varie.1, bg.coords = final.points.varie, RMvalues = rms, fc = fcs, method = "block", clamp = TRUE)
evalTbl <- enm@results
evalMods <- enm@models
evalPreds <- enm@predictions

# Select Maxent model -----------------------------------------------------

# Refer to lesson_plans/s6_build_eval_niche_model/model_selection_tutorial.Rmd
View(evalTbl)
# Sort the results data frame using AUC, OR, and/or AIC
# Select the "best" model according to your criteria
varie.sorted <- evalTbl[order(evalTbl$delta.AICc),]

names(evalMods) <- enm@results$settings
model <- evalMods[["LQH_5"]]

prediction_varie <- maxnet.predictRaster(mod = model, env_convex, type = "cloglog", clamp = TRUE)
plot(prediction_varie)
# Slack the name of the best model and the criteria you used to select it

View(evalTbl)
# Visualize model ---------------------------------------------------------

# Generate the model prediction and plot it
# Share this map in Slack


# Project in space --------------------------------------------------------

# Project the model to the background region you selected and plot the projection
# Share this map in Slack


# Project the model to a bounding box for your species and plot the projection
# Share this map in Slack



