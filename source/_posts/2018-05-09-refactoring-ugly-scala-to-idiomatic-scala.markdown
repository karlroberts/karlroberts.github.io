---
layout: post
title: "Refactoring Ugly Scala to Idiomatic Scala"
date: 2018-05-09 22:06:35 +0000
comments: true
published: true
categories:
- suited.js
- Scala
- idomatic
- scalasyd
keywords:
- suited.js
---

This Blog is my (#Scalasyd)[https://github.com/scalasyd/scalasyd] talk about refactoring Scala code to be more idiomatic <!-- more -->

<small>It is also a slide deck for the talk given at the ScalaSyd meetup May 2018.<br/>
To switch between modes press a number as follows :<br/>

* '1' -&gt; Doc mode: 
  - shows the document as intended.
* '2' -&gt; Deck mode, see the slides
  - see the slides
* '4' -&gt; Lecture Mode
  - enter zooms current navigated to section
  - click zooms div or block clicked

Arrow keys navigate to next or previous section or slide
</small>

<section data-slide>
  <h1 align="center">Refactor</h1>
  <h2 align="center">Ugly Scala Code</h2>
  <div align="center">
    <span>9th May 2018</span>
  </div>
  <h4>&nbsp;</h4>
  <h3>Code Weaver</h3>
  <div style="height:100px"></div>
  <div>
    <a href="http://www.codeweaver.com.au">
      <img src="/images/codeweaver/Volleyball_Interchange_Diagram.gif" style="max-height: 200px" alt="Code Weaver Logo example"/>
      <!-- image by By VidTheKid at en.wikipedia (Transferred from en.wikipedia by SreeBot) [Public domain], via Wikimedia Commons -->
    </a>
  </div>
  <h5>&nbsp;</h5>
  <h3>By</h3>
  <h5>[Karl Roberts](http://karlcode.owtelse.com/)</h5>
  <h5>[@MrK4rl](https://twitter.com/MrK4rl)</h5>
  <div style="margin-top:100px; text-align: center;">
    <small><small>To present this document press <code>2</code>. Press <code>Esc</code> to get back to document view. Left and Right arrow keys to navigate.
        See <a href="http://github.com/suited">suited.js</a>
    </small></small>
  </div>

</section>

In this blog I'll be talking about working with Scala to build applications.

<section data-figure>
#### Demo code
* can be found at the link below
* [https://github.com/karlroberts/scalasydUglyCode](https://github.com/karlroberts/scalasydUglyCode)

</section>

<section data-figure>
#### Confession
* First I need to admit to a dirty little secret I've been keeping...

</section>

<section data-slide>
### The Ugly Truth
* &nbsp;
* &nbsp;
* &nbsp;

</section>

<section data-slide>
### The Ugly Truth
* It can be easier to hack away in an imperative style
* &nbsp;
* &nbsp;

</section>

<section data-slide>
### The Ugly Truth
* It can be easier to hack away in an imperative style
* Especially when hacking on a new Java API
* &nbsp;

</section>

<section data-figure>
### The Ugly Truth
* It can be easier to hack away in an imperative style
* Especially when hacking on a new Java API
* Or noodling around to get an understanding

</section>

<section data-slide>
### The Excuses?
* &nbsp;
* &nbsp;
  - &nbsp;
  - &nbsp;
* &nbsp;

</section>

<section data-slide>
### The Excuses?
* Thinking in Java
* &nbsp;
  &nbsp;
  - &nbsp;
  - &nbsp;
* &nbsp;

</section>

<section data-slide>
### The Excuses?
* Thinking in Java
* looping in loops 
  - helps walk or build a data structure
  - while I'm developing it
* &nbsp;

</section>

I have a bunch of justifications for this behaviour they may not be good excuses but here they are.

<section data-figure>
### The Excuses?
* Thinking in Java
* looping in loops 
  - helps walk or build a data structure
  - while I'm developing it
* Types get in the way less

</section>

<section data-slide>
### The Problem?
* Sneaky Bugs can exist
  - &nbsp;
* Hard to test pieces in isolation
* Hard to understand later or refactor?
  - &nbsp;
* &nbsp;

</section>

<section data-slide>
### The Problem?
* Sneaky Bugs can exist
  - especially in the edge cases
* Hard to test pieces in isolation
* Hard to understand later or refactor?
  - &nbsp;
* &nbsp;

</section>

<section data-slide>
### The Problem?
* Sneaky Bugs can exist
  - especially in the edge cases
* Hard to test pieces in isolation
* Hard to understand later or refactor?
  - you may forget to take account of some out of view mutation
* &nbsp;

</section>

<section data-figure>
### The Problem?
* Sneaky Bugs can exist
  - especially in the edge cases
* Hard to test pieces in isolation
* Hard to understand later or refactor?
  - you may forget to take account of some out of view mutation
* Gives me the creeps.

</section>

The code written in the style, that you are going to see, runs ok (I think) but I am always wary of it, because I know how hard I had to work to get it running.
Coding it was a trial and error affair, with contant compiling and running and attaching debuggers to test what was happening to my mutable placeholders.

The trick is to refactor it to a more imutable functional style as soon as it is "working".

It is always best to refactor runnable code because we can see that the refactor caused no disernable difference to the outcome by simple running it.

Tests help of course, but the problem with testing mutable sections of code is that you have to test from the outside, as alluded to above it is hard to test an isolated fragment to see if it works.

<section data-figure>
### The Solution?
* Once Running Refactor
  - while you still understand the problem
* Remove mutation
* Remove loops
* Learn the API you are working in
  - it may well have realy helpful methods/functions for you to use.
* Discover nice general patterns

</section>

<section data-figure>
### My Example?
##### [source code location](https://github.com/karlroberts/scalasydUglyCode/blob/start/src/main/scala/historicprices/provider/api.scala)

<img src="/images/codeweaver/uglycode/start.png" style="max-width: 80%" alt="api doc for List"/>

</section>

This code is extracted from a Crypto currency tool I wrote to help me keep track of my position on coinspot.

Unfortunatly at the time coinspot api did not allow me to get all the data from them so I needed to extract my trade history as csv,
parse it and build up a data structure to allow me to query my position and other useful info.

Using my Position data structure I can see what currencies I'm making money in and ask questions ike "how much bitcoin did I buy below this price?"

The big problem solved above is that the trade history showed prices for cross trades in terms of each other eg bought 1.2 ETH for .05 BTC but I want to know my 
position in AUD for each currency, so I was forced to look to the internet for historical prices of the coins in AUD at the price of the time of the trade to work backwards.

Here you can see I have a list of previously known prices from which I build up a `PriceTable` which is a `Map` of `PriceTableForCurrency`.

This is really a big map of maps. The caller of this function (in this case the main function) saves the newly discovered prices to a file that I read and parse on start-up to contruct my known prices List.

In short what I need to do is:-

<section data-slide>
### PriceTable
* I need to build up a PriceTable for Currencies.
  - &nbsp;
* &nbsp;
  - &nbsp;
  - &nbsp;

</section>

<section data-slide>
### PriceTable
* I need to build up a PriceTable for Currencies.
  - A Map of Maps
* &nbsp;
  - &nbsp;
  - &nbsp;

</section>

<section data-slide>
### PriceTable
* I need to build up a PriceTable for Currencies.
  - A Map of Maps
* So I can
  - &nbsp;
  - &nbsp;

</section>

<section data-slide>
### PriceTable
* I need to build up a PriceTable for Currencies.
  - A Map of Maps
* So I can
  - look up a currency and
  - &nbsp;

</section>

<section data-figure>
### Build a PriceTable
* I need to build up a PriceTable for Currencies.
  - A Map of Maps
* So I can
  - look up a currency and
  - from there look up a price a date I care about

</section>

For context you should know that to help me work around the Map of Maps in the imperative style I created a few type aliases and helper classes to make it easier to reason about, the main structures are as follows:-

<section data-figure>
### PriceTable

    // a type alias
    type PriceTable = Map[Currency, PriceTableForCurrency]

</section>

Here `PriceTableForCurrency` is just a `case class` that wraps a `Map` but has a helpful API that allows me to augment it and build it up from `HistoricPrice` objects
which I get from parsing the CSV file of previously discovered historic prices.

<section data-figure>
### PriceTableForCurrency
##### [source code location](https://github.com/karlroberts/scalasydUglyCode/blob/start/src/main/scala/historicprices/provider/api.scala)

    case class PriceTableForCurrency(currency: Currency, prices: Map[LocalDateTime,Double]) {
      /**
        * Will overwrite if we alredy have a price at this time
        * @param historicPrice
        * @return
        */
      def +=(historicPrice: HistoricPrice) = {
        val hp = (historicPrice.localDateTime, historicPrice.quotePrice)
        this.copy(prices = prices + hp)
      }
      def ++=(other:PriceTableForCurrency) = if(other.currency == currency) this.copy(prices = prices ++ other.prices) else this

      def asHistoricPrices: List[HistoricPrice] = {
        import scala.collection.mutable.ListBuffer
        val lb = ListBuffer[HistoricPrice]()
        prices.foreach(tup => {
          lb += HistoricPrice(tup._1,currency,tup._2)
        })
        lb.toList
      }
    }

</section>


<section data-slide>
### My Example - quick re-read for context
##### [source code location](https://github.com/karlroberts/scalasydUglyCode/blob/start/src/main/scala/historicprices/provider/api.scala)

<img src="/images/codeweaver/uglycode/start.png" style="max-width: 80%" alt="api doc for List"/>

</section>

The first part I want to look at is building up the initial `PriceTable` (effectivly a Map of Maps) from the known prices list, which I read in from a CSV file.

Building a Map of Maps is something that I do a lot while coding, and it is a pain every time.

Walking a list and examining the Map to see if I have the Key in the map already and adding it and a value if I don't have it or modifying the value if I do have it is tedious for a single Map. It is exponentially more tedious and error prone for each level of nested Map.

If only there was a better way.

<section data-slide>
### Lets create a better Map of Maps
##### [Api docs for Map](https://www.scala-lang.org/api/2.12.2/scala/collection/mutable/Map$.html)

* We can contruct a Map like this:

    val myMap = Map("a" -> "little A", "b" -> "little B")

* &nbsp;
* &nbsp;
  - &nbsp;

&nbsp;

</section>

<section data-slide>
### Lets create a better Map of Maps
##### [Api docs for Map](https://www.scala-lang.org/api/2.12.2/scala/collection/mutable/Map$.html)

* We can contruct a Map like this:

    val myMap = Map("a" -> "little A", "b" -> "little B")

* The -> is a function that create a Tuple
* &nbsp;
  - &nbsp;

&nbsp;

</section>

<section data-slide>
### Lets create a better Map of Maps
##### [Api docs for Map](https://www.scala-lang.org/api/2.12.2/scala/collection/mutable/Map$.html)

* We can contruct a Map like this:

    val myMap = Map("a" -> "little A", "b" -> "little B")

* The -> is a function that create a Tuple
* and so this is like building a Map from a list of Tuples
  - ie (Key, Value) pairs

&nbsp;

</section>


<section data-figure>
### Lets create a better Map of Maps
##### [Api docs for Map](https://www.scala-lang.org/api/2.12.2/scala/collection/mutable/Map$.html)

* We can contruct a Map like this:

    val myMap = Map("a" -> "little A", "b" -> "little B")

* The -> is a function that create a Tuple
* and so this is like building a Map from a list of Tuples
  - ie (Key, Value) pairs

<img src="/images/codeweaver/uglycode/map-api-doc.png" style="max-width: 80%" alt="api doc for map"/>

</section>

This makes sense. A `Map` can be thought of as a list of Key and Value pairs.

So if I can convert my `List` into a list of Key/Value pairs, ie a `Tuple2` or `(Key,Value)`,
I should be able to turn it into a Map.

<section data-slide>
### Lets create a better Map of Maps
##### [Api docs for List](https://www.scala-lang.org/api/2.12.2/scala/collection/immutable/List.html#toMap[T,U]:scala.collection.Map[T,U])

* If only there was a way to turn a list of tuples into a Map

* &nbsp;

</section>

<section data-figure>
### Lets create a better Map of Maps
##### [Api docs for List](https://www.scala-lang.org/api/2.12.2/scala/collection/immutable/List.html#toMap[T,U]:scala.collection.Map[T,U])

* If only there was a way to turn a list of tuples into a Map

* <img src="/images/codeweaver/uglycode/list-api-1.png" style="max-width: 80%" alt="api doc for List"/>

</section>

Awesome. I can do it using the standard library.

<section data-slide>
### Lets create a better Map of Maps
##### [Api docs for List](https://www.scala-lang.org/api/2.12.2/scala/collection/immutable/List.html)

* So we can build a map from a list but what about a `Map` of `Maps`?
* &nbsp;

* &nbsp;

</section>

<section data-slide>
### Lets create a better Map of Maps
##### [Api docs for List](https://www.scala-lang.org/api/2.12.2/scala/collection/immutable/List.html)

* So we can build a `Map` from a list but what about a `Map` of `Maps`?
* If only there was a way to group list items by some attribute

* &nbsp;

</section>

<section data-figure>
### Lets create a better Map of Maps
##### [Api docs for List](https://www.scala-lang.org/api/2.12.2/scala/collection/immutable/List.html)

* So we can build a `Map` from a list but what about a `Map` of `Maps`?
* If only there was a way to group list items by some attribute

* <img src="/images/codeweaver/uglycode/list-api-2.png" style="max-width: 80%" alt="api doc for List"/>

</section>

Mmm. This is giving me a clue. Maybe I can refactor this.

<section data-figure>
### Lets create a better Map of Maps
##### [Api docs for List](https://www.scala-lang.org/api/2.12.2/scala/collection/immutable/List.html)

* So this is cool we an turn a `List` of `Tuple2` into a `Map`
* We can also group a `List` into a `Map` with a `List` as its values

* So if the value `List` could be transformed into a Tuple
  - we have th building blocks for a Map of Maps
</section>

This is good I'm getting a raging clue now.
 
<section data-figure>
###### Lets do it - fix Map of Maps trial 1
* git checkout start_1

</section>

<section data-figure>
###### Lets do it - fix Map of Maps trail 2
* git checkout start_2

</section>

<section data-figure>
###### Lets do it - fixed Map of Maps 
* git checkout start_3

</section>

That was great. Now I have a functional tool to construct maps and maps of maps.

    List.groupBy

### Now fix the ugly foreach

Ok now that is done lets look at the ugle walk of the xtrades (cross trades) list using foreach.

While its better than a forloop (which could adds another possible iteration bug) the body of the foreach is convoluted.
The problem is that it is doing too many things at once.

I need to break it down into smaller problems which will not only make it easier to test and debug but will structure the code around clearer thinking.


<section data-slide>
### Lets fix that ugly foreach

* Instead of trying to do 3 things
  - &nbsp;
  - &nbsp;
  - &nbsp;
    - &nbsp;
    - &nbsp;
    - &nbsp;

</section>

<section data-slide>
### Lets fix that ugly foreach

* Instead of trying to do 3 things
  - walk trades looking for a historic price miss
  - &nbsp;
  - &nbsp;
    - &nbsp;
    - &nbsp;
    - &nbsp;

</section>

<section data-slide>
### Lets fix that ugly foreach: 

* Instead of trying to do 3 things
  - walk trades looking for a historic price miss
  - fetch the new historic price
  - &nbsp;
    - &nbsp;
    - &nbsp;
    - &nbsp;

</section>

<section data-slide>
### Lets fix that ugly foreach: 

* Instead of trying to do 3 things
  - walk trades looking for a historic price miss
  - fetch the new historic price
  - add it to Map of Maps
    - &nbsp;
    - &nbsp;
    - &nbsp;

</section>

<section data-slide>
### Lets fix that ugly foreach: 

* Instead of trying to do 3 things
  - walk trades looking for a historic price miss
  - fetch the new historic price
  - add it to Map of Maps
    - looking out to see if we have the key or not first
    - &nbsp; 
    - &nbsp;

</section>

<section data-slide>
### Lets fix that ugly foreach: 

* Instead of trying to do 3 things
  - walk trades looking for a historic price miss
  - fetch the new historic price
  - add it to Map of Maps
    - looking out to see if we have the key or not first
    - and if not adding else just adding 
    - &nbsp;

</section>

<section data-figure>
### Lets fix that ugly foreach: 

* Instead of trying to do 3 things
  - walk trades looking for a historic price miss
  - fetch the new historic price
  - add it to Map of Maps
    - looking out to see if we have the key or not first
    - and if not adding else just adding 
    - again looking to see if we have the nested key etc..

</section>

<section data-slide>
### Lets fix that ugly foreach - why not this?
* &nbsp;
  - &nbsp;
* &nbsp;
* &nbsp;

</section>

<section data-slide>
### Lets fix that ugly foreach - why not this?
* Filter the list of trades
  - &nbsp;
* &nbsp;
* &nbsp;

</section>

<section data-slide>
### Lets fix that ugly foreach - why not this?
* Filter the list of trades
  - to create a List of trades that dont have a price
* &nbsp;
* &nbsp;

</section>

<section data-figure>
### Lets fix that ugly foreach - why not this?
* Filter the list of trades
  - to create a List of trades that dont have a price
* Then just get them
* I can worry about how to stuff the new prices in the `PriceTable` later

</section>


<section data-figure>
#### Lets do it 
* git checkout start_4

</section>

That was simple. As a side benefit, now I am not iterativley Building the lists and Maps, I can get rid of all the `var` placeholder `Maps` and `Buffers`

A close look at the the code shows that I was able to stuff the new prices into the imutable `PriceTable` by folding down the new prices.

<section data-figure>
#### Add to imutable `PriceTable`
* use a fold
* have the starting accumulator be the current `PriceTable`

<img src="/images/codeweaver/uglycode/fold-prices.png" style="max-width: 80%" alt="api doc for List"/>

</section>

Ok 

<section data-slide>
### so ...?

* We've tidied most of it up
  - by mapping and filtering and folding we dont need `var` placeholders anymore
* &nbsp;

* &nbsp;
* &nbsp;
  - &nbsp;

</section>

<section data-slide>
### so ...?

* We've tidied most of it up
  - by mapping and filtering and folding we dont need `var` placeholders anymore
* Can I get onto the fun stuff?

* &nbsp;
* &nbsp;
  - &nbsp;

</section>

<section data-slide>
### so can I prematurely optimize yet?

* We've tidied most of it up
  - by mapping and filtering and folding we dont need `var` placeholders anymore
* Can I get onto the fun stuff?

* so can i tune it up a bit?
* &nbsp;
  - &nbsp;

</section>

So now the code is tidy and manageble, is it time for me to speed up that slow price fetch from the internet?

<section data-figure>
### so can I prematurely optimize yet?

* We've tidied most of it up
  - by mapping and filtering and folding we dont need `var` placeholders anymore
* Can I get onto the fun stuff?

* Can i tune it up a bit?
* Yes by fetching in parallel.
  - which is now trivial as I have simple collections to work with.

</section>

<section data-figure>
### so can I prematurely optimize yet?

* I will use `scalaz` Task
* to wrap the get historic prices function
* and return a List[Task[PriceTableForCurrency]]
* rather than a List[PriceTableForCurrency]
* then gather all the tasks in parallel
* to give me back a List[PriceTableForCurrency]

</section>


<section data-figure>
###### Lets do it 
    $ git checkout start_5
    $ # clear out the existing prefetched prices
    $ cat /dev/null >  $HOME/uglycode/coinspotpos/historicPrices.csv
    $ sbt clean run

</section>

So lets have a look at how much tidier the code is now.

<section data-figure>
### Ugly?
##### [source code location](https://github.com/karlroberts/scalasydUglyCode/blob/start/src/main/scala/historicprices/provider/api.scala)

<img src="/images/codeweaver/uglycode/start.png" style="max-width: 80%" alt="api doc for List"/>

</section>

<section data-figure>
### Pretty?
##### [source code location](https://github.com/karlroberts/scalasydUglyCode/blob/finish/src/main/scala/historicprices/provider/api.scala)

<img src="/images/codeweaver/uglycode/pretty.png" style="max-width: 80%" alt="api doc for List"/>

</section>

Nice.

<section data-slide>
#### The End

</section>

<section data-figure>
#### Thanks ....

* me @MrK4rl

* code used in demo [https://github.com/karlroberts/scalasydUglyCode](https://github.com/karlroberts/scalasydUglyCode)
* deck and talk (http://karlcode.owtelse.com/blog/2018/05/09/refactoring-ugly-scala-to-idiomatic-scala/?mode=deck#slide-0)
* blog (http://karlcode.owtelse.com/blog/2018/05/09/refactoring-ugly-scala-to-idiomatic-scala/?mode=doc#slide-0)

</section>




