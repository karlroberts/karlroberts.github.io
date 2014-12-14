---
layout: post
title: "Micro-DOT - Single File Webapps"
date: 2014-07-16 08:42:59 +1000
comments: true
categories: [DevOps, Micro-DOT, Docker, Single-Page-Webapp, Single-File-Webapp]
published: false
---
## Introduction

## SPA - Single-Page-Applications

## Self Extracting Zips

## Self Executing JAR file
### SBT
### Maven

## Docker

## Drop 'n' Go
So now we have a complex webapp packages as a single executable file, all the dependant libs etc are bundled inside it, all it needs to run is a JVM (Java Virtual Machine), That single file can be run by simply invoking it, useful for testing and giving to your mates, but now it is itself packages inside a Docker container, All the container does is provide the JVM and kick of the app. We can now drop the container into any number of machines that run Docker. 

We don't care if it is a real machine or a VM. 

We don't care if it is a local box or a cluster of VM's an AWS

We don't care about the OS or the software installed

We just have to produce a Mico-DOT and we can use the "EXACT" same script/process to deploy any app.

managing versions is simple with a single file

managing VM's is simple as it's the same Docker Container each time, no fancy libs or dependencies.
