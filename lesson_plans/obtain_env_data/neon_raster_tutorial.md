# `raster` Package Tutorial

We are going to take a brief break from our sloths to learn about the `raster` package in R. Raster data (if you remember from that super exciting online reading) is data in a grid, where each cell has a value representing some variable, like elevation, temperature, precipitation, etc. We are going to use a tutorial from NEON - the National Ecological Observation Network (https://www.neonscience.org/observatory/about).

## Download data

We need to start by downloading the data for the tutorial from NEON: https://www.neonscience.org/primer-raster-data-r. I saved the files you need to a folder in my Google Drive: https://drive.google.com/open?id=1MkKS0s0_kvpiEsPVqOFHDcQpW2MtGh-b, so downloading should be quicker than downloading directly from NEON. The data is too large to store conveniently on GitHub, so save it on your Desktop for easy access. The specific data you'll be working with comes from the San Joaquin Experimental Range (https://www.neonscience.org/field-sites/field-sites-map/SJER), which is a study site in California.

## Start the tutorial!

After downloading the data from that website, you can start the tutorial itself. You're going to be going back and forth from the online tutorial, where you will read about raster, to RStudio, where you can run the actual commands. I've made a script file for you that has the code from the tutorial (so you won't have to worry about lots of copying and pasting). For the most part, if there's a difference between the code on the tutorial and the code in the R script, go with the R script.

### Loading data

Since the data is now on your Desktop, not directly in the same folder as your R project, we have to set our working directory to your Desktop so R knows where to find the files. In the script, I've put in code to do that for my computer, as well as instructions for getting the proper file path for your computer.
