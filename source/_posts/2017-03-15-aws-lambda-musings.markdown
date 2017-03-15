---
published: true
layout: post
title: "AWS Lambda Musings - launch times"
date: 2017-03-15 00:50:55 +0000
comments: true
categories: 
- AWS Lambda
- launch speed
- serverless
---
I was thinking about AWS lambda's last night after a colleague asked how long they take to start?

For those who don't know, an AWS Lambda enables so-called "Serverless" event processing. On an "event" or "request" AWS will run your Lambda code function, and charge you just for the time it takes to run rather than paying for the time of a full EC2 instance running for hours. So if your application only need to sporadically answer requests it may be a good cost trade-off.

The down side is that your application becomes more fragmented, which can become an Operations and maintenance issue, and you are now definitely tied to your cloud provider. If you need super responsive queries you may be better to run a traditional application on EC2 that can be ready and listening and pay for its uptime.

Anyway back to my topic of AWS Lambda response times...

[According to this link](https://aws.amazon.com/blogs/compute/container-reuse-in-lambda/) they are run in "containers" I imagine that is similar to a docker container but a custom to AWS "chroot" jail?

If the container is still running from a previous invocation then there is no start up time for the container just the start-up time for the AWS lambda function.

Even if there is a container start-up time, if the underlying host is running (likely) then Docker containers are quick to start, like starting a process and a custom chroot jail may be quicker still. However some [developer forums](https://forums.aws.amazon.com/thread.jspa?threadID=226136) have stated that they can get 50-100ms response times from their Lambda's but occasionally see significant 12-15 second delays for infrequent invocations.

One can only guess at the reason but some kind of provisioning or resource sharing bottleneck seems likely. No doubt AWS teams are working on this as "Serverless" compute becomes the new Cloud buzzword and battleground.

But, as I mentioned earlier, the true benefit of Serverless is cheaper running for request or event processing not blazingly fast performance and response times

### On another topic ...
AWS Lambda currently supports Lambdas written in [Java, Node.js, C#, and Python code](https://aws.amazon.com/lambda/details/#Bring_Your_Own_Code) with more language support coming in the future.

I was thinking about how to run a very fast native function, e.g. compiled with Rust with no dynamically linked libs (all static) and found an [article showing how to launch the executable](http://julienblanchard.com/2015/rust-on-aws-lambda/) even though it is not yet directly supported by AWS by wrapping it in a node.js lambda.

This got me thinking, is node the fastest way to do this, after all if I'm a speed freak and writing Rust then launch times are important to me...

So I looked at at launching a process from node and python and timing it, I did not investigate C# or Java as they will always take longer to start because their runtime is doing more stuff.

This is not a statistically viable experiment (I only ran it once :-) but I built a shell tool called [launch.sh](https://gist.github.com/karlroberts/141e1e7b38ca85ac3da7b88297d48a97 ), see the [gist](https://gist.github.com/karlroberts/141e1e7b38ca85ac3da7b88297d48a97), to spit out a date including nanoseconds (my laptop supports this) then kick of a python app that uses a subprocess to run the same date command twice from within the python app. It then does the same using node.js.

Running it I get this data :-

    me@storm:~/bin$ ./launch.sh 
    start launch python data subprocess...
    09:57:25 1489532245 519378382
    09:57:25 1489532245 530775400
    09:57:25 1489532245 531650629
    
    start launch python compiled data subprocess...
    09:57:25 1489532245 533984993
    09:57:25 1489532245 541690675
    09:57:25 1489532245 542552837
    
    Now using node v7.6.0 (npm v4.1.2)
    start launch node subprocess
    09:57:25 1489532245 712281203
    09:57:25 1489532245 750742945
    09:57:25 1489532245 751821095

The first date in each triplet is the date at the shell before launching python or node followed by the subprocess date commands inside the python or node script.

The last set of numbers on each line is nanoseconds.

I also pre-compiled a python script to see if it was faster than executing the script, but forgot that python would do a search for pre-compiled scripts version of commands so the results of the first two are probably actually running the compiled version, the first is slower to launch presumably searching to see if there is a pre-compiled version in the directory (N.B. this is a guess as I don't have enough data here to prove it). Regardless I removed the compiled python and ran again to get un-compiled time data:

    start launch python data subprocess...
    10:34:30 1489534470 041312697
    10:34:30 1489534470 054794071
    10:34:30 1489534470 055933101

##### The results are :-

    Uncompiled python takes 13481374 ns to launch and run the subprocess
    Uncompiled python takes  1139030 ns to launch and run a subprocess once it is already running
    
      Compiled python takes  7705682 ns to launch and run the subprocess
      Compiled python takes   862162 ns to launch and run a subprocess once it is already running 
    
    node.js           takes 38461742 ns to launch and run the subprocess
    node.js           takes  1078150 ns to launch and run a subprocess once it is already running 

So the results show it is currently best to use compiled python to kick off a sub process e.g. a Rust or Go procedure in AWS lambda

When Go or Rust are natively supported by AWS Lambda containers no doubt the story will change.
