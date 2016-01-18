---
layout: post
title: "Using JavaScript in Octopress"
date: 2016-01-14 11:24:02 +1100
comments: true
published: true
categories: 
- octopress
- javascript
- D3
---

I intend to write a series of blogs on Javascript. It occurred to me that the blog should be able to demonstrate the JS code to make it more accessible.
K
So first things first I need to gry Octopress (my blogging framework) to use my JavaScript.

This blog intends to catalog how I got my JS examples into the blog. <!--more-->

What do I need? ... 

I need to add a `script` tag in the blog post to include the JavaScript.

luckily the Octopress markdown syntax that blogs are written in allows pure html, so I can simply add the script tags
eg. Here is how to use D3 to generate an SVG

{% codeblock lang:html %}
<div id="rect1" class="chart"></div>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.12/d3.min.js"></script>

<script>
var square = d3.select("#rect1");

var svgContainer = square.append("svg")
    .attr("width", 100).attr("height", 100);

//Draw the Rectangle
var rectangle = svgContainer.append("rect")
    .attr("x", 10).attr("y", 10).attr("width", 50)
    .attr("height", 60).attr("fill", "red")
    .attr("stroke", "blue").attr("stroke-width", 5);
</script>
{% endcodeblock %}

<div id="jsinocto20160114-rect1" class="chart"></div>


Notice that the `<div>` tag to hold the generated SVG came before the JavaScript?

If it had come after the JS the Square would not have rendered because the script would run as soon as it was encountered in the normal HTML way but the DOM element it was looking to populate (something with the id="rect1") was not yet on the page.

I could have simply looked for the `body` and appended it to that in JS or had the JavaScript run in an `onload` callback eg

{% codeblock lang:javascript %}
window.onload = function drawSquare() {...}
{% endcodeblock %}

This is all OK but there are a couple of problems I can see.

1. I may end up importing popular libraries more than once on a page
    - especially in the blog index that shows many blog pages
    - multiple large downloads may impact render times
2. Because the index page shows many posts on one page..
    - I may get JavaScript variable name conflicts.
  
The solution to point 1 is found in the [octopress documentation](http://octopress.org/docs/theme/template/)

{% blockquote %}
If you want to add scripts or tags to the `<HEAD>` take a look at `/source/_includes/custom/head.html` ...

If you'd rather inject scripts at the bottom of the page, you can add that to `/source/_includes/custom/after_footer.html`.
{% endblockquote %}

So, I can simply include my common libraries by adding the script tag in `/source/_includes/custom/after_footer.html`

Problem 2 can be solved by adopting a convention. All JavaScript I write will be closed inside an [immediate function](https://en.wikipedia.org/wiki/Immediately-invoked_function_expression) named after the blog page and the div's the code interacts with shall have an id that is prefixed by the blog page. 

For example

{% codeblock lang:html %}
<div id="blogpost1-rect1" class="chart"></div>

<script>
(function blogpost1() {
var square = d3.select("#blogpost1-rect1");

var svgContainer = square.append("svg")
    .attr("width", 100).attr("height", 100);

//Draw the Rectangle
var rectangle = svgContainer.append("rect")
    .attr("x", 10).attr("y", 10).attr("width", 50)
    .attr("height", 60).attr("fill", "red")
    .attr("stroke", "blue").attr("stroke-width", 5);
})();
</script>
{% endcodeblock %}


<!-- add my JavaScript -->
<script>
(function jsinocto20160114() {
var square = d3.select("#jsinocto20160114-rect1");

var svgContainer = square.append("svg")
    .attr("width", 100).attr("height", 100);

//Draw the Rectangle
var rectangle = svgContainer.append("rect")
    .attr("x", 10).attr("y", 10).attr("width", 50)
    .attr("height", 60).attr("fill", "red")
    .attr("stroke", "blue").attr("stroke-width", 5);
})();
</script>
  

