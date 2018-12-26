# Exquisite Corpse: A Git pull request game

Adapted from a lesson plan by Madelyne Xiao (Coral Crew Helen Fellow!)

## What's with the name?

Exquisite corpse (aka exquisite cadaver aka *cadavre exquis*) is a technique invented by the surrealists where a group of people create a story or drawing piece by piece. Each collaborator adds something in turn until you end up with a complete (and usually very weird) composition.

<figure><img src='https://www.tate.org.uk/art/images/work/P/P78/P78459_9.jpg'><figcaption>An exquisite corpse drawing by artists Jake and Dinos Chapman (https://www.tate.org.uk/art/art-terms/c/cadavre-exquis-exquisite-corpse)</figcaption></figure>

## So what does this have to do with coding?

We are going to play exquisite corpse by creating stories and sharing them through GitHub. As you each add to the different stories, you will be using a new Git skill - pull requests - to "publish" the newest version of your story so that everyone else can accesss it.

## GitHub Pull Requests :octocat:

![alt text|10%](https://github.com/amnh/BridgeUP-STEM-BabichMorrow/blob/master/github_diagram2.png)

Most of this diagram should look familiar (hint, it's right underneath our calendar). The only part of this workflow we haven't done yet is a pull request.

A pull request is a way for you to get the changes you've made to your code back into the original version of the repository. Let's say you've written some code to analyze our sloth data. Once you push it to your fork of the repository, it's available on GitHub for you, but the rest of the SlothSquad still can't see it. If you submit a pull request, however, your code can be pushed to the original repository. Then everyone else can get a copy of that code when they sync their fork.

Sound complicated? Let's give it a try.

## Instructions

1. We are going to work in two groups on two different stories. One person at a time will be responsible for typing the commands as well as the updates to the story, while the other group members tell them what to type. Switch off every turn so that everyone has a chance to type.
2. First, navigate in Terminal to the folder for your forked repository.
3. Next, your group needs to sync the fork of whoever is typing:
  + Fetch commits from upstream repository to get the updated version of the story: `git fetch upstream`
  + Check out your fork's local `master` branch: `git checkout master`
  + Merge the changes from `upstream/master` into your local `master` branch: `git merge upstream/master`
    + Will need to hit the escape key, then type `:wq` to get out of the text editor for the commit
  + Run `git push` one final time to push the merged changes to your remote fork
4. Go to the online (remote) version of your sloth repository on GitHub. Navigate to the folder with the stories in it. You have about 3-5 minutes to add to them as a group!
  (Note, these stories are written in Markdown files, which is a way to style text on the web. [Here](https://help.github.com/articles/basic-writing-and-formatting-syntax/) is a cheatsheet for formatting a Markdown document and [here](https://gist.github.com/rxaviers/7360908) is a list of all the GitHub Markdown emojis.)
5. Save changes to the story by going to the bottom of the document, where it says "Commit changes." Add a descriptive commit message in the first text box, and click the green "Commit new file" button.
