# `ggplot2` Tutorial Notes

These notes go over the first few videos in the DataCamp ggplot2 tutorial: https://www.datacamp.com/courses/data-visualization-with-ggplot2-1.

## Introduction

### What is data visualization?

"Data viz" is the combination of statistics and design to communicate your scientific results. In the tutorial, the instructor emphasizes that data visualization requires both graphical data analysis - you need to display accurate interpretations of your data - and design principles - you need to make your graphs look good and also communicate effectively.

### Exploratory vs. Explanatory Plots

Plots can have different roles based on what kind of information you want to communicate to a specific audience. Sometimes, that audience can just be yourself: a lot of the plots we've made so far, like the histogram of your destination distances in the Intro to R session, the map of your points in Central Park, or the bargraph of UFO shapes, are really a way for you to visualize the data you have and then come up with questions you want to solve from that data. These plots have all been *exploratory plots* - plots for yourself or a small audience of your colleagues (the rest of the SlothSquad!) to analyze your data graphically. We haven't worried too much about beautifying these graphs, since their primary purpose is to help us come up with other questions moving forward.

As we move forward in the internship towards your winter presentations, you'll start making the second type of plot, *explanatory plots*. Explanatory plots are targeted to an audience like interns from other groups, other scientists, or the general public. This is where you start to make things pretty since these graphs are intended to inform your audience and persuade them that your interpretation of the data is correct.

## Grammar of Graphics

The "gg" in `ggplot2` stands for "grammar of graphics", which basically means the structure or framework you go through when you make a graph. If you like grammar, you can think of the layers in your plots as adjectives and nouns and the aesthetic mappings as grammatical rules for how to assemble that vocabulary. If you don't like grammar or if that analogy makes no sense right now, worry not, no actual grammar skills are necessary to learn `ggplot2`.

There are 7 "grammatical elements" in the package, with the first three being the essentials:

| **Element**  | **Description** |
|--------------|---------------|
| **Data**     | the dataset being plotted |
|**Aesthetics**| the scales onto which we map our data (think the axes) |
|**Geometries**| actual shape of the data in the plot (think point, boxplot, bargraph, etc.) |
|  Facets      | plotting small multiples |
|  Statistics  | representations of our data that aid understanding |
|  Coordinates | the space onto which our data will be plotted |
|  Themes      | all the ink on our graph that doesn't have to do with the data (the background, etc.) |

These grammatical elements become the "layers" in `ggplot2`.

## `ggplot2`

This package was developed by Hadley Wickham (a "famous" RStudio guy) as part of a set of packages called the Tidyverse - you don't really need to know this, but it's interesting trivia.

The package operates by having you provide a set of "layers" that you want to plot. The first layer of any plot is the data. After data comes aesthetics - like color, size, and shape, often determined by some variable in our data. Next are geometries - what kind of graph you want to make from the data. Then facets, which dictates how you want to split up your plot, statistics, which can calculate and add statistical tests, coordinates, which specifies the plot dimensions, and finally themes, which essentially makes the plot pretty (which is not a trivial thing!).
