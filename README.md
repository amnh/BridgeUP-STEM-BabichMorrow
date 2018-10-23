# SlothSquad

## Team Research Questions & Goals

### Research Questions

+ What environmental variables influence the range of the sloths?
+ How do the different species differ in their ranges?
+ How have sloth ranges changed over time and how will they continue to change in the future?

### Goals

+ Read and write R scripts to analyze spatial data
+ Understand the basics of machine learning
+ Understand how ecological concepts relate to programming


## Calendar

| Date   |      Topics      |  Materials |
|----------|-------------|------|
| **Week 1** | | |
  | October 9 |  <ul><li>Join the Sloth Squad! </li><li> R set-up </li><li> Questions for Dr. Blair |                        [R Set-up - slides](https://docs.google.com/presentation/d/1EsC6WLLg2vecp1zUkETEXVK2Ai168oAJrUcz23vlpj8/edit?usp=sharing) <br> [Dr. Blair's website](https://sites.google.com/site/maryeblair/home) <br> [Dr. Blair - Scientist at Work](https://scientistatwork.blogs.nytimes.com/tag/slow-loris/) |
  | October 11 |    <ul><li>Meet Dr. Mary Blair </li><li> Project Overview |                                                                                         [Questions for Dr. Blair](https://docs.google.com/document/d/14YUri2-jk7_R_H8OH7ouzHGdfD1sJqFb7CTERCC7NMs/edit?usp=sharing)<br>[Project Overview - slides](https://docs.google.com/presentation/d/1WHQqnFkMPRanS7SCgBz7Vu6U876s6jPJqvuFz_OkTFU/edit?usp=sharing) |
| **Week 2** | | |
  | October 16 | <ul><li> Digging into R+GitHub :fork_and_knife: </li><li>  Introduction to R |                                 [Forking in GitHub and RStudio](https://github.com/amnh/BridgeUP-STEM-BabichMorrow/blob/master/lesson_plans/GitHub_Fork.md) <br> [Happy Git with R](http://happygitwithr.com/rstudio-git-github.html) <br> [Introduction to R - RMarkdown](https://github.com/amnh/BridgeUP-STEM-BabichMorrow/blob/master/lesson_plans/Introduction_to_R.Rmd) |
  | October 18 | <ul><li> Going outside! - GPS exploration </li><li> Syncing a fork </li><li> Introduction to spatial data in R |                         [GPS collection instructions](https://github.com/amnh/BridgeUP-STEM-BabichMorrow/blob/master/lesson_plans/GPS_CollectData.md) <br> [GPS R Markdown](https://github.com/amnh/BridgeUP-STEM-BabichMorrow/blob/master/lesson_plans/IntroGPS.Rmd) |
| **Week 3** | | |
  | October 23 | <ul><li> Syncing a fork - review </li><li> GPS in R continued |                                                 [GitHub Help: syncing a fork](https://help.github.com/articles/syncing-a-fork/) <br> [GPS R Markdown](https://github.com/amnh/BridgeUP-STEM-BabichMorrow/blob/master/lesson_plans/IntroGPS.Rmd)  |
  | October 25 | <ul><li> Hall of Biodiversity scavenger hunt </li><li> What is GBIF? </li><li> `spocc` package |               [GBIF website](https://www.gbif.org) <br>[`spocc` package tutorial](https://ropensci.org/tutorials/spocc_tutorial/)  |
  |October 30 <br> <sub> :jack_o_lantern: Halloween Eve :chocolate_bar: </sub> | <ul><li> Visualizing spatial data | |

## Daily Git To Do

![alt text|10%](github_diagram1.png)

### Beginning of Session

Push your local changes:

+ Open Terminal and navigate to your folder for the forked repository
  + `pwd`: check current directory
  + `ls`: get a list of files in the current directory
  + `cd`: move to a new directory
+ See current status of Git: `git status`
+ If you have modified files, commit your changes
  + `git add <file name>` to add those files to your commit
  + Once you've added all the files, `git commit -m "whatever you want your message to be"`
+ Push your changes to your remote copy of the fork: `git push`

Sync your fork:

+ Fetch commits from upstream repository to get any updates: `git fetch upstream`
+ Check out your fork's local `master` branch: `git checkout master`
+ Merge the changes from `upstream/master` into your local `master` branch: `git merge upstream/master`

### End of Session

Push your local changes:

+ See current status of Git: `git status`
+ If you have modified files, commit your changes
  + `git add <file name>` to add those files to your commit
  + Once you've added all the files, `git commit -m "whatever you want your message to be"`
+ Push your changes to your remote copy of the fork: `git push`


