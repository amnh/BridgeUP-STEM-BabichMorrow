# Projecting backwards in time

Now that you have a model of sloth habitat in the present and the future, it's time to see how sloth habitat might have looked in the past. The process of projecting the sloth habitat backward in time is very similar to the process of projecting forward: the only difference is what environmental data you provide.

## Downloading environmental data

When you projected forwards, you were able to use the `getData()` function from the raster package to download environmental data for a given GCM, RCP, and year. Unfortunately, the `getData()` function does not allow us to download climate data from the past directly into R, so we need to download it from the WorldClim website. This is the same process we used to download our original WorldClim data for the present, so it should be somewhat familiar.

To download past climate data, you need to go to [this page](http://www.worldclim.org/paleo-climate1). There you will see download links for data from the mid-Holocene and Last Glacial Maximum for a variety of GCMs and resolutions. We want to stick with the 2.5 minute resolution, in order to match the resolution of our present-day climate data, and the bioclimatic variables, which are the links indicated with "bi". There are 3 potential sets of data we can use for these projections, so you can look at the second table in [this Markdown](https://github.com/amnh/BridgeUP-STEM-BabichMorrow/blob/master/lesson_plans/s7_project_in_time/Model_projections.md) to see what dataset(s) to download.

After you download the data, move it to your Desktop or somewhere else you can locate it easily. Next, you will use `list.files()` to get a list of the files in the folder of data you downloaded and `stack()` to stack all of the environmental layers. Refer to `lesson_plans/s3_obtain_env_data/worldclim_inR.Rmd` to see how you did this with the present-day environmental data.

```
files <- list.files()
pastEnv <- stack()
```
Next, you need to crop the past environmental data to the bounding box for your species, following the same procedure you used for the current and future environmental data:

```
pastEnv_crop <-
```

Finally, you can use `maxnet.predictRaster()` with your Maxent model and the cropped past environmental data to project your model into the past (this code will look very similar to what you wrote to project to the current and future environmental data).

Time permitting, you can repeat this process for three different datasets (see the [second table](https://github.com/amnh/BridgeUP-STEM-BabichMorrow/blob/master/lesson_plans/s7_project_in_time/Model_projections.md) to compare the predictions for different GCMs and mid-Holocene vs. Last Glacial Maximum.
