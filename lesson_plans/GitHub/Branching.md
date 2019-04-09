# Branching in Git

## Forking vs. branching

Git has two different ways to work on copies of code from a main (or master) set of code: 1) forking and 2) branching. Currently, you work on forks, which are copies of the main repository that I edit (https://github.com/amnh/BridgeUP-STEM-BabichMorrow). You can sync these forks with the main, or "upstream" repository to incorporate the changes I make to files and get these changes on your copy of the fork. There isn't a super easy way for you to incorporate your changes into the original main copy of the repository, however -- when you make edits on your forked copy, I can't see them and neither can the rest of SlothSquad. This is where branching comes in.

## What is branching?

Branching, as you can probably tell from the name, creates a "branch" from the main "tree" of the repository. Unlike a fork, this branch is connected to the main repository, which is what makes it so useful for us to use to collaborate on code. When you create a branch, you start off with all of the history of the main "tree": you have all of the files and commits from the repository up to the point the branch was created.

Once you create the branch, you can make changes to it (add files, edit files, even delete files) without changing those files on the main "trunk" of the repository (also known as the master branch). The branch is then (semi-)independent from the main code in the repository. If the code you write doesn't work, you can delete the branch and continue on your merry way without having damaged the code in the master branch. If you do like what you write on the new branch, you have the ability to later merge that branch with the master branch, incorporating your edits into the main code of the repository.

### Network graph

GitHub allows us to view a "network graph" for the repository, which is a nice way to visualize what is going on with branches, forks, etc. You can see the network graph for our repository here: https://github.com/amnh/BridgeUP-STEM-BabichMorrow/network. The line at the top represents the main version of the repository (the one I edit), which you can think of as the trunk of the tree (if the tree metaphor is helping you). The other rows show your forked copies of the repository. As you scroll left (back in time), you can see times where you synced your fork: these are when there is a line connecting the main repository to your forked copy. The dots along the lines represent each commit: you can hover over these to read the commit message.

If you scroll all the way to the right on the main version of the repository, you can see the three branches I've created for our repository named `variegatus`, `tridactylus`, and `torquatus`. You can see that they have commits of their own that are separate from the commits made to the master branch.

## Working on a branch

I have created three branches for our repository named `variegatus`, `tridactylus`, and `torquatus`. To work on these branches, you first need to clone the main repository from GitHub:
1. Go to the repository page: https://github.com/amnh/BridgeUP-STEM-BabichMorrow
2. Click the green "Clone or Download" button and then click on the clipboard icon to copy the link to your clipboard.
3. Open RStudio and open a new project by clicking on "File" and then "New Project".
4. Then click "Version Control" and then "Git". In the repository URL, paste the URL you copied from the GitHub website.
5. Click "Create Project". **Make sure you save this project somewhere on your computer you can find it later (probably your Desktop) and name it something that you won't confuse with your forked copy of the repository.**

Now this project is a cloned copy of the main GitHub repository (the one I make edits directly to). You still have a cloned copy of your forked repository on your computer: make sure you know where each of these lives on your computer!

### Switching branches in R

RStudio has some handy tools that we can use to work with branches. Go to the Git tab in your new RStudio project. On the right, you will see the name of the branch you are currently on (probably master). Now click on the File tab below and navigate to `intern_code/maxent_modeling`. It should only contain one file: `maxent_modeling_code.R`. Now, to switch branches, click on the drop-down arrow and select the branch for the species you will be working on with your partner. Now you will be able to see another file in your folder named something like `variegatus_maxent_code.R`. The three branches for each species have this additional script file that the master branch does not. Look back at the network graph: can you see where that additional file was created on the branch for your species?

### Editing files on a branch

While we are working on these branches in R, we are going to be doing "strict pair programming", which means only one person in your pair will be typing on the code at a time. The other person can be looking through their code to tell the typer what to type. Essentially, one partner is typing and the other is directing, i.e. telling them what code to write.

When it's time to switch typing partners, the person typing needs to commit their changes and push them to the remote branch so the other partner can get a copy of those modifications, and the person directing needs to retrieve these edits to their computer.

*Switching from typing --> directing:*
1. Save your changes to the script. The file will then show up in the Git tab of RStudio.
2. Click the checkbox next to the file, and click the "Commit" button.
3. A window will pop up where you will be able to see the difference between the original file and what you have added. Compare these versions: do you like the edits you made?
4. Type a commit message in the "Commit message" box and then click the "Commit" button.
5. Click on the "Push" button with the green arrow: this will take that edit you just made and push it to the remote copy of the branch (the one you can see on the GitHub website).

*Switching from directing --> typing:*
1. Go to the Git window of RStudio and click on the blue arrow: this will pull the edits from the remote copy to your machine.
2. Open the script file. Check to see that the edits your partner made are there.

## Try it yourself!

**Partner 1:**
1. Open the Maxent R script for their species and add your name and your partner's name to the top of the script.
2. Follow the instructions above (*Switching from typing --> directing*) to save that edit and push it to the remote copy of the branch.

**Partner 2:**
1. Follow the instructions above (*Switching from directing --> typing*) to pull that edit onto your local copy of the branch.
2. Open the Maxent R script for their species and add the date to the top of the script.

Now Partner 1 needs to follow the *Switching from directing --> typing* to get the date edit on their copy. You can now start on the script with your partner! Partner 2 will be telling Partner 1 what code to type until it's time to switch. Each time you switch, follow the instructions above.

## Branching resources

+ Chapter about branching from Happy Git with R: https://happygitwithr.com/git-branches.html
+ Video about Git branching: https://www.youtube.com/watch?v=QV0kVNvkMxc 
