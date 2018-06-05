---
layout: post
title: "How to proguard a scala uber jar to shrink and obfuscate"
date: 2018-04-27 01:31:01 +0000
published: false
comments: true
categories: 
---

dont obfuscate entry points like main functions and AWS lambda handler functions.

watch out for logging or anything that is refered to in config files eg log4j2.xml or else they wont be found, although you can magic the xml files too

wathc out for java Enums and any reflection! Names matter for reflection if you change them you better do it consistantly

shake the voodoo chicken enough times before you run proguard.

TEST that it works!!!!
You shoud use your integration tests via the entry points to test it. dont expect that because one prt of the app works all will work... you mayy have fragged the namming in a part you didnt test.

so er.. have fun?
