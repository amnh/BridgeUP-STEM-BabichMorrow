# Forking in GitHub + RStudio

## What is a fork?

Read the Data School tutorial [Simple guide to forks in GitHub and Git](https://www.dataschool.io/simple-guide-to-forks-in-github-and-git/) -- make sure to check out the diagrams.

## Making a fork

Now that we have the conceptual basis for forks, we can actually make one. In order to get a copy of this repository (BridgeUP-STEM-BabichMorrow), go to the repository ([https://github.com/amnh/BridgeUP-STEM-BabichMorrow](https://github.com/amnh/BridgeUP-STEM-BabichMorrow)) and select fork in the top right. Now you have a fork of this repository!

## Update and commit using GitHub

Scroll down to the `README.md` file and click on the pen icon on the right. Now that you have a fork of this repo, you can edit files for your own personal use (while still being able to access all the team resources). Under the section for Team Research Questions & Goals, add a section by typing the following: `## Personal Research Questions & Goals`. Add your own questions and goals -- don't worry about them being perfect, you can edit these anytime throughout the project whenever you come up with something new.

When you're done, scroll down to where you see **Commit changes** and type something descriptive in the first box, e.g. "Added personal goals". Then click the green "Commit changes" button. You should see the changes pop up in your version of the README.md file now. Notice that the original version of the repository is not changed.

## Cloning the fork

This fork only exists on GitHub right now, so you need to clone it to your computer. Typically, you could use the Clone or Download button in GitHub and then use GitHub Desktop. We are going to use RStudio to clone the repository instead since we want to be able to work with this repo in R.

[Happy Git with R](happygitwithr.com) is a handy online resource with instructions for how to do just about anything regarding using Git/GitHub with R/RStudio. We've already installed R, set up GitHub accounts, and created forks of the repository so we are starting with [section 13.3](http://happygitwithr.com/rstudio-git-github.html#clone-the-new-github-repository-to-your-computer-via-rstudio) to clone the repo to your computers.

Open RStudio and follow the instructions on the website in section 13.3. Once the repo is cloned, you should be able to see copies of all the files in the repository.

## Update and commit using R

In the "Files" tab on the bottom right, navigate to `./lesson_plans/` and open `Introduction_to_R.Rmd`. This is the file we're going to be working with today -- each of you will be making different edits to it, so you'll want to be able to commit those changes and push them to your personal forks of the repo.

Start by adding a line of text after the first code chunk saying "This is a line from RStudio". Save your changes. Now you want to commit these changes to your local repo:

1. Click the "Git" tab in the upper right pane
2. Check the staged box next to `Introduction_to_R.Rmd`.
3. Click "Commit". You can see the differences between the original file and your new edits. Type a message in the "Commit message" box to explain your edit.
4. Click "Commit".

## Push local changes online

Click the green arrow "Push" button to send those local edits to your fork on GitHub. Go back to the GitHub website on your browser, navigate to your fork, and refresh. In the blue bar next to your username, you should see the description of the new commit you just made, and if you navigate to the `Introduction_to_R.Rmd` file on the GitHub website, you will see the new line you added to the file.

## Sync a fork

Committing edits and pushing them to your fork is great for updating your version of the repository, but you may also want to get changes from the original copy of the repo, for example to see the updated calendar or get access to any new files I create. To keep your fork up-to-date with the upstream repository, you need to do some configuring in Terminal.

Work through the following steps to configure a remote for your fork: https://help.github.com/articles/configuring-a-remote-for-a-fork/.

Now you are set up to sync your fork with the upstream: https://help.github.com/articles/syncing-a-fork/.

Adding a test line in my forked repository
