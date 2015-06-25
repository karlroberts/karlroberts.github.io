---
layout: post
title: "Micro-DOT - Single File Webapps"
date: 2014-07-16 08:42:59 +1000
comments: true
categories: [DevOps, Micro-DOT, Docker, Single-Page-Webapp, Single-File-Webapp]
published: false
---
## Introduction
Following E-Do we need our artifact to be easy for downstream consumption.
Whats easier to consume than a unix command? simply add to path or call directly

## SPA - Single-Page-Applications
Angular.js and other web frameworks mak it easy to build and manage webapps.
A few javascript function some CSS and a single html file is easy to mange.
just zip it up and extract it.

But what about the server side stuff? the REST API's and db integration etc that the on page we app uses?
Wouldn't it be cool if the backend stuff was just as easy to manage?

## Self Extracting Zips
'NIX nerds have used this stuff forever ...

    #!/bin/sh
    dohis 
    do this
    tail -4 $0 | unzip >- | runme

Well ... a Jar file is just like a zip file

## Self Executing JAR file
It turns out that the zip standard knows where the zip archive starts it ignors
the crap at the beginning... this gives us wiggle room.

We can write some shell script and concat it to the jar, the shell script simple calls

  #!/bin/sh
  java -jar $0
  ... rst of jar /zip file follows.

This file on running passes itself to the java command to run, the jave -jar command expects a jar file as its arg. it attempts to unzip it...the zip skips the shell crap at the beginning and move straight over to the meat of the app. This "file" effectivly becomes a UNIX executable that kicks off a java process... where the java program is embedded in itself.
How portable is that?

### SBT
### Maven

## Docker

## assembly
The assembly plugins drag in all the dependencies.
\Now we have FAT jars! easily 100's of megabytes, especially if the apache commons lib we pulled in!!!

You need to shrink it to just the stuff that is used.
see proguard!
Shrunk, minimised and obfuscated :-)
smaller jar smaller bytecode sweet.

## Drop 'n' Go
So now we have a complex webapp packages as a single executable file, all the dependant libs etc are bundled inside it, all it needs to run is a JVM (Java Virtual Machine), That single file can be run by simply invoking it, useful for testing and giving to your mates, but now it is itself packages inside a Docker container, All the container does is provide the JVM and kick of the app. We can now drop the container into any number of machines that run Docker. 

We don't care if it is a real machine or a VM. 

We don't care if it is a local box or a cluster of VM's an AWS

We don't care about the OS or the software installed

We just have to produce a Mico-DOT and we can use the "EXACT" same script/process to deploy any app.

managing versions is simple with a single file

imanaging VM's is simple as it's the same Docker Container each time, no fancy libs or dependencies.
