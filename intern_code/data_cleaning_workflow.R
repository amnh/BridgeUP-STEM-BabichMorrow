# Your name + your partner's name
# 11/20/18
# Spatial cleaning workflow code

# FIRST STEP: Rename this file by adding your first name and an underscore to the beginning of the file
# (so if this was my file, I'd call it "cecina_data_cleaning_workflow.R")

# Required packages -------------------------------------------------------

# Load all the packages you need for your analyses
# You can find packages we've used in IntroGPS.Rmd, UFO_code.Rmd,
# spocc_tutorial.Rmd and the R script you wrote using spocc, sloth_cleaning_pt1.Rmd, and sloth_cleaning_pt2.Rmd



# Obtain occurrence data -------------------------------------------------------------

# Download occurrence data from GBIF for your species & convert it to a dataframe
# Look at the spocc_tutorial.Rmd and the R script you wrote using spocc for inspiration
# Check out the help menu for the occ function: we want to change the limit argument to 1300


# Remove rows in the dataframe that have NA values for latitude or longitude
# Use UFO_code.Rmd for inspiration on removing NA values


# Visualize occurrence data -----------------------------------------------

# Use the ggmap package to plot the occurrence points you just got from GBIF on a map



# Subsetting occurrence data ----------------------------------------------

# Refer to sloth_cleaning_pt1.Rmd for inspiration

# Print the 2nd column of your occurrence data


# Print the 3rd row of your occurrence data


# Pick a range of latitude and/or longitude
# create a dataframe containing only occurrence points in that range


# Use ggmap to plot this subset of occurrence points on the map
# (As a bonus, try plotting the original set of all occurrence points
# and then plot the subset in a different color)



# Polygons ----------------------------------------------------------------

# Refer to sloth_cleaning_pt2.Rmd for inspiration

# Import the csv containing the coordinates of the polygon you drew last Thursday


# Make that dataset into a SpatialPolygon and plot that polygon on the map with your occurrence points


# Make your occurrence data into a SpatialPoints object and intersect your polygon with your points


# Plot the original occurrences, the polygon, and the new occurrences all on the same map




