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
variegatus = read.csv("~/Desktop/Repository Clone/Data/occurrence_data/variegatus.csv")

#Yamile
variegatus = read.csv("/Users/student/Desktop/BridgeUP-STEM-BabichMorrow2/Data/occurrence_data/variegatus.csv")

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

thinned_output <- thin(loc.data = variegatus_df , lat.col = "latitude", long.col = "longitude", spec.col = "name", thin.par = 40, reps = 100, locs.thinned.list.return = TRUE, write.files = FALSE)
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

#Creating env_stack
#Lor
bioclim_files <- list.files("~/Desktop/wc2/")
bioclim_files
env_stack <- stack(paste0("~/Desktop/wc2/", bioclim_files))

#Han
bioclim_files <- list.files("~/Desktop/wc2.0_2.5m_bio/")
bioclim_files
env_stack <- stack(paste0("~/Desktop/wc2.0_2.5m_bio/", bioclim_files))


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

#Create cropped raster
# crop.varie.bbox = crop(env_stack, bg_variegatus)
# mask.varie.bbox = mask(crop.varie.bbox, bg_variegatus)
# plot(mask.varie.bbox)
# Remember to sample background points from your background region
#Done above

# Partition occurrence data -----------------------------------------------

# Refer to lesson_plans/s5_partition_occ_data.Rmd


# Partition your thinned occurrence data:
## if your species has 25 or fewer thinned occurrences, use a jackknife partition
## if your species has >25 thinned occurrences, use a block partition
View(thinned_occs)
#thinned_occs<- na.omit(thinned_occs)
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

# Save the object you create using ENMevaluate using saveRDS()
# Name it with the species name and your initials
# Upload it to GitHub
saveRDS(enm, file = "LFvariegatus.rds")
enm = readRDS("LFvariegatus.rds")
# Select Maxent model -----------------------------------------------------

# Refer to lesson_plans/s6_build_eval_niche_model/model_selection_tutorial.Rmd
View(evalTbl)
# Sort the results data frame using AUC, OR, and/or AIC
# Select the "best" model according to your criteria
varie.sorted <- evalTbl[order(evalTbl$delta.AICc),]

names(evalMods) <- enm@results$settings
model <- evalMods[["LQH_5"]]
saveRDS(enm, file = "YSvariegatus.RDS")
enm <- readRDS("YSVariegatus.RDS")

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
prediction_varie <- maxnet.predictRaster(mod = model, mask.varie.bbox, type = "cloglog", clamp = TRUE)

# Project the model to a bounding box for your species and plot the projection
# Share this map in Slack
plot(prediction_varie)

# Project forward in time --------------------------------------------------------

# Find the resolution of your masked environmental data
envsRes <- res(mask_thin_varie)[1]


# Set two different GCMs: HadGEM2-ES and CCSM4 (we are going to project to 2 different GCMs to compare the results)
GCM_he <- "HE"
GCM_cc <- "CC"

# Set three different RCPs: 2.6, 6, and 8.5
RCP_26 <- 2.6
RCP_60 = 6
RCP_85 = 8.5

# Set the year to be 2070
time_period <- 70


# Download the data for the 6 different combinations of GCM and RCP (all at the year 2070)
#HadGEM2-ES
projTimeEnvs_26 <- getData('CMIP5', var = "bio", res = 2.5, rcp = 26, model = GCM_he  , year = time_period)

projTimeEnvs_60 <- getData('CMIP5', var = "bio", res = 2.5, rcp = 60, model = GCM_he  , year = time_period)

projTimeEnvs_85 <- getData('CMIP5', var = "bio", res = 2.5, rcp = 85, model = GCM_he  , year = time_period)

#CCSM4
projTimeEnvs_26_cc <- getData('CMIP5', var = "bio", res = 2.5, rcp = 26, model = GCM_cc  , year = time_period)

projTimeEnvs_60_cc <- getData('CMIP5', var = "bio", res = 2.5, rcp = 60, model = GCM_cc  , year = time_period)

projTimeEnvs_85_cc <- getData('CMIP5', var = "bio", res = 2.5, rcp = 85, model = GCM_cc  , year = time_period)

# Set the names of your environmental data
#HadGEM2-ES
names(projTimeEnvs_26) <- c(paste0("wc2.0_bio_2.5m_0",1:9) , paste0("wc2.0_bio_2.5m_", 10:19))

names(projTimeEnvs_60) <- c(paste0("wc2.0_bio_2.5m_0",1:9) , paste0("wc2.0_bio_2.5m_", 10:19))

names(projTimeEnvs_85) <- c(paste0("wc2.0_bio_2.5m_0",1:9) , paste0("wc2.0_bio_2.5m_", 10:19))

#CCSM4
names(projTimeEnvs_26_cc) <- c(paste0("wc2.0_bio_2.5m_0",1:9) , paste0("wc2.0_bio_2.5m_", 10:19))

names(projTimeEnvs_60_cc) <- c(paste0("wc2.0_bio_2.5m_0",1:9) , paste0("wc2.0_bio_2.5m_", 10:19))

names(projTimeEnvs_85_cc) <- c(paste0("wc2.0_bio_2.5m_0",1:9) , paste0("wc2.0_bio_2.5m_", 10:19))

# Crop and mask the environmental data to the bounding box for your species
new_bbox = bbox(as.matrix(variegatus[,3:4]))
new_bbox = as(extent(new_bbox), "SpatialPolygons")

#HadGEM2-ES
var_data_26 = crop(projTimeEnvs_26, new_bbox)
var_data_60 = crop(projTimeEnvs_60, new_bbox)
var_data_85 = crop(projTimeEnvs_85, new_bbox)

var_data_26 = mask(var_data_26, new_bbox)
var_data_60 = mask(var_data_60, new_bbox)
var_data_85 = mask(var_data_85, new_bbox)

#CCSM4
var_data_26_cc = crop(projTimeEnvs_26_cc, new_bbox)
var_data_60_cc = crop(projTimeEnvs_60_cc, new_bbox)
var_data_85_cc = crop(projTimeEnvs_85_cc, new_bbox)

var_data_26_cc = mask(var_data_26_cc, new_bbox)
var_data_60_cc = mask(var_data_60_cc, new_bbox)
var_data_85_cc = mask(var_data_85_cc, new_bbox)

# Project the model into the future -- you will end up with 6 different projected models
# Plot the projected models
#HadGEM2-ES
future_var_26 = maxnet.predictRaster(mod = model, var_data_26, type = "cloglog", clamp = TRUE)
future_var_60 = maxnet.predictRaster(mod = model, var_data_60, type = "cloglog", clamp = TRUE)
future_var_85 = maxnet.predictRaster(mod = model, var_data_85, type = "cloglog", clamp = TRUE)

plot(future_var_26)
plot(future_var_60)
plot(future_var_85)

#CCSM4
future_var_26_cc = maxnet.predictRaster(mod = model, var_data_26_cc, type = "cloglog", clamp = TRUE)
future_var_60_cc = maxnet.predictRaster(mod = model, var_data_60_cc, type = "cloglog", clamp = TRUE)
future_var_85_cc = maxnet.predictRaster(mod = model, var_data_85_cc, type = "cloglog", clamp = TRUE)

plot(future_var_26_cc)
plot(future_var_60_cc)
plot(future_var_85_cc)

# Response curves --------------------------------------------------------

# Check which variables in the model have non-zero coefficients
names(model$betas)

# Plot response curves
library(ENMeval)

response.plot(mod = model, v = "wc2.0_bio_2.5m_02", type = "cloglog")
# Mean Diurnal Range (Mean of monthly(max temp - min temp)) 
response.plot(mod = model, v = "wc2.0_bio_2.5m_12", type = "cloglog")
# Annual Precipitation
response.plot(mod = model, v = "wc2.0_bio_2.5m_14", type = "cloglog")
# Precipitation of Driest Month
response.plot(mod = model, v = "wc2.0_bio_2.5m_17", type = "cloglog")
# Preciptation of Driest Quarter
response.plot(mod = model, v = "wc2.0_bio_2.5m_18", type = "cloglog")
# Preciptation of Warmest Quarter
response.plot(mod = model, v = "wc2.0_bio_2.5m_06", type = "cloglog")
# Min Temperatue of Coldest Month
response.plot(mod = model, v = "wc2.0_bio_2.5m_09", type = "cloglog")
# Mean Temperature of Driest Quarter


# Projecting Backwards in Time
predict_cc <- list.files("~/Desktop/cclgmbi_2-5m/")
predict_he <- list.files("~/Desktop/hemidbi_2-5m/")

pastEnv_cc <- stack(paste0("~/Desktop/cclgmbi_2-5m/", predict_cc))
pastEnv_he <- stack(paste0("~/Desktop/hemidbi_2-5m/", predict_he))

past_cc = crop(pastEnv_cc, new_bbox)
past_he = crop(pastEnv_he, new_bbox)

#names(past_cc) = gsub("cclgmbi", "wc2.0_bio_2.5m_", names(past_cc))
#names(past_he) = gsub("hemidbi", "wc2.0_bio_2.5m_", names(past_he))

names(past_he) = c(paste0("wc2.0_bio_2.5m_0",1), paste0("wc2.0_bio_2.5m_",10:19), paste0("wc2.0_bio_2.5m_0",2:9))
names(past_cc) = c(paste0("wc2.0_bio_2.5m_0",1), paste0("wc2.0_bio_2.5m_",10:19), paste0("wc2.0_bio_2.5m_0",2:9))

past_plot_cc = maxnet.predictRaster(mod = model, past_cc, type = "cloglog", clamp = TRUE)
past_plot_he = maxnet.predictRaster(mod = model, past_he, type = "cloglog", clamp = TRUE)

plot(past_plot_cc)
plot(past_plot_he)
