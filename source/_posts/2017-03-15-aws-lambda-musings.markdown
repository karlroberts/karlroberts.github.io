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
I was thinking about AWS lambda's last night after a colleague asked how long they take to start? <!-- more -->

For those who don't know, an AWS Lambda enables so-called "Serverless" event processing. On an "event" or "request" AWS will run your Lambda code function, and charge you just for the time it takes to run rather than paying for the time of a full EC2 instance running for hours. So if your application only need to sporadically answer requests it may be a good cost trade-off.

The down side is that your application becomes more fragmented, which can become an Operations and maintenance issue, and you are now definitely tied to your cloud provider. If you need super responsive queries you may be better to run a traditional application on EC2 that can be ready and listening and pay for its uptime.

Anyway back to my topic of AWS Lambda response times...

[According to this link](https://aws.amazon.com/blogs/compute/container-reuse-in-lambda/) they are run in "containers" I imagine that is similar to a docker container but a custom to AWS "chroot" jail?

If the container is still running from a previous invocation then there is no start up time for the container just the start-up time for the AWS lambda function.

Even if there is a container start-up time, if the underlying host is running (likely) then Docker containers are quick to start, like starting a process and a custom chroot jail may be quicker still. However some [developer forums](https://forums.aws.amazon.com/thread.jspa?threadID=226136) have stated that they can get 50-100ms response times from their Lambda's but occasionally see significant 12-15 second delays for infrequent invocations.

One can only guess at the reason but some kind of provisioning or resource sharing bottleneck seems likely. No doubt AWS teams are working on this as "Serverless" compute becomes the new Cloud buzzword and battleground.

But, as I mentioned earlier, the true benefit of Serverless is cheaper running for request or event processing not blazingly fast performance and response times
