---
layout: post
title: "Scala Implicit Class Pimp Gotcha"
date: 2014-12-15 08:59:25 +1100
comments: true
categories: [Scala, implicit class, pimp, pimp my library, gotcha ]
---
Since Scala 2.10 we've had the convenience to "Pimp" a library using implicit classes.
For the details see [Implicit Classes](http://docs.scala-lang.org/overviews/core/implicit-classes.html)

This makes it trivial to add methods to previously closed classes. However there are some gotcha's to beware of. In particular make sure you [read the rules](http://docs.scala-lang.org/overviews/core/implicit-classes.html#restrictions)

The reason I'm writing this blog is that I fell foul of restriction 3. It took me ages to work it out.
<!--more-->

Restriction 3 says:- 
> "There may not be any method, member or object in scope with the same name as the implicit class.
> 
> Note: This means an implicit class cannot be a case class."

The mistake I made was to have a companion Object for my Implicit class. The compiler spits out an error message like this :

    [error] /home/projects/myproj/src/test/scala/com/owtelse/FooTest.scala:27: value myPimpedMethod is not a member of com.owtelse.Foo
    [error]     val f2: Foo = foo.myPimpedMethod(false)
    [error]                       ^
    [error] one error found
    [error] (scazelcast-api/test:compile) Compilation failed
    [error] Total time: 2 s, completed 15/12/2014 8:24:05 AM

This had me pulling my hair out! I could see my implicit class was in scope and so the method should have been available to Foo.
The problem was of course that I had an object named the same as my implicit class as a companion object.
Rather than tell me that the compiler simply discounted my implicit class and simply reported that the myPimpedMethod was not available on type Foo.

**As soon as I deleted the companion object every thing worked.**

While I was a bit annoyed with this behaviour, it makes sense.
The only purpose of the implicit class is as a convenience to wrap the underlying class you wish to pimp and is only meant to be used as an implicit conversion.
As such you should have no need to instantiate the class in any other way and so should have no need for companion object,
plus I bet it makes it easier for the compiler writers to apply the conversion where needed if they don't have to disambiguate symbols :-)


