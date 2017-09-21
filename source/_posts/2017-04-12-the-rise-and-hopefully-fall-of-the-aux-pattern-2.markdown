---
published: true
layout: post
title: "The Rise and (hopefully) fall of the Aux Pattern"
date: 2017-04-12 08:36:16 +1100
comments: true
categories:
- suited.js
- auxpattern
keywords:
- suited.js
---

This Blog is about the Aux Pattern as seen all over the Shapeless library. <!-- more -->

<small>It is also a slide deck for a talk givn at Scalasyd April 2017.<br/>
To switch between modes press a number as follows :<br/>

* '1' -&gt; Doc mode: 
  - shows the document as intended.
* '2' -&gt; Deck mode, see the slides
  - see the slides
* '4' -&gt; Lecture Mode
  - enter zooms current navigated to section
  - click zooms div or block clicked

Arrow keys navigate to next or previous section. or slide
</small>

<section data-slide>
  <h1 align="center">The Rise (and hopefully fall) of</h1>
  <h2 align="center">The Aux Pattern</h2>
  <div align="center">
    <span>12th April 2017</span>
  </div>
  <div style="height:100px"></div>
  <div>
    <a href="http://www.avocadoconsulting.com.au">
      <img src="/images/avocado-trans.png" style="max-height: 200px" alt="Avocado Logo"/>
    </a>
  </div>
  <div style="margin-top:100px; text-align: center;">
    <small><small>To present this document press <code>2</code>. Press <code>Esc</code> to get back to document view.
        See <a href="http://github.com/suited">suited.js</a>
    </small></small>
  </div>

</section>

This Blog is my talk for Scalasyd April 12th 2017. It is about the Aux Pattern as seen all over the Shapeless library. <!-- more -->

<section data-slide>
### Intro
* This talk is about Scala
  - &nbsp;
* &nbsp;
  - &nbsp;
  - &nbsp;
  - &nbsp;
* &nbsp;

</section>

<section data-slide>
### Intro

* This talk is about Scala
  - Not a Haskel talk dressed up in scala rags.
* &nbsp;
  - &nbsp;
  - &nbsp;
  - &nbsp;
* &nbsp;

</section>

<section data-slide>
### Intro
* This talk is about Scala
  - Not a Haskel talk dressed up in scala rags.
* About the scala type system
  - dependant types
  - type inference
  - implicits
* &nbsp;
</section>

<section data-figure>
### Intro
* This talk is about Scala
  - Not a Haskel talk dressed up in scala rags.
* About the scala type system
  - dependant types
  - type inference
  - implicits
* About a cluncky work around 
</section>

<section data-figure>
### Aim
* De-mystify Shapeless code
</section>

We've all seen code like this:-

<section data-figure>
``` scala
object IsHCons {
  def apply[L <: HList](implicit isHCons: IsHCons[L]): Aux[L, isHCons.H, isHCons.T] = isHCons

  type Aux[L <: HList, H0, T0 <: HList] = IsHCons[L] { type H = H0; type T = T0 }

  implicit def hlistIsHCons[H0, T0 <: HList]: Aux[H0 :: T0, H0, T0] =
    new IsHCons[H0 :: T0] {
      type H = H0
      type T = T0

      def head(l : H0 :: T0) : H = l.head
      def tail(l : H0 :: T0) : T = l.tail
      def cons(h : H0, t : T0) : H0 :: T0 = h :: t
    }
}
```
</section>

Alphabet soup if ever there was some. Hopefully at the end of this, we'll all be able to read this.
But before I skip on, notice the `Aux` all over that code. This is the source of the name of the `Aux` pattern.

<section data-slide>
## The Aux Pattern
</section>

The first thing to realise is that it is not a Pattern that can apply to a programming paradidm
It is really a hack. An elegant hack, but never-the-less a hack.
Definatly a hack.

<section data-slide>
## The Aux Hack
</section>

<section data-slide>
## The Aux Idiom
</section>

To be kinds to it, it has become quite pervasive as a way to work around
a problem so I guess I can call it an idiom specific to Scala and its type system.

Being an idom it has become a common way to get stuff done in scala, but what is it solving?
To answer that we need a little ramble around the scala type system.

### Type inference
First let's talk about `type inference`

<section data-slide>
### Type inference
* &nbsp;
* &nbsp;
* &nbsp;

</section>

<section data-slide>
### Type inference
* the compiler can work out the type of a thing 
* &nbsp;
* &nbsp;

</section>

<section data-slide>
### Type inference
* the compiler can work out the type of a thing 
* without us supplying a clue
* &nbsp;

</section>

<section data-figure>
### Type inference
* the compiler can work out the type of a thing 
* without us supplying a clue
* based on info it already has.

</section>

A pretty useful feature to have, as I'm sure you'll agree, as it helps cut down on "Type boiler-plate", while letting the compiler asset correctness for us.

So let's look an simple example

<section data-figure>
### Type inference

    object InferenceTest1 extends Application {
      val x = 1 + 2 * 3         // the type of x is Int
      val y = x.toString()      // the type of y is String
      def succ(x: Int) = x + 1  // method succ returns Int values
    }
</section>

As we can see the compiler is able to infer some types from the context.
The next example shows that even with generic types we can infer types at the call site.
I.e. when the specific type is first used.

<section data-figure>
### Type inference

    case class MyPair[A, B](x: A, y: B);
    object InferenceTest3 extends Application {
      def id[T](x: T) = x            // return type: T
      val p = new MyPair(1, "scala") // type: MyPair[Int, String]
      val q = id(1)                  // type: Int
    }
</section>

with no hints the compiler knows that `p` is a `MyPair[Int, String]` and `q` is an int

as an a2tion" sometimes mislabled "type annotation",
for example here is the some code with more type ascription than is necessary in scala

<section data-figure>
### Type ascription
    def id[T](x: T): T = x
    val p: MyPair[Int, String] = new MyPair[Int, String](1, "scala")
    val q: Int = id[Int](1)
    
    val b = 2 : Byte
</section>

The only necessary ascription here was on on `val b` which we want to be a `Byte` rather than let the default inference of `Int`.

### Path Dependent Types
OK no lets switch to another Scala feature, `path dependant types`.

<section data-slide>
### Path-dependent types
* &nbsp;
* &nbsp;


</section>

<section data-slide>
### Path-dependent types

* the type depends on the path
* &nbsp;


</section>

<section data-slide>
### Path-dependent types

* the type depends on the path
* so we can have types that depend on the Object that defines them.


</section>

<section data-figure>
### Path-dependent types

* the type depends on the path
* so we can have types that depend on the Object that defines them.
  - we can reference these types in out functions and methods.

</section>

Why do I care?

let's see an example

<section data-figure>
#### bad example

    trait Food {
      override def toString(): String
    }
    
    object grass extends Food {
      override def toString: String = "grass"
    }
    
    object dogfood extends Food {
      override def toString: String = "dogfood"
    }
</section>

In good OOP style I've used `inheritance` to create a type hierarchy.

I can then use these types to define some object instances.

<section data-figure>
#### bad example

    abstract class BadAnimal  {
      def eat(fodder: Food): Unit = {
        println(s" ${this.getClass} Eating my food: "+ fodder)
      }
    }
    
    object badfeeder {
      def feed(animal: BadAnimal, food: Food): Unit = {
        animal.eat(food)
      }
    }

    class Cow extends BadAnimal with Food {
      override def toString = "Cow"
    }
</section>

Now I can use the `badfeeder` object to feed Daisy the cow.

<section data-figure>
#### bad example, so far so good

    val Daisy = new Cow
    
    //Acceptable
    badfeeder.feed(Daisy, grass)
</section>

<section data-figure>
#### bad example, errrm?

    val Daisy = new Cow
    
    //naughty
    badfeeder.feed(Daisy, dogfood)
</section>

<section data-figure>
#### bad example, WTF!

    val Daisy = new Cow
    
    //totally unacceptable. Canibalism
    badfeeder.feed(Daisy, Daisy)
</section>

As you can see `badfeeder` was allowed by the compiler to turn Daisy into a masochistic canible.

The problem is that the feeder was allowed to give `Food` to an `BadAnimal`, and Daisy was Food as well as an `BadAnimal` .
What we need is that an Animal can only eat food suitable for that animal.

But at the time we declare the Animal supertype we don't know what is suitable food.
The solution is to create an abstract type in Animal that will be specialised by each animal kind when 
we extend Animal. So as before... 

<section data-figure>
#### good example (same food)

    trait Food {
      override def toString(): String
    }
    
    object grass extends Food {
      override def toString: String = "grass"
    }
    
    object dogfood extends Food {
      override def toString: String = "dogfood"
    }
</section>

<section data-figure>
#### good example, better Animals

    abstract class GoodAnimal {
      // path dependent type
      type SuitableFood <: Food

      def eat(food: SuitableFood): Unit = {
          println(s" ${this.getClass} Eating my food: "+ food)
      }
    }
    
    class Cow extends GoodAnimal with Food {
      type SuitableFood = grass.type
    }
</section>

Now we are saying that an Animal can only eat food that is suitable, we don't know what that is when we create the 
`GoodAnimal` class so we make it abstract and give it an Abstract type.

Subclasses can declare what the type is.
Notice that we can refer to the abstract type in the method eat.

Now let's try to define the feed function. We might be tempted to try using the `#` operator (type projectionn) to
access the type defined inside the `GoodAnimal` ...

<section data-slide>
#### good example, feeding time..

    def feed(animal: GoodAnimal, food: GoodAnimal#SuitableFood): Unit = {



      animal.eat(food)
    }
</section>

<section data-figure>
#### good example, wont compile!

    def feed(animal: GoodAnimal, food: GoodAnimal#SuitableFood): Unit = {
    //    OOPS cant do this it says
    //     expected animal.Suitablefood, actual:GoodAnimal#SuitableFood
    //
      animal.eat(food)
    }
</section>

It won't compile. Carefully reading the error message we see that we need `animal.Suitablefood`, notice that this is specific to this `animal` object instance!

<section data-slide>
#### good example, feeding time..
    
    //
    //
    //
    def feed1(animal: GoodAnimal, food: animal.SuitableFood): Unit = {
          animal.eat(food)
    }
</section>

<section data-figure>
#### good example, wont compile!

    // OOPs cant resolve symbol animal
    // can't re-refer to a param in same parameter list
    // type system works left to right
    def feed1(animal: GoodAnimal, food: animal.SuitableFood): Unit = {
          animal.eat(food)
    }
</section>

The problem here is that the Scala compiler's type inferencer expects to be able to resolve all types statically in a parameter list,
but when declaring `food` we don't know yet what the type of actual type of animal is, we only know its abstract supertype. 
The compiler has a rule to prevent this problem, as it says in the error, you  `can't re-refer to a param in same parameter list`

This is getting tricky. How can I use this fancy good animal?

The solution is to give the Compiler and type inference system a chance to work it out statically using another 
scala feature

### Multiple parameter lists

<section data-figure>
* We need to delay type resolution
* To give the compiler a chance to work it out 
</section>

<section data-slide>
#### good example, multi parameter list
    // 
    // 
    def feed2(animal: GoodAnimal)( food: animal.SuitableFood): Unit = {
      animal.eat(food)
    }
</section>

<section data-figure>
#### good example, multi parameter list
    // solution is add a second parameter list now type is known at call site
    // type resolution works left to right
    def feed2(animal: GoodAnimal)( food: animal.SuitableFood): Unit = {
      animal.eat(food)
    }
</section>

As shown in the previous section, by using multiple parameter lists we can use the type `animal.SuitableFood` in the second list because
the compiler will have been able to reason about the type of `GoodAnimal` in the first list from its use at the call site.

Now the bad example are impossible.

<section data-slide>
#### good example, feeding time..
    val Daisy = new Cow
    // Acceptable
    goodfeeder.feed2(Daisy)(grass)
    
    // naughty
    // 
    //
    
    // totally unacceptable. Canabalism
    //
    //
</section>

<section data-slide>
#### good example, feeding time..
    val Daisy = new Cow
    //Acceptable
    goodfeeder.feed2(Daisy)(grass)
    
    // naughty
    // wont compile says: expected Cow:SuitableFood, actual dogfood.type
    //goodfeeder.feed2(Daisy)(dogfood)
    
    //
    // 
    //
</section>

<section data-figure>
#### good example, feeding time..
    val Daisy = new Cow
    //Acceptable
    goodfeeder.feed2(Daisy)(grass)
    
    //naughty
    // wont compile says: expected Cow:SuitableFood, actual dogfood.type
    //goodfeeder.feed2(Daisy)(dogfood)
    
    //totally unacceptable. Canabalism
    // wont compile says: expected Cow:SuitableFood, actual GoodAnimal.Daisy.type
    // goodfeeder.feed2(Daisy)(Daisy)

<small>
<small>

The "multiple parameter list" feature is used all over scala and has more than one use. I found a good summary for [uses of multiple parameter lists  here on stack overflow](http://stackoverflow.com/questions/18116303/whats-the-advantage-of-using-multiple-lists-of-function-parameters).

</small>
</small>

</section>

<section data-figure> 
#### Multiple parameter lists
* Allow us to delay type resolution
* while still allowing call site inference
</section>

So far so good.

<section data-slide> 
#### How About with Type-Classes?
* 
</section>

<section data-figure> 
#### How About with Type-Classes?
* Now we are getting close to what the Aux pattern is about
</section>

You will often see this kind of code in scala libraries.

<section data-figure> 
#### implicit parameter lists (context bound sugar)

    def join[A: Monoid](a: A, b: A): A = {
      a |+| b
    }

</section>

the form `[S : T]` in the type parameter list is actually syntactic sugar, called `context bound`, for this:- 

<section data-figure> 
#### implicit parameter lists

    def join[A](a: A, b: A)(implicit ev: Monoid[A]): A = {
      a |+| b
    }
    
</section>

There is implicit evidence available that a Monaid[A] exists, and so we can use the `|+|` function from Monoid, nowing that an implicit converion to Monoid is available.

<section data-slide> 
#### What if my Typeclass has path dependent types?
* &nbsp;
* &nbsp;
* &nbsp;
</section>

<section data-slide> 
#### What if my Typeclass has path dependent types?
* can I have multiple implicit parameter lists to delay type resolution?
* &nbsp;
* &nbsp;
</section>

<section data-slide> 
#### What if my Typeclass has path dependent types?
* can I have multiple implicit parameter lists to delay type resolution?
* no.
* &nbsp;
</section>

<section data-figure> 
#### What if my Typeclass has path dependant types?
* can I have multiple implicit parameter lists to delay type resolution?
* no.
* s#1t
</section>

<section data-figure> 
#### Scala says no
* to multiple implicit parameter lists
</section>

<section data-figure>
#### my Magic Typeclass

    trait MyTypeClass[T] {
      type In
      type Out
    
      def doMagic(foo: T, param1: In): Out
    }
</section>

<section data-figure>
#### can't have stuff like this API

  def voodoo[T: MyTypeClass, In0](foo: T, sayThis: Out0 )(implicit ev: MyTypeClass.[T])(implicit out: ev.Out) : ev.Out = {
    ev.doMagic(foo, sayThis): ev.Out
  }
</section>

not only are there too many implicit param lists but we also have no way to tie the `In0` type to `ev.In`

<section data-figure> 
#### Aux to the rescue
* we can create a type alias to capture/keep track of the types
</section>

<section data-figure> 
#### Aux to the rescue

    object MyTypeClass {
    //aux pattern
    type Aux[T0, In0, Out0] = MyTypeClass[T0] {type In = In0; type Out = Out0}
    
    // convenience Summoner so I don't need to use instead of `implicitly` 
    def apply[T](implicit evidence: MyTypeClass[T]): Aux[T, evidence.In, evidence.Out] = evidence
    }
</section>

So we create a type alias to my type, that allows all the path dependent types to be seen on the outside.

We also create a handy typeclass summoner that an be used instead of implitly when we need it.

<section data-figure> 
#### Aux to the rescue
* interestingly, when we bind In0 at a call site that also binds the inner type In.
* `=` in the `type` alias is like mathematical equality. 
* so if `In0` = apple, and `type In = In0`, then 
* `type In = apple`
</section>

<section data-figure> 
#### so we can do stuff like this ..
    case class Greeter(name: String) {
    
      def greeting(greeting: String): String = {
        s"$greeting, $name"
      }
    }
    
    case object ImAnAlien {
    
      @tailrec
      private def sayThis(thing: String, accumlator: String, numTimes: Int): String = numTimes match {
        //base case
        case 0 => accumlator
        //recurse
        case _ => sayThis(thing, accumlator + " " + thing, (numTimes - 1))
    
      }
    
      def say(num: Int): String = {
        sayThis("I'm an Alien", "", num)
      }
    }
</section>

<section data-figure>
* two differnt classes but if you squint....

    def foo[A,B](a:A):B 

* so I can make them conform to MyTypeclass
</section>

<section data-figure>
    object MyTypeClass { 
      //aux pattern
      type Aux[T0, In0, Out0] = MyTypeClass[T0] {type In = In0; type Out = Out0}
    
      // known type class members
      implicit val greeterToTypeclass: Aux[Greeter, String, String] = new MyTypeClass[Greeter] {
        type In = String
        type Out = String
    
        override def doMagic(foo: Greeter, param1: In): Out = foo.greeting(param1)
      }
    
      implicit val imAnAlienToTypeclass: Aux[ImAnAlien.type, Int, String] = new MyTypeClass[ImAnAlien.type] {
        type In = Int
        type Out = String
    
        override def doMagic(foo: ImAnAlien.type, param1: In): Out = foo.say(param1)
      }   
    }
</section>

<section data-figure> 
#### fancy API ...
    object SomeApi {
      def voodoo[T, In0, Out0](foo: T, sayThis: In0)(implicit ev: MyTypeClass.Aux[T, In0, Out0]): Out0 = {
        val tc = MyTypeClass[T]
        tc.doMagic(foo, sayThis)
        ev.doMagic(foo, sayThis)
      }
    }

* use it:-


    //bring typeclass instance into scope
    import MyTypeClass._
    import SomeApi._
    
    println("Greeting:- ")
    println(voodoo(Greeter("karl"), "wassup"))
    
    println("\nAliens:- ")
    println(voodoo(ImAnAlien, 3))

</section>

<section data-figure>
    Greeting:- 
    wassup, karl
    
    Aliens:- 
     I'm an Alien I'm an Alien I'm an Alien

</section>

<section data-slide>
#### But why that Summoner? 
* &nbsp;

</section>

<section data-slide>
#### But why that Summoner? 
* because implicitly will loose type information that we may want to use again 

</section>

<section data-figure>
#### But why that Summoner? 
* because implicitly will loose type information that we may want to use again 
``` scala
import shapeless.{HList, ::, HNil}
import shapeless.ops.hlist.Last

//use the implicitly
implicitly[Last[String :: Int :: HNil]]
// res6: shapeless.ops.hlist.Last[shapeless.::[String,shapeless.::[Int,shapeless.HNil]]] =shapeless.ops.hlist$Last$$anon$34@20bd5df0

// use the summoner
Last[String :: Int :: HNil]
// res7: shapeless.ops.hlist.Last\
// [shapeless.::[String,shapeless.::[Int,shapeless.HNil]]]{type Out = Int} =shapeless.ops.hlist$Last$$anon$34@4ac2f6f
```
</section>

Notice that with `implicitly` we loose information that `Out` is `Int`


<section data-figure>
#### so this makes sense now, right?

    object IsHCons {
      def apply[L <: HList](implicit isHCons: IsHCons[L]): Aux[L, isHCons.H, isHCons.T] = isHCons
   
      type Aux[L <: HList, H0, T0 <: HList] = IsHCons[L] { type H = H0; type T = T0 }

      implicit def hlistIsHCons[H0, T0 <: HList]: Aux[H0 :: T0, H0, T0] =
        new IsHCons[H0 :: T0] {
          type H = H0
          type T = T0
   
          def head(l : H0 :: T0) : H = l.head
          def tail(l : H0 :: T0) : T = l.tail
          def cons(h : H0, t : T0) : H0 :: T0 = h :: t
        }
    }
</section>

We can now see that we have an `Aux` type that promotes the `HCons`'s abstrat types for head and tail of the HList, `H` and `T` into type parameters so they can be captured or bound.

We provide an implict function to produce an Aux tpe when needed that uses the IsHCons typeclass and fills in or binds the H and T to the type parameters in the Aux. and we also provide a summoner method to fetch the Aux from the  implicit scope if it is available, ie if there is an IsHCons implicity available that matches the desired type parameters.

<section data-figure>
#### Finally....

* This will hopefully all go away
* see [miles sabin sugests a fix in multiple param lists
](https://github.com/scala/scala/pull/5108)
* see [pull req sip 520](https://github.com/scala/scala.github.com/pull/520/files/e4e08a8fb3734d9fc992a7cf2a48ede9c54cfe14)

</section>

It seems that they compiler restriction to prevent multiple implicit parameter lists is simply a syntactic sugar restriction.
Miles Sabin, the initiator of the Shapeless library has proposed a change to remove the restriction, which looks like it will get accepted into a future version of Scala.

So while many use cases of the Aux pattern will be able to be expressed at the call site in terms of multiple implicit parameter lists, the Aux pattern is still a useful object lesson in how to use the type system to gain access to the Abstract types defined inside other types which could still be useful to keep the API of a library simple.

<section data-figure>
#### Thanks....

* code used at https://bitbucket.org/karl_roberts/typefubar
* deck and talk @ http://talks.aws.owtelse.com/scalasyd/2017/04/auxpattern/index.html?mode=doc#slide-0
* me @MrK4rl
* ref [The Type Astronaut's Guide to Shapeless http://underscore.io/books/shapeless-guide/](http://underscore.io/books/shapeless-guide/)
</section>
