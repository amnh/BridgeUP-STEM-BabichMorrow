# Projecting backwards in time

Now that you have a model of sloth habitat in the present and the future, it's time to see how sloth habitat might have looked in the past. The process of projecting the sloth habitat backward in time is very similar to the process of projecting forward: the only difference is what environmental data you provide.

## Downloading environmental data

When you projected forwards, you were able to use the `getData()` function from the raster package to download environmental data for a given GCM, RCP, and year. Unfortunately, the `getData()` function does not allow us to download climate data from the past directly into R, so we need to download it from the WorldClim website. This is the same process we used to download our original WorldClim data for the present, so it should be somewhat familiar.

To download past climate data, you need to go to [this page](http://www.worldclim.org/paleo-climate1). There you will see download links for data from the mid-Holocene and Last Glacial Maximum for a variety of GCMs and resolutions. We want to stick with the 2.5 minute resolution in order to match the resolution of our present-day climate data. We also want to download the bioclimatic variables, which are the links indicated with "bi".
