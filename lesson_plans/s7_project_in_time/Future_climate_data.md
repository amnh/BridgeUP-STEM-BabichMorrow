# Future Climate Data

First, check out this Youtube video [How Climate Scientists Predict the Future](https://www.youtube.com/watch?v=i9EyFghIt5o) for an overview of how we've used computers over the last 40 years to model climate change.

## Back to WorldClim

We are once again returning to WorldClim to get climate data. Now, instead of getting climate data from the present, we are going to be downloading climate data from the future based on the predictions of the different climate change models. This time, though, we are going to download the data directly from R, instead of using the WorldClim website, so we are going to start by reading about the different kinds of data we could get. Check out the WorldClim webpage for [Future climate data](http://www.worldclim.org/CMIP5v1). Note what terms/acronyms you aren't familiar with.

## Predicting the future

### Global climate models

The first acronym that we need to understand future climate data is GCM, or general circulation model (a.k.a. global climate model). A GCM is a model of the Earth used to simulate the impact of climate change on a global scale. GCMs model processes in the atmosphere, ocean, and land surface using a series of mathematical equations.

To learn more about GCMs, you can check out the following links:
+ [What is a GCM?](http://www.ipcc-data.org/guidelines/pages/gcm_guide.html) - Intergovernmental Panel on Climate Change (IPCC)
+ [Climate Models](https://www.climate.gov/maps-data/primer/climate-models) - National Oceanic and Atmospheric Administration (NOAA)

### Representative concentration pathways

The second acronym, RCP, stands for "representative concentration pathway". RCPs are basically potential future scenarios that climate scientists came up with in 2013. These scenarios are based on the level of greenhouse gases in 2100. Each RCP corresponds a different level of greenhouse gas emission in the future. We could end up at these different levels of emissions based on a range of different climate policies, so each RCP has different assumptions about what will happen to global population, economic growth, energy consumption, etc. between now and 2100. The number after the RCP is the level of "radiative forcing" in each scenario, for example RCP 8.5 has the highest level and RCP 2.6 has the lowest.

#### RCP 2.6

RCP 2.6 is the best-case scenario, where countries have a major change in climate policies across the globe. In this scenario, global emissions peak by 2020 (so next year) and decline to zero by 2080. In this scenario, fossil fuel use continues but is offset by capturing and storing carbon dioxide and deforestation continues at current rates.

#### RCP 4.5

In this more moderate scenario, emissions peak around 2050 and then decline rapidly until 2080, when they stabilize at half of the level of 2000. RCP 4.5 also assumes that reforestation initiatives occur, replacing vegetation that has been lost.

#### RCP 6

In RCP 6, emissions double by 2060 and then fall rapidly, but emissions still remain much higher than they are now. Remember, that even when emission rates go down, the concentration of carbon dioxide in the atmosphere will continue to increase since CO2 accumulates in the atmosphere and remains there.

#### RCP 8.5

RCP 8.5 is the worst-case scenario, where emissions continue to increase throughout the century and energy consumption also increases. Population increases to 12 billion by the year 2100 and deforestation continues at its current rate.

To learn more about RCPs, check out these links:
+ [The Beginner's Guide to Representative Concentration Pathways](https://skepticalscience.com/rcp.php?t=1) - Skeptical Science
+ [What on earth is an RCP?](https://medium.com/@davidfurphy/what-on-earth-is-an-rcp-bbb206ddee26) - article by David Furphy

### GCM + RCP

Once a particular GCM has been set up, it is tested by running the model back in time from the present and comparing the results to the observed climate in the past. If it performs well in these tests, it can be turned towards the future. This is where the RCP comes in: the GCM takes into account the scenario in the RCP and predicts how that will affect the global climate based on the GCM model.

Not all of the GCMs have predictions for all of the RCP scenarios. WorldClim has a helpful table to see what datasets are available: http://www.worldclim.org/cmip5_2.5m. So, for example, the GCM ACCESS1-0 has predictions for the scenarios RCP 4.5 and RCP 8.5, but it hasn't been run for RCP 2.6 and RCP 6.
