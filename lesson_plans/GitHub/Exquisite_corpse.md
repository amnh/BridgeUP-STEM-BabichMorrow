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

1. We are going to work in three groups on three different stories. One person at a time will be responsible for typing the commands as well as the updates to the story, while the other group members tell them what to type. Switch off every turn so that everyone has a chance to type.
2. First, navigate in Terminal to the folder for your forked repository. Sync your fork to make sure it is up-to-date with all changes from the upstream repository.
4. Navigate to the folder with the stories in it. Open the file you're working on with the command `nano story1.txt`, for example. Nano is a text editor that we will be using to edit the stories. There are lots of text editors, like Vim, Sublime, Emacs, etc. Nano is a pretty basic one, so we're going to use it today just to get started. When you run `nano <file name>`, the editor will either allow you to edit that file, if it already exists, or it will create a file with that name and allow you to edit it.
5. Edit your story as a group - you have about 3-5 minutes! Once your editing time is up, exit the text editor by pressing Ctrl+X. Make sure to save the document by typing Y.
6. Add and commit the story file. Push the changes to the remote copy of the fork you've been editing.
7. Pull request time! Go to the online (remote) version of your forked sloth repository on GitHub. Select "New pull request" and click "compare across forks". The "base" fork should be "amnh/BridgeUP-STEM-BabichMorrow". Change the "head" fork to the name of your forked copy. Type a title for your pull request and click "Create pull request".
8. Now repeat steps 2 through 7 with another person running the keyboard! You should be editing the next story file now (if you edited story 1 last round, now do story 2; if you edited story 2, do story 3; if you edited story 3, do story 1).

