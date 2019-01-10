Hello machine learning!
================
Cecina Babich Morrow

Material for this lesson was adapted from <https://machinelearningmastery.com/machine-learning-in-r-step-by-step/>.

Iris data
---------

To get a feel for machine learning in R, we are going to start with a project on a famous dataset in R: the iris dataset. The iris dataset was introduced by a British biologist named Ronald Fisher in 1938, but the data was actually collected by Edgar Anderson. The dataset consists as 50 samples from each of 3 species of iris: *Iris setosa*, *Iris virginica*, and *Iris versicolor*. For each flower, Anderson measured the length and width of the sepals and petals.

R allows us to look at the iris data directly, without having to download it from online:

``` r
data(iris)
```

**Try it yourself:** View the iris dataset.

### Exploratory data analysis

As we learned with our sloth data, it's useful to spend some time plotting your data and looking for patterns (otherwise you could end up with sloths in the ocean). This process of exploratory data analysis is important for all data projects. In this machine learning project, we are working with numerical data that is not spatial, so you'll have the opportunity to do some exploratory data analysis that doesn't involve maps. This is also your chance to work with some of the statistics that R can do.

**Try it yourself:** This is your chance to play with R! See if you can figure out how to complete the following challenges:

-   Make a histogram
-   Find the mean sepal length of all the species
-   Find the mean petal length for each species separately
-   Find a standard deviation
-   Make a boxplot of one of the variables. See if you can create separate boxes for each of the species
-   Make a scatterplot of two of the variables, for example petal width on the x-axis and petal length on the y-axis

Some functions you might want to use: + `hist()` + `mean()` + `favstats()` (you need the `mosaic` package for this function, but it's super useful) + `boxplot()` + `plot()` (put your x variable first and your y variable second)

`caret` package
---------------

For this exercise, we are going to be using the `caret` package in R, which allows you to run hundreds of different machine learning algorithms, visualize the results, and compare models.

**Try it yourself:** Install and load the `caret` package:

Machine learning time
---------------------

### Create a
