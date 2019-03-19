# Your sloth species name
# Maxent modeling code

# Your name + your partner's name
# Date

# FIRST STEP: Rename this file by adding your species name and an underscore to the beginning of the file
# (for example, "tridactylus_maxent.R")


# Required packages -------------------------------------------------------

# Load all the packages you need for the analyses
# You need 1) the package for spatial thinning, 2) the package for mapping,
# 3) the packages from background_region_tutorial.Rmd,
# 4) the package used in partitioning occurrences


# Occurrence data ---------------------------------------------------------

# Import the dataset for your species from data/occurrence_data



# Visualize occurrence data -----------------------------------------------

# Use the ggmap package to plot the occurrence points for your species on a map
# Share this map in Slack



# Spatial thinning --------------------------------------------------------

# Refer to your code from intern_code/occ_data_cleaning.R
# (and also lesson_plans/s2_process_occ_data/sloth_cleaning_pt3.Rmd)

# Thin your occurrence data to a distance of 40 km


# Check how many rows were removed by spatial thinning
# Share this number in Slack


# Visualize which points were removed using ggmap


# Create background region ------------------------------------------------

# Refer to lesson_plans/s4_process_env_data/background_region_tutorial.Rmd

# Create a background region for your species (based on the thinned occurrence data!):
## B. variegatus: points buffered by 2 degrees
## B. tridactylus: MCP buffered by 1 degree
## B. torquatus: points buffered by 1 degree


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



