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
| **Week 12** | | |
  | January 3 | <ul><li> Git and goals! </li><li> File path game |                                                               [File path game instructions](https://github.com/amnh/BridgeUP-STEM-BabichMorrow/blob/master/lesson_plans/File_Paths/Path_Game.md) |
| **Week 13** | | |
  | January 8 | <ul><li> Gift exchange! :gift: </li><li> Introduction to rasters </li><li> Start `raster` package tutorial |     [Intro to rasters - slides](https://docs.google.com/presentation/d/1MQMfrr6dFnPqvtxN5eqYqkOdbTS5NkUvMaKpuUI-v9Q/edit?usp=sharing) <br> [`raster` tutorial](https://github.com/amnh/BridgeUP-STEM-BabichMorrow/blob/master/lesson_plans/obtain_env_data/raster_tutorial.Rmd) |
  | January 10 | <ul><li> What is WorldClim? </li><li> WorldClim in R :earth_americas: |                                                   [WorldClim website](http://www.worldclim.org): [Data format](http://www.worldclim.org/formats1) & [Bioclimatic variables](http://www.worldclim.org/bioclim) <br> [WorldClim in R - RMarkdown](https://github.com/amnh/BridgeUP-STEM-BabichMorrow/blob/master/lesson_plans/obtain_env_data/worldclim_inR.Rmd) |
| **Week 14** | | |
  | January 15 | <ul><li> Introduction to machine learning | |
  | January 17 | | |
| **Week 15** | | |
  | January 22 | | |
  | January 24 | | |
| **Week 16** | | |
  | January 29 | | |
  | January 31 | | |
| **Week 17** | | |
  | January 29 | | |
  | January 31 | | |
| **Week 18** | | |
  | February 5 | **No internship session today** | |
  | February 7 | | |
  | February 8 | **Hackathon! :rocket:** | |
  | February 9 | **Hackathon! :sunny:** | |
| **Week 19** | | |
  | February 10 | **Hackathon! :full_moon:** | |
  | February 12 | **No internship session today** | |
  | February 14 <br> <sub>:heart_eyes:Valentine's Day:love_letter:</sub> | | |
| **Mid-Winter Recess** <br> :snowflake: | **February 18-22** | |
| **Week 20** | | |
  | February 26 | Resume Workshop |  |
  | February 28 | HTML/CSS Workshop |  |
| **Week 21** | | |
  | March 5 | | |
  | March 7 | | |
| **Week 22** | | |
  | March 12 | | |
  | March 14 | | |
| **Week 23** | | |
  | March 19 | | |
  | March 21 | | |
| **Week 24** | | |
  | March 26 | | |
  | March 28 | | |
| **Week 25** | | |
  | April 2 | | |
  | April 4 | Presentation Skills Workshop| |


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
  + `git add .` to add all untracked files to your commit
  + Once you've added all the files, `git commit -m "whatever you want your message to be"`
+ Push your changes to your remote copy of the fork: `git push`

Sync your fork:

+ Fetch commits from upstream repository to get any updates: `git fetch upstream`
+ Check out your fork's local `master` branch: `git checkout master`
+ Merge the changes from `upstream/master` into your local `master` branch: `git merge upstream/master`
  + Will need to hit the escape key, then type `:wq` to get out of the text editor for the commit
+ Run `git push` one final time to push the merged changes to your remote fork

### End of Session

Push your local changes:

+ See current status of Git: `git status`
+ If you have modified files, commit your changes
  + `git add .` to add all untracked files to your commit
  + Once you've added all the files, `git commit -m "whatever you want your message to be"`
+ Push your changes to your remote copy of the fork: `git push`


