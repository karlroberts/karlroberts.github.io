---
published: false
layout: post
title: "correct way to add d3 libs and types to angular.js with system.js"
date: 2017-01-17 15:00:10 +1100
comments: true
categories: 
---

install nvm
look for the newest version with 
    nvm ls-remote

    nvm install v7.3.0
    nvm use v7.3.0

install the d3 and d3's types

    npm install --save d3
    npm install --save-dev @types/d3

This installs the d3 v4 libraries and source in the ./node-modules/d3 dir
and als adds the tpescript type definition files in ./node-modules/@types/d3

typscript voodoo typscript transpilers will use ./tsconfig.json files to configure the transpilation process.
as at v??? it looks by default for types in the typeroot `node-modules/@types` and enclosing dirs, eg ../node-modules/@types and ../..node-modules/@types

see [typescript docs](https://www.typescriptlang.org/docs/handbook/tsconfig-json.html#types-typeroots-and-types)

because our types are there any ts in our app directory can use the types.


however when you run your app you will need to tell the system.js bundler where to find libs to bundle in the app.

if you don't and just run 
    npm start

you'll see 404 errors in the console and in the browser console failing to load  the d3 javascript

    eg TODO add image or console output here....

OK so you think your clever and .....

go through my system.js.config file.
TODO
