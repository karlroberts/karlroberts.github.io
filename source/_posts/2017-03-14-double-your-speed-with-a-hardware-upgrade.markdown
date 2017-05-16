---
published: true
layout: post
title: "Don't sacrifice code quality for performance"
date: 2017-03-14 17:30:32 +1000
comments: true
categories: 
- dell..
- xps 9560
- performance
- x2 speed
---

As a developer, I've often seen (and been the culprit) of premature optimisation. Developers, in our desire to write fast software often, mistakenly, sacrifice readability, maintainability and correctness in favour of speed.

{% blockquote Donuld Knuth https://en.wikiquote.org/wiki/Donald_Knuth Computer Programming as an Art (1974) %}
Premature optimization is the root of all evil ... in programming
{% endblockquote %}
<!-- more -->

It is far better to have clean code and optimise where necessary 
after measuring everything in a production like environment.

{% pullquote %}
In fact it may not be necessary to mess up the code, perhaps the solution is to run on better hardware?

**[Check out the video below.](#video)**

I recently upgraded my laptop after 4 years of usage, and as well as the usual smug appreciation of my new hardware, I am blown away by the performance hike. {" Double your speed with a hardware upgrade "}

Like watching grass grow we don't usually notice the ongoing benefit of the advances in computer hardware until you get to see it in time-lapse.
{% endpullquote %}

<a name="video">
<iframe width="640" height="320" src="https://www.youtube.com/embed/Q4yvo1o52Xw" frameborder="0" allowfullscreen></iframe>
</a>

My old laptop was no donkey. A Samsung New Series 9
and yet next to my new Dell XPS 9560 it looks positively pedestrian.

| Feature | Samsung NP900X4C | Dell XPS 9560 |
|:----------|:-------------------------:|:---------------------------:|
| CPU       | 3rd gen i7-3517U         | 7th gen i7-7700HQ          |
| CPU speed | 3M cache, 1.7 GHz        | 6M cache, 3.8 GHz          |
| CPU cores | 2                        | 4                          |
| memory    | 16Gb DDR3 (1600MHz)      | 16GB DDR4-2400MHz          |
| disk      | Samsung 840 m.2 SATA SSD | Samsung PM961 m.2 PCIe SSD |

<br/>
I have the same version of Ubuntu 16.04 with the latest patches running on both machines, and I downloaded the same project I'm currently
working on. I then started a Maven build side-by-side to compile and package the whole application I'm currently working on.

My new laptop is almost twice as fast as my previous fast laptop

New Dell XPS 9560 => **12.329 seconds**
vs
old Samsung "New" series 9 => **21.365 seconds**

A 12 second pause is no way as distracting as a 20 second pause, allowing me to stay in context and keep coding.

Nice.
