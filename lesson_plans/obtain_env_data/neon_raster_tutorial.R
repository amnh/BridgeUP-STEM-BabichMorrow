# Load required packages
library(raster)
library(sp)
library(rgdal)

# Load the Data -----------------------------------------------------------


# Set working directory to your Desktop
# You have to modify this with the path to the Desktop on your computer!
# Open Terminal
# Open Finder and navigate to your Desktop
# Drag the folder "NEON-DS-Field-Site-Spatial-Data" to your Terminal -- a file path should appear
# Copy the part of the file path up to the word Desktop and paste it below:
setwd("/Users/hellenfellows/Desktop")

# Load raster in an R object called 'DEM'
# This raster contains elevation data
DEM <- raster("NEON-DS-Field-Site-Spatial-Data/SJER/DigitalTerrainModel/SJER2013_DTM.tif")

# View raster attributes 
DEM

# Spatial Extent ----------------------------------------------------------


# View the extent of the raster
DEM@extent

# create a raster from the matrix - a "blank" raster of 4x4
myRaster1 <- raster(nrow=4, ncol=4)

# assign "data" to raster: 1 to n based on the number of cells in the raster
myRaster1[]<- 1:ncell(myRaster1)

# view attributes of the raster
myRaster1

# is the CRS (Coordinate Reference System) defined?
myRaster1@crs

# what is the raster extent?
myRaster1@extent

# plot raster
plot(myRaster1, main="Raster with 16 pixels")

## HIGHER RESOLUTION
# Create 32 pixel raster
myRaster2 <- raster(nrow=8, ncol=8)

# resample 16 pix raster with 32 pix raster
# use bilinear interpolation with our numeric data
myRaster2 <- resample(myRaster1, myRaster2, method='bilinear')

# notice new dimensions, resolution, & min/max 
myRaster2

# plot 
plot(myRaster2, main="Raster with 32 pixels")

## LOWER RESOLUTION
# Create 4 pixel raster
myRaster3 <- raster(nrow=2, ncol=2)

# resample 16 pix raster with 4 pix raster
# use bilinear interpolation with our numeric data
myRaster3 <- resample(myRaster1, myRaster3, method='bilinear')

# notice new dimensions, resolution, & min/max 
myRaster3

#plot
plot(myRaster3, main="Raster with 4 pixels")

## SINGLE PIXEL RASTER
myRaster4 <- raster(nrow=1, ncol=1)
myRaster4 <- resample(myRaster1, myRaster4, method='bilinear')
myRaster4
plot(myRaster4, main="Raster with 1 pixel")

# change graphical parameter to 2x2 grid
par(mfrow=c(2,2))

# arrange plots in order you wish to see them
plot(myRaster2, main="Raster with 32 pixels")
plot(myRaster1, main="Raster with 16 pixels")
plot(myRaster3, main="Raster with 4 pixels")
plot(myRaster4, main="Raster with 2 pixels")

# change graphical parameter back to 1x1 
par(mfrow=c(1,1))


# CRS proj4 Strings -------------------------------------------------------

# create an object with all ESPG codes
epsg = make_EPSG()
View(epsg)

# create 10x20 matrix with values 1-8. 
newMatrix  <- (matrix(1:8, nrow = 10, ncol = 20))

# convert to raster
rasterNoProj <- raster(newMatrix)
rasterNoProj

## Define the xmin and ymin (the lower left hand corner of the raster)

# 1. define xMin & yMin objects.
xMin = 254570
yMin = 4107302

# 2. grab the cols and rows for the raster using @ncols and @nrows
rasterNoProj@ncols
rasterNoProj@nrows

# 3. raster resolution
res <- 1.0

# 4. add the numbers of cols and rows to the x,y corner location, 
# result = we get the bounds of our raster extent. 
xMax <- xMin + (rasterNoProj@ncols * res)
yMax <- yMin + (rasterNoProj@nrows * res)

# 5.create a raster extent class
rasExt <- extent(xMin,xMax,yMin,yMax)
rasExt

# 6. apply the extent to our raster
rasterNoProj@extent <- rasExt

# Did it work? 
rasterNoProj
# or view extent only
rasterNoProj@extent

# plot new raster
plot(rasterNoProj, main="Raster in UTM coordinates, 1 m resolution")

# Define Projection of a Raster -------------------------------------------

# view CRS from raster of interest
rasterNoProj@crs

# view the CRS of our DEM object.
DEM@crs

# define the CRS using a CRS of another raster
rasterNoProj@crs <- DEM@crs

# look at the attributes
rasterNoProj

# view just the crs
rasterNoProj@crs

# Reprojecting Data -------------------------------------------------------

# reproject raster data from UTM to CRS of Lat/Long WGS84
reprojectedData1 <- projectRaster(rasterNoProj, 
                                  crs="+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs ")

# note that the extent has been adjusted to account for the NEW crs
reprojectedData1@crs

reprojectedData1@extent

# note the range of values in the output data
reprojectedData1

# use nearest neighbor interpolation method to ensure that the values stay the same
reprojectedData2 <- projectRaster(rasterNoProj, 
                                  crs="+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs ", 
                                  method = "ngb")

# note that the min and max values have now been forced to stay within the same range.
reprojectedData2


# Work with Rasters in R --------------------------------------------------

# calculate and save the min and max values of the raster to the raster object
DEM <- setMinMax(DEM)

# view raster attributes
DEM

#Get min and max cell values from raster
#NOTE: this code may fail if the raster is too large
cellStats(DEM, min)

cellStats(DEM, max)

cellStats(DEM, range)

#view coordinate reference system
DEM@crs

# view raster extent
DEM@extent

# the distribution of values in the raster
hist(DEM, main="Distribution of elevation values", 
     col= "purple", 
     maxpixels=22000000)

# plot the raster
# note that this raster represents a small region of the NEON SJER field site
plot(DEM, 
     main="Digital Elevation Model, SJER") # add title with main

# create a plot of our raster
image(DEM)

# specify the range of values that you want to plot in the DEM
# just plot pixels between 250 and 300 m in elevation
image(DEM, zlim=c(250,300))

# we can specify the colors too
col <- terrain.colors(5)
image(DEM, zlim=c(250,375), main="Digital Elevation Model (DEM)", col=col)

# add a color map with 5 colors
col=terrain.colors(5)

# add breaks to the colormap (6 breaks = 5 segments)
brk <- c(250, 300, 350, 400, 450, 500)

plot(DEM, col=col, breaks=brk, main="DEM with more breaks")

# First, expand right side of clipping rectangle to make room for the legend
# turn xpd off
par(xpd = FALSE, mar=c(5.1, 4.1, 4.1, 4.5))

# Second, plot w/ no legend
plot(DEM, col=col, breaks=brk, main="DEM with a Custom (but flipped) Legend", legend = FALSE)

# Third, turn xpd back on to force the legend to fit next to the plot.
par(xpd = TRUE)

# Fourth, add a legend - & make it appear outside of the plot
legend(par()$usr[2], 4110600,
       legend = c("lowest", "a bit higher", "middle ground", "higher yet", "highest"), 
       fill = col)

# Expand right side of clipping rect to make room for the legend
par(xpd = FALSE,mar=c(5.1, 4.1, 4.1, 4.5))
#DEM with a custom legend
plot(DEM, col=col, breaks=brk, main="DEM with a Custom Legend",legend = FALSE)
#turn xpd back on to force the legend to fit next to the plot.
par(xpd = TRUE)
#add a legend - but make it appear outside of the plot
legend( par()$usr[2], 4110600,
        legend = c("Highest", "Higher yet", "Middle","A bit higher", "Lowest"), 
        fill = rev(col))

#add a color map with 4 colors
col=terrain.colors(4)
#add breaks to the colormap (6 breaks = 5 segments)
brk <- c(200, 300, 350, 400,500)
plot(DEM, col=col, breaks=brk, main="DEM with fewer breaks")

# Basic Raster Math -------------------------------------------------------


#multiple each pixel in the raster by 2
DEM2 <- DEM * 2

DEM2

#plot the new DEM
plot(DEM2, main="DEM with all values doubled")


# Cropping Rasters in R ---------------------------------------------------

#plot the DEM
plot(DEM)

#Define the extent of the crop by clicking on the plot
cropbox1 <- drawExtent()

#crop the raster, then plot the new cropped raster
DEMcrop1 <- crop(DEM, cropbox1)
#plot the cropped extent
plot(DEMcrop1)

#define the crop extent
cropbox2 <-c(255077.3,257158.6,4109614,4110934)
#crop the raster
DEMcrop2 <- crop(DEM, cropbox2)
#plot cropped DEM
plot(DEMcrop2)

