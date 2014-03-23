---
layout: page
title: "Automagic Aspects"
date: 2014-03-24 08:53
comments: true
sharing: true
footer: true
published: false
categories: [apm, javaagent, performance monitoring]
---
As a developer it is natural to abstract and encode this stuff that you end up doing more than once so we "Don't Repeat Yourself" (DRY).
Working for a [performance tuning company](http://www.ecetera.com.au) some themes come up again and again. In order to tune a system it is first necessary to to be able to measure and monitor the systems performance. Application Performance Monitoring (APM) kicks up a number of themes that we've noticed keep recurring in our discussions with customers.

1. Centralise your logging and informatics.
2. When user transactions span systems attach a correlation ID that is picked up and propagated to any other systems that the transaction touches.


