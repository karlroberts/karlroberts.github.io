---
layout: post
title: "Octopress ignores published: false - GOTCHA"
date: 2016-01-18 14:29:13 +1100
comments: true
published: true
categories: 
- gotcha
- octopress
---

I recently had the misfortune that octopress started ignoring my `published: false` statement in my blogs YAML header section. I have now solved the issue. <!--more-->

The `published: false` statement is meant to prevent the blog from being prematurely published, eg while it is in progress.

The internet told me that running `rake generate` before `rake deploy` was supposed to remove blogs marked as `published: false` from the files to be published. However it was not working for me.

Octopress does allow blogs marked as `published: false` to be used in the `preview` task, so you can see your work in progress locally.

Looking through the Rakefile I discovered that a file called `.preview-mode` is used to handle this exemption.

It turned out that I had accidentally committed the `.preview-mode` file to git while running the preview. It was now always there! This messed up the deploy and enabled all my in flight blogs to be published.

The fix was simple.

{% codeblock lang:bash %}
git rm -f ./.preview-mode
git commit -m "removed .preview-mode, which was accidentally added"
{% endcodeblock %}

SOLVED. `rake generate` and `rake deploy` now work properly again.

:-)
