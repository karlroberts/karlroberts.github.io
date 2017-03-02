---
published: true
layout: post
title: "The Rise and (hopefully) fall of the Aux Pattern 3"
date: 2017-01-31 08:36:16 +1100
comments: true
categories:
- suited.js
- auxpattern
keywords:
- suited.js
- foobarwibblex
paginate:
  category: 'auxpattern'
---



### paginator deets 
page is kkkkkk {{ paginator.page }}

<section data-figure>
## a title
</section>

<section data-figure>
<p>Foo bar wibble</p>
</section>


<section data-figure>
Foo bar wibble
</section>


<section data-figure>
Foo bar wibble
</section>


<section data-figure>
Foo bar wibble 
</section>

~~*
## This is a foo slide
*~~

<section data-slide>
<p>Foo bar wibble 1</p>
</section>

<section data-slide>
<p>Foo bar wibble 2</p>
</section>

<section data-slide>
<p>Foo bar wibble 3</p>
</section>

<section data-slide>
<p>Foo bar wibble 5</p>
</section>

<section data-slide>
<p>Foo bar wibble</p>
</section>

see https://github.com/scala/scala/pull/5108  miles sabin sugests a fix in multiple param lists

https://github.com/scala/scala.github.com/pull/520/files/e4e08a8fb3734d9fc992a7cf2a48ede9c54cfe14

<!--more-->



## Abstract Types

    {% codeblock lang:scala "Programming in Scala, Chapter 20, Abstract Members - Odersky" %}
    class Grass extends Food
    class Cow extends Animal {
      type SuitableFood = Grass
      override def eat(food: Grass) {}
    }
    {% endcodeblock %}

As we expect this now compiles.is works 

An interesting point to notice is that we pass a value of type `Grass` to the `eat` method, not `SuitableFood`. This is much more readable, we can see at a clance at the `eat` methos that `Cows` eat `Grass`. 
But how does that work? Well the `type SuitableFood = Grass`, sometimes know as a type alias, is a mathematical evivilance. it is not an asignment operator  giving a value to a var.

    SuitableFood = Grass && Grass = SuitableFood

## Dependent types

must put dependent types in another param list so compiler has time to resolve the containing type first
else

    [error] ./Dummy.scala:67: illegal dependent method type: parameter may only be referenced in a subsequent parameter section
    [error]   def nonimplicitfail[T](thing: T, shazam: MyTypeClass[T], sayThis: shazam.In): shazam.Out = {
    [error]                                    ^
    [error] one error found


45
## Aux  page 45 astronaughts shapeless
This code uses the idioma c layout described in Sec on 3.1.2. We define
the Aux type in the companion object beside the standard apply method for
summoning instances.
Summoner methods versus “implicitly” versus “the”
Note that the return type on apply is Aux[L, O] , not Second[L] . This
is important. Using Aux ensures the apply method does not erase the
type members on summoned instances. If we define the return type as
Second[L] , the Out type member will be erased from the return type
and the type class will not work correctly.
The implicitly method from scala.Predef has this behaviour. Com-
pare the type of an instance of Last summoned with implicitly :
implicitly[Last[String :: Int :: HNil]]
// res6: shapeless.ops.hlist.Last[shapeless.::[String,shapeless
.::[Int,shapeless.HNil]]] = shapeless.ops.
hlist$Last$$anon$34@7c09f5f4
to the type of an instance summoned with Last.apply :
Last[String :: Int :: HNil]
// res7: shapeless.ops.hlist.Last[shapeless.::[String,shapeless
.::[Int,shapeless.HNil]]]{type Out = Int} = shapeless.ops.
hlist$Last$$anon$34@4dd00263
The type summoned by implicitly has no Out type member. For this
reason, we should avoid implicitly when working with dependently
typed func ons. We can either use custom summoner methods, or we
can use shapeless’ replacement method, the :46
CHAPTER 4. WORKING WITH TYPES AND IMPLICITS
import shapeless._
the[Last[String :: Int :: HNil]]
// res8: shapeless.ops.hlist.Last[shapeless.::[String,shapeless
.::[Int,shapeless.HNil]]]{type Out = Int} = shapeless.ops.
hlist$Last$$anon$34@17b3e7d8
We only need a single instance, defined for HLists of at least two elements:





