---
layout: post
title: "Testing angular.js at the Console"
date: 2015-06-16 14:54:54 +1000
comments: true
categories:
- angular
- test
- console 
---
### You've deployed your angular app
and now you want to test a Service or Controller quickly. 

sure you can (and should) write a unit test but you just need to sanity check 
the service is doing the right thing.

Well the browser has a javascript console (f12) which has all your code loaded in it,
so we should be able just run the service.

But the service is wrapped in a clousure, how can I get it to run it's methods?

Luckily Angular uses a dependency Injection (DI) mechanism, and we can get access to the injector.
Once we have the injector we can ask for the service "by Name" :-)

Assume I have a service called RouteService that has a method called routes on it that returns an array of route Objects.
I can run the method like this from the console:-

    var myinjector = angular.element(document.body).injector();   
    var myRouteService = myinjector('RouteService');
    var routes = myRouteService.routes();

voila! we now have the routes in a variable... we can see them by typing the name of the varible in the javascript console:-

    routes
    [Object, Object, Object]

In Chrome the object is compressed onto one line with a little "expandme" triangle next to it, click the triangle to see the values in the route Objects.


