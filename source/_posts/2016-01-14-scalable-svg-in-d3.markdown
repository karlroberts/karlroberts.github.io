---
layout: post
title: "scalable SVG in D3"
date: 2016-01-14 18:23:31 +1100
comments: true
published: false
categories: 
- D3
- viewbox
---

this is differnet to dynamically modifying the scale inside and SVG eg as more data is added the scale on a graph needs to change its range, but has to still fit inside the area given to it. there are (plenty of examples)[http://bost.ocks.org/mike/bar/3/] of doing this

This is about scaling thre SVG graphic as the browser window changes size, for instance in a fluid grid layout.


<!--more-->
The core trick is to set the SVG width and height to 100% put it inside a Dive that can change size eg as CSS grid then rely on the SVG viewbox parameter. but there is some browser hell to contend with.


SEE other blog for details...???

viewbox tels the browser how to scale the image inside the SVG tag as the svg's width and height are changes. does the image change size if so doe it maintain its aspect ratio or elastically stretch with width and height

maps width and length of the svg to a internal scale that the SVG is based on. So when building the SVG we use the internal scale and pay no attention to the size in pixels

I like to pick an aspect ratio eg 1:1 or 4:3 then multiply it such that the large side has 1000 points in it eg
1000:1000 1000:750

?????TODO
EM trick to calculate text sizes:-

<!-- my JS -->
<script>



</script>