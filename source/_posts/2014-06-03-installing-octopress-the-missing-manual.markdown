---
layout: post
title: "Installing Octopress: The Missing Manual"
date: 2014-06-03 12:36:13 +1000
comments: true
categories: 
---
## Ruby pain
The main problems installing octopress is that it relies on a ruby environment.
This would be fine except it also relies on Ruby having been compiled with certain libraries available in order for the bundler to work as per the octopress doco.
<!--more-->

## Missing libraries
During the Octopress install Ruby or rbenv or bundler will moan that Ruby needs to be compiled with zlib or OpenSSL. to get these on ubuntu do:-

    apt-get install zlib1g-dev
    apt-get install libssl-dev openssl

if you are not on ubuntu look at [this blog](https://github.com/sstephenson/ruby-build/wiki) for common ruby gotchas and solutions on different Linuxes.

## Install Ruby
Then as per the Octopress Doco [install Ruby](http://octopress.org/docs/setup/rbenv/) except where it shows `>> ~/.bash_profile` instead you shoul send it to ~/.bashrc or else each time you open a Terminal in your desktop you'll need to source ~/.bash_profile so instead do this :-

    cd
    git clone git://github.com/sstephenson/rbenv.git .rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
    source ~/.bashrc

Now each time you open a terminal from your Desktop environment it'll make sure that rbenv and ruby are in your path, allowing octopress rake commands to work.

Once that is done the Octopress install, as per [this doco](http://octopress.org/docs/setup/), should work fine... well.... it worked on my machine (Ubuntu 14.4  ;-) )

