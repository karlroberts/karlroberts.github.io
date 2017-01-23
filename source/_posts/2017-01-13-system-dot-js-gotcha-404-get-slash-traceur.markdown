---
published: false
layout: post
title: "system.js GOTCHA 404 GET /traceur"
date: 2017-01-13 09:57:54 +1100
comments: true
categories: 
---

"target": "ES6",
     "module": "commonjs",

watch out if you dont set common.js it defaults to ES^ modules which are not relative to the file you are in... so imports have to be fully qualified from the root...

system.js should be able to add roots that are searchable from.

error is wierd, because you are using dynamic in browser loading the transpiler fails it is downloaded into each file but why 404 I don't know


also similar error loading d3 and types

see 
system.js.config too to see how to load the d3 lib from npm install.

