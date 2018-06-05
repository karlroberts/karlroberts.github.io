---
layout: post
title: "How to build and package a Spring MVC app using scala sbt"
date: 2018-04-27 01:27:01 +0000
published: false
comments: true
categories: 
---

dont use assembly plugin, use java native packager to produce a zip file with all the dependency libs in /lib

optionally shrink all the libs and code with proguard.
