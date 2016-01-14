---
layout: post
title: "Nice Cup of Tee"
date: 2014-02-20 13:49:50 +1100
comments: true
published: false
categories: [java, stream, unix]
---

Ever needed to take the output of one command and stuff it into the input of another?
Anyone who's ever worked at a UNIX command line will have used the Pipe(|) command to do jst that,
eg
    cat hugefile.txt | less

But what about splitting the output so that the output can be processed by two consumers? For instance piped into less so I can view it and simultaneously piped into `wc` so we can count the words?

The tee command was invented for just such a purpose.
<!--more-->

    tee example TODO

'NIX pipes have the happy property of being lazy. There are no intermediate state created (eg tmp files as output that are then fed into the next in line command) they act more like a plumbers water pipes as one drop of water escapes one pipe it is fed into the next.

'NIX commands are often called filters because they filter their input into the output, eg `grep` can take some input and only output the parts that match a regex, again this is lazygrep doesn't need the full txt file but can start processing (filtering) as soon it receives some bytes from it's input stream.

This lazyness is good. We are able to process files that are bigger than the available memory, because the file can be streamed and transformed through the pipeline, with the pipeline only acting on the bytes it receives.

Why am I giving a UNIX lesson? We can do the same in Java too.

Dev's comming from a Windows background may not be aware of the power of the lazy pipeline and filter model of pocessing and so tend to read a file into a huge "String" then process it and return the result.

This is fine if the file fits in memory, but become a real pain when working on a busy server proccessing 1000's of user requests. This is where the pipeline can help us.
It is a similar analogy to DOM parsing XML (which inflates a Domain Object model (DOM) in memory) to process the content Xalan Streaming API to process it. The DOM has the advantage that the whole DOM is in memory so complex manipulations and cycles can be performed, but the Stream can be processed much faster (less object creation, and more memory headroom) and because there are no cycles the contant passes through the Stream processor just once.

How

Piped Streams, Producers and consumers

P & C's are drivers, usually running in their own Thread
Piped Streams are Streams whose head or tail must be attached to the oposite kind
[see][1](http://www.certpal.com/blogs/2010/11/using-a-pipedinputstream-and-pipedoutputstream/)
