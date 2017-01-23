---
published: false
layout: post
title: "automounting s3fs"
date: 2017-01-18 13:20:22 +1100
comments: true
categories: 
- s3fs
- automount
- linux
- s3
---
## What is s3?
I'm going to assume you know what Amazon Web Services(AWS) S3 storage is and know that it is good and you want to use it, if not [see s3](https://aws.amazon.com/s3/) 

## What is s3fs
s3fs is a [FUSE](https://github.com/libfuse/libfuse) based file system that allows you to mount an AWS s3 bucket as a
directory, aka folder, onto your local file system. It preserves the native file
format of the files allowing you to download them and just use them as normal again on any other internet connected computer
without any special file reader. In other words you get an exect copy.

## Why do you care?
While S3 is awesome and cheap and allows easy ([and cheaper](https://aws.amazon.com/glacier/)) archiving 
accessing or storing files is not as straight forward to navigating to them whith your file explorer.

Unfortunatly using the web interface to upload or downlod files is cluncky, and
having to use the CLI (command line interface) is a but tricky and it's easy to
forget how.

Useing s3fs makes grabbing and dropping files to and from the s3 bucket
as easy as dropping files in a local directory

It's like having your own personal drop box with infinite space. Unlike AWS EC2 compute services which charges per hour, there is very little cost to store the data, approximatly 2 cents per Gbyte per month ( [see pricing](https://aws.amazon.com/s3/pricing/)  

You can work on the files on your computer and when you save them the the file replaces the one in the S3 bucket.

In the spirit of full disclosure, it is not quite as easy as working on a local file because random access is not possible so changes involve the whole file being saved to the cloud on every save, so there is the network cost of saving the entire file every time which is a bit laggy and adds some small data transfer costs in AWS ( [see pricing](https://aws.amazon.com/s3/pricing/) ). Also s3fs does not handle concurrent access well, so if two people mount the same bucket and edit the same file then some of the changes can be lost.

So, the best use case, in my opinion is to store stuff that doesn't change much after it is created, eg images and PDF's, static website pages etc.

Another sweet spot use case is as the backing filestore for a code artifact repository, eg Nexus, because artifacts such as versioned libraries and other software once built are not changed, instead new versions are added. There is also a need to make sure it doesn't go missing and can be backed up easily and be constantly available for other developers to use, and can also grow quite large over time as versions are constantly released. As there is effectivly no limit to the number of files I can store in a bucket, all that Operations hassel and overhead goes away and while it can be used at any time (eg when a build kicks off) there is no cost (see above) while not in use.

## what is the automounter?
So this is awesome, I want a S3 bucket to store my static files in, why use the Automounter?

The documentation on the s3fs Github [page](https://github.com/s3fs-fuse/s3fs-fuse) and [wiki](https://github.com/s3fs-fuse/s3fs-fuse/wiki/Installation-Notes) explains how to install s3fs and manually mount a bucket on a directory, or even mount the bucket at boot time by editing the `/etc/fstab`, however on my laptop (ubuntu 16.04) I dont want to connect a networked file system at bootup. For one thing I may be teathered to my mobile phone and dont want to wast my data allowance or may not be connected to the net at all. In Unix systems if you try to mount a network filesystem (eg NFS) that doesn't exist or is unavailable it is possible to hang the boot process untill the remote file system is available....??? FUSE ??? Linux???

I want to mount the filesystem on demand, ie when I attempt to look in the directory or access a file. 

This is what the automounter can do for me. enough explanation, lets see how to set it up.

1. first get an AWS account and create an [S3 bucket](https://aws.amazon.com/s3/) 
1.1 in this example I'll call the bucket "mystuff" 
2. create an [AWS Access Key](http://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys) for yourself 
2.1. This will consist of an "Access Key ID" and a "Secret access key"


if auto mount and no network when acces dir or file get 
    ls: cannot access 's3/talks': Transport endpoint is not connected

need to `sudo umount /my/s3fs/mountpoint` then once network is up just cd to dir again,
if using `/etc/fstab` you need to `sudo umount /my/s3fs/mountpoint` and then start net then `sudo mount /my/s3fs/mountpoint` then cd to the dir.

