# Maxent Tutorial

This tutorial has been adapted from [this Maxent tutorial](https://biodiversityinformatics.amnh.org/open_source/maxent/Maxent_tutorial2017.pdf) by Steven J. Phillips. I've pulled the parts of this tutorial I want to go over into this document. For further reading/exploration, take a look at the original tutorial, particularly if any of the sections here don't make sense.

## Getting started

### Downloading

Start off by downloading the Maxent software from [this link](https://biodiversityinformatics.amnh.org/open_source/maxent/).

### Firing up

You can open Maxent on your Mac by opening the maxent.jar file. You will see the following screen:
![](maxent_screen1.png)

For this tutorial, you are going to perform Maxent on *Bradypus torquatus*. To perform a run, you need to supply a file containing presence localities, a directory containing environmental variables, and an output directory. Occurrence data has been provided in the `data/occurrence_data` folder (`torquatus.csv`) -- browse to that file location under the "Samples" heading. The environmental variables are in the `data/env_layers` folder -- browse to that file location under "Environmental Layers". Finally, I made a blank output folder for you in `intern_code/maxent_tutorial_outputs`, so browse to that location for "Output directory" (at the bottom).

For the occurrence data, the .csv file has three columns: `species`, `longitude`, and `latitude`: the "x" coordinate (longitude) should come before the "y" coordinate (latitude). You can have multiple species in the same samples file, but the one you are using today just includes *B. torquatus*. You can also use coordinate systems other than latitude and longitude as long as the samples and environmental layers use the same coordinate system. The program automatically removes duplicate records -- you can change this by clicking on "Settings" and deselecting "Remove duplicate presence records".

For the environmental data, we are using a number of ascii raster grids downloaded from [here](https://biodiversityinformatics.amnh.org/open_source/maxent/). The grids all need to have the same geographic bounds and cell size. One of the layers we are using, "ecoreg", is a categorical variable describing potential vegetation classes. You need to click on the menu next to "ecoreg" and change it from "Continuous" to "Categorical".

The different continuous environmental layers contain the following data:

+ cld6190_ann : cloud cover, annual
+ dtr6190_ann : diurnal temperature range, annual
+ frs6190_ann : frost frequency, annual
+ pre6190_ann : precipitation, annual
+ pre6190_I1 : precipitation, January
+ pre6190_I4 : precipitation, April
+ pre6190_I7 : precipitation, July
+ pre6190_I10 : precipitation, October
+ tmn6190_ann : mean temperature, annual
+ tmp6190_ann : minimum temperature, annual
+ tmx6190_ann : maximum temperature, annual
+ vap6190_ann : vapour pressure, annual

## Doing a run

Press the "Run" button. You'll see a progress bar telling you what step is going on. The "Gain" number you'll see is a statistical measurement of how well the model fits: it will start at 0 and increase asymptotically during the run. You don't need to worry too much about what gain means, but essentially at the end of the run, the gain will tell you how closely the model is concentrated around the presence samples. For example, if gain ends up at 2, the average likelihood of your presence occurrences is ![](http://www.sciweavers.org/tex2img.php?eq=e%5E2%20%20%5Capprox%207.4&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=0) times higher than a random background pixel.

After the run is complete, you will end up with multiple output files in `intern_code/maxent_tutorial_outputs`. The most important of these is an html file called `bradypus_torquatus.html`.

### Looking at a prediction

In the html file, scroll down to the heading "Pictures of the model". You can click on the image to make it larger. This map shows the predicted probability that conditions are suitable. You should see a narrow region of suitability predicted along the coast since *B. torquatus* is restricted to living in the Atlantic Forest of Brazil.

## Statistics

Now click on "Settings" and change "Random test percentage" to 25. Press "Run" again (you might have to select something like "Redo all" to make new output files). This modification tells the program to randomly set aside 25% of the sample records for testing (like we did for machine learning with the iris and sloth skull datasets).

The first plot in the html file shows the omission rates and predicted area based on the cumulative threshold of the model (thresholding out all regions of the model below a certain value). Omission rate is the percentage of points (either your training examples or the 25% of the data you set aside for testing) that are left out when the model is thresholded.

The second figure shows the receiver operating curve. You don't need to worry too much about what this is, but focus on the AUC (area under curve) values for the training and test data. AUC is a measurement of how well the model fits the data -- closer to 1 is better. The black line for "Random Prediction" shows what the AUC would be if the model was random (correct 50% of the time)--you want the red and blue lines to be above that black line, otherwise the model is no better than random.

After this plot comes a table of thresholds, predicted area, omission rates, and p-values. Once again, don't get too worried about the details here. Just note that, as you move down the table, the thresholds increase, which decreases the fractional predicted area. As that predicted area goes down, occurrences in the training and test sets start getting left out of the model, so omission rate increases.

## How does the prediction depend on the variables?

Now we can start looking at the answers to some ecological questions. Look at the first set of response curves. These show the values of the model predictions over the range of each environmental variable when the values of all the other environmental variables are held at their average value. These plots can be misleading when environmental variables are highly correlated. For example, we have values for monthly precipitation as well as annual precipitation, so it doesn't make a lot of sense to vary annual precipitation while keeping montly precipitation constant.

The second set of response curves helps with this problem by showing models made only using each environmental variable individually. You can see what values of each environmental layer correspond to areas of habitat that the model designates as highly suitable for the sloths.

## Which variables matter most?

Now we can look at the "Analysis of variable contributions" section to see which of these variables have the biggest contribution to the model. Once again, since some of our environmental variables are highly correlated, don't read too much about the specific ordering of the variables in the table. For example, if precipitation in a given month has much higher contribution than annual precipitation, we can't conclude that precipitation in only that month is what matters most to the sloths. If we can see that precipitation in general has much higher contribution than temperature, however, we can draw ecological conclusions that precipitation may matter more in determining sloth habitat than temperature does.

We can also look at the jackknife tests to see the impact of each variable. To make these plots, the program excluded each variable individually and ran the model with the remaining variables. Then it created models using each variable in isolation. These plots compare those two kinds of models to the model made with all variables (shown in red). In the three graphs, we can see comparisons of these types of models and their effect on gain in the training data, gain in the test data, and finally AUC.

## Regularization

In machine learning, "regularization" refers to a way to prevent overfitting of the model. Smaller values of the regularization multiplier (smaller than 1.0) will result in the model being more closely fit to the given presence data. This can result in overfitting, where the model won't generalize to new occurrence data. Larger regularization multipliers, however, will give more spread out predictions.

Try doing a run of the model with a few different regularization values, either higher or lower than 1.0. You can change this value by clicking "Settings" and changing the regularization multiplier. How do they affect the model?

## Projection

Now we are going to use Maxent to make a simple prediction of how climate change might affect the range of *B. torquatus*. The environmental data in the `data/env_hotlayers` folder contains the same environmental data as before with two modifications: the annual average temperature variable has been increased to represent a 3°C increase over the entire range, and the maximum temperature variable has been increased to represent a 4°C increase. Browse to the `env_hotlayers` folder next to "Projection layers directory/file" and run the model again.

Now when you look at the html file, you can see the projected model below the original model. How has the suitable region changed under this climate change model?

You can also see areas on the map with environmental variables outside the original range of values from the original model.

## Further reading

If you finish the rest of the tutorial and have time to explore Maxent a little more, check out the following resources.

### Output formats

Read over the output formats section of the [Maxent tutorial](https://biodiversityinformatics.amnh.org/open_source/maxent/Maxent_tutorial2017.pdf) (page 7). The differences between output formats is beyond what we are going to discuss in depth, but it is good to know the differences. We will be using the cloglog output for our models.

### ROC & AUC

For more information about the ROC curve and its relationship to AUC, check out [this article](https://www.theanalysisfactor.com/what-is-an-roc-curve/). Although it is not crucial that you understand all the math underlying AUC, it is an important number that we will use to compare our models.

### Feature types

Read over the feature types section of the tutorial (page 19). Play around with selecting different feature types for the model. We will go over these in slightly more detail later, but for now just notice the difference between the different feature classes.

### Help menu

If you have any lingering questions/curiosity, look over the "Help" menu!
