---
published: false
layout: post
title: "reusable d3 chart components in angular2"
date: 2017-01-11 13:17:37 +1100
comments: true
categories: 
---


Putting values in an attribute of an element in Component template syntax...

must do like this:- 

    <svg [attr.viewBox]="viewboxAttribute" preserveAspectRatio="xMidYMin meet"></svg>

and in the component class have this

    class D3Component   {
          xthings: number = 1000;
          ythings: number = 1000;

          get viewboxAttribute(): string { return "0 0 " + this.xthings + " " + this.ythings  ; }
    }


reusable chart API, use typescript get and set accessors rather than a func that returns an or type?
or mor directly use a SUM type?

