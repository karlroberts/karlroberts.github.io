---
layout: post
title: "Deploying Octopress: The Missing Manual"
date: 2014-06-25 16:12:59 +1000
comments: true
categories:
- Octopress
---
## Github Deploy
The [Octopress Doco](http://octopress.org/docs/deploying/github/) does a pretty good job but it misses out one crucial step. 

* You need to commit the master branch and push it up to github.

But before you do please read on to see how to do that the octopress way.

### Where are all my blogs and pages?

If you've followed octpresses Doco, then under your `octopress` directory you'll have a `source` folder.

* Web pages are in directories directly under `source`.
* Blog posts are under the `_posts` directory.

running `rake generate` will copy the content to the `_deploy` directory and check it into git.
running `rake deploy` commits it and pushes the deploy directory to github

Job done right?

Unfortunatly it's not always that easy. All the code under source will be on the git branch `source`. If you follow the instructions in the doco you'll commit this code and push it to git hub with this command

    git add .
    git commit -m 'your message'
    git push origin source

This pushes your "source" to github into the `source` directory.

### Why can't I see my stuff in Github
The problem is the pages that get rendered as the blog in github is the stuff in the `master` branch. That was supposed to be pushed by running `rake deploy`

However sometimes that git simply failes to do that for you. Why? Well perhaps you have accidentally modified the code under `_deploy` and git is actually complaining but the rake task doesn't show you that?

To check simply

    cd _deploy
    git status # notice that the _deploy dir is in the master branch :-)
    git push origin master # this may fail and tell you why

For me the last step did fail. I fixed it by doing 

    cd _deploy
    git fetch origin master
    git merge origin/master  # you may need to fix conflicts here
    git push origin master

And that sorted it :-)

From then on my `rake deploy` worked as expected. lesson learned, leave the `_deploy` dir alone!
