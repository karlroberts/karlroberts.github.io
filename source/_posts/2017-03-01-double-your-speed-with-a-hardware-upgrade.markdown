---
published: false
layout: post
title: "Don't sacrifice code quality for performance"
date: 2017-03-01 21:30:32 +0000
comments: true
categories: 
- dell..
- xps 9560
- performance
---

As a developer I've often seen (and been the culprit) of premature optimisation. Developers, in our desire to write
fast software often, mistakenly, sacriface readability, maintainability and correctness in favour of speed.

{% blockquote Donuld Knuth https://en.wikiquote.org/wiki/Donald_Knuth Computer Programming as an Art (1974) %}
Premature optimization is the root of all evil ... in programming
{% endblockquote %}

This premature optimisation effort is bad practise. It is far better to have clean code and optimise where necessary 
after measuring everything, in a production like environment.

{% pullquote %}
In fact it may not be necessary to mess up the code to get the a fractional improovement, perhaps the solution is to run on better hardware?

I recently upgraded my laptop after 4 years of usage, and as well as the usual smug appreciation of my new hardware
I am blown away by the performcance hike. {" Double your speed with a hardware upgrade "}

Like watchng grass grow we don't usually notice the ongoing benefit of the advances in computer hardware
until you get to see it in timelapse.

Check out the video below.
{% endpullquote %}

My old laptop was no donkey. A Samsung New Series 9, with a 3rd generation dual core intel i7 CPU with 16gb Ram and a 1Tb M2 Sata solid State Drive (SSD).
and yet next to my new Dell XPS 9560, which has 7th Gen i7 4-core CPU, faster 16GB DDR4-2400MHz RAM and a blazingly faster 512GB PCIe SSD, it looks positivly pedestrian.

I have the same version of Ubuntu 16.04 with the latest patches running on both machines, and I downloaded the same project I'm currently
working on and then started a Maven build side-by-side to compile and package the whole application, a task tat I run fairly frequently when
I'm working on or testing the deploy process or a a new feature in a development environment.

{% video ../../../../video/dell_v_samsung.mp4 640 320 ../../../../video/dell_v_samsung.png %}

My new laptop is almost twice as fast as my previous fast laptop, compleating the task in seconds verus ??? seconds on my old Samsung.

A 10 second pause is no way as distracting as a 20 second pause, allowing me to stay in context and keep coding.

Nice.



