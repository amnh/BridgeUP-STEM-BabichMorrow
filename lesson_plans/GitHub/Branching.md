# Branching in Git

## Forking vs. branching

Git has two different ways to work on copies of code from a main (or master) set of code: 1) forking and 2) branching. Currently, you work on forks, which are copies of the main repository that I edit (https://github.com/amnh/BridgeUP-STEM-BabichMorrow). You can sync these forks with the main, or "upstream" repository to incorporate the changes I make to files and get these changes on your copy of the fork. There isn't a super easy way for you to incorporate your changes into the original main copy of the repository, however -- when you make edits on your forked copy, I can't see them and neither can the rest of SlothSquad. This is where branching comes in.

## What is branching?

Branching, as you can probably tell from the name, creates a "branch" from the main "tree" of the repository. Unlike a fork, this branch is connected to the main repository, which is what makes it so useful for us to use to collaborate on code. When you create a branch, you start off with all of the history of the main "tree": you have all of the files and commits from the repository up to the point the branch was created.

Once you create the branch, you can make changes to it (add files, edit files, even delete files) without changing those files on the main "trunk" of the repository (also known as the master branch). The branch is then (semi-)independent from the main code in the repository. If the code you write doesn't work, you can delete the branch and continue on your merry way without having damaged the code in the master branch. If you do like what you write on the new branch, you have the ability to later merge that branch with the master branch, incorporating your edits into the main code of the repository.

## Working on a branch

I have created three branches for our repository named `variegatus`, `tridactylus`, and `torquatus`. To work on these branches, you first need to clone the main repository from GitHub:
1. Go to the repository page: https://github.com/amnh/BridgeUP-STEM-BabichMorrow
2. Click the green "Clone or Download" button and then click on the clipboard icon to copy the link to your clipboard.
3. Open RStudio and open a new project by clicking on "File" and then "New Project".
4. Then click "Version Control" and then "Git". In the repository URL, paste the URL you copied from the GitHub website.
5. Click "Create Project". **Make sure you save this project somewhere on your computer you can find it later (probably your Desktop) and name it something that you won't confuse with your forked copy of the repository.**

Now this project is a cloned copy of the main GitHub repository (the one I make edits directly to). You still have a cloned copy of your forked repository on your computer: make sure you know where each of these lives on your computer!


## Branching resources

+ Chapter about branching from Happy Git with R: https://happygitwithr.com/git-branches.html
+ 
