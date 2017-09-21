---
published: true
layout: post
title: "ScalaJs markdown combinator parser"
date: 2017-07-09 18:20:05 +0000
comments: true
categories:
- suited.js
- SclalaJs
keywords:
- suited.js
---

This Blog is about Scala Combinator Parsers but excitingly about compiling the Scala to JavaScript using Scala.js. <!-- more -->

<small>It is also a slide deck for a talk given at the ScalaSyd meetup Sept 2017.<br/>
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
  <h1 align="center">A Markdown combinator parser in</h1>
  <h2 align="center">Scala</h2>
  <div align="center">
    <span>13th September 2017</span>
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

<section data-slide>
  <h1 align="center">A Markdown combinator parser in</h1>
  <h2 align="center">Scala.js</h2>
  <div align="center">
    <span>13th September 2017</span>
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

This Blog is my talk for ScalaSyd meetup on September 13th 2017. It is about Scala combinator parsers and Scala.js <!-- more -->

<section data-slide>
### Intro
* This talk is about Scala
  - &nbsp;
  - &nbsp;
  - &nbsp;

</section>

<section data-slide>
### Intro
* This talk is about Scala.js
  - &nbsp;
  - &nbsp;
  - &nbsp;

</section>

<section data-slide>
### Intro
* This talk is about Scala.js
  - Combinator Parsing
  - &nbsp;
  - &nbsp;

</section>

<section data-slide>
### Intro
* This talk is about Scala.js
  - Combinator Parsing
  - Markdown
  - &nbsp;

</section>

<section data-figure>
### Intro
* This talk is about Scala.js
  - Combinator Parsing
  - Markdown
  - suited.js

</section>


Before diving into nitty-gritty details it's helpful to explain my motivation for this.


<section data-slide>
### Why?
* &nbsp;
  - &nbsp;
  - &nbsp;
* &nbsp;
* &nbsp;
  - &nbsp;
* &nbsp;
  - &nbsp;
</section>

<section data-slide>
### Why?
* LambdaJam 2017
  - &nbsp;
  - &nbsp;
* &nbsp;
* &nbsp;
  - &nbsp;
* &nbsp;
  - &nbsp;
</section>

<section data-slide>
### Why?
* LambdaJam 2017
  - compile all the things to other languages
  - &nbsp;
* &nbsp;
* &nbsp;
  - &nbsp;
* &nbsp;
  - &nbsp;
</section>

<section data-slide>
### Why?
* LambdaJam 2017
  - compile all the things to other languages
  - treat javascript like assembly lang for the web
* &nbsp;
* &nbsp;
  - &nbsp;
* &nbsp;
  - &nbsp;
</section>

<section data-slide>
### Why?
* LambdaJam 2017
  - compile all the things to other languages
  - treat javascript like assembly lang for the web
* Wanted to explore Scala.js
* &nbsp;
  - &nbsp;
* &nbsp;
  - &nbsp;
</section>

<section data-slide>
### Why?
* LambdaJam 2017
  - compile all the things to other languages
  - treat javascript like assembly lang for the web
* Wanted to explore Scala.js
* I needed yet another partial project
  - &nbsp;
* &nbsp;
  - &nbsp;
</section>

<section data-slide>
### Why?
* LambdaJam 2017
  - compile all the things to other languages
  - treat javascript like assembly lang for the web
* Wanted to explore Scala.js
* I needed yet another partial project
  - devs seem to like starting projects
* &nbsp;
  - &nbsp;
</section>

<section data-slide>
### Why?
* LambdaJam 2017
  - compile all the things to other languages
  - treat javascript like assembly lang for the web
* Wanted to explore Scala.js
* I needed yet another partial project
  - devs seem to like starting projects
* I had too much time on my hands one day.
  - &nbsp;
</section>

<section data-figure>
### Why?
* LambdaJam 2017
  - compile all the things to other languages
  - treat javascript like assembly lang for the web
* Wanted to explore Scala.js
* I needed yet another partial project
  - devs seem to like starting projects
* I had too much time on my hands one day.
  - solved!
</section>

So apart from getting down with all the transpiling kool kids I actually have a need to do some JavaScript jiggery-pokery.

<section data-slide>
### What?
* This talk is presented using [suited.js](https://github.com/suited)
  - a JavaScript library 
  - Allows a single document to render as page or slide deck
    - &nbsp;
    - &nbsp;
</section>

<section data-slide>
### What?
* This talk is presented using [suited.js](https://github.com/suited)
  - a JavaScript library 
  - Allows a single document to render as page or slide deck
    - this slide deck is actually my in blog
    - &nbsp;
</section>

<section data-figure>
### What?
* This talk is presented using [suited.js](https://github.com/suited)
  - a JavaScript library 
  - Allows a single document to render as page or slide deck
    - this slide deck is actually my in blog
    - hint: hit key 1,2 or 4 for fun
      - mode 4 will zoom on `enter` or click
</section>

<section data-figure>
### [suited.js](https://github.com/suited)
* was written by [Dirk](http://pappanyn.me/) and [myself](http://karlcode.owtelse.com/)
  - a small library 
  - uses no other js lib
* event driven
* plugin architecture

</section>

<section data-slide>
### [suited.js](https://github.com/suited)
* but then we wanted markdown
</section>

Suited is cool and I've given many talks using it and the same document can be a blog or article too.
But we always want it to do more for instance we wanted to write out talks in markdown.

So we needed a markdown plugin, but we also wanted a magic syntax to add slides and figures in markdown,
Suited.js uses `<section data-figure>` and `<section data-slide>` to mark out sections of the contents to appear as navigable
sections. Slides are just visible in the slide show whereas figures are visible in doc mode and also in the slide show.

<section data-figure>
### markdown slides
    
    ~~* **your bold stuff** *~~

</section>

<section data-figure>
### markdown figures
    
    ~~: **your bold and _italic_ stuff** :~~

</section>

So we implemented a markdown plugin, but delegated to markdown-it.

But suited has a fatal flaw. It has no parser to implement fragments

<section data-figure>
### suited.js
* Fragments are no fun
</section>

<section data-figure>
### fragments
```
<section data-slide>
### Why?
* &amp;nbsp;
  - &amp;nbsp;
</section>

<section data-slide>
### Why?
* because
  - &amp;nbsp;
</section>

<section data-figure>
### Why?
* because
  - it's like that!
</section>
```
</section>

<section data-figure>
### markdown-it plugin?
* I dont want to write another markdownit plugin
* especially a complex one 
  - it will probably add javascript to the markup
</section>

<section data-figure>
### so I wrote my own markdown parser for Javascript?
* Using Scala.js
* how hard can it be?
</section>

Because I want to rely on a few libraries as possible while experimenting with Scala.js I decided to use
Mark Hibberd's Combinator Parser [demo code](github.com/markhibberd/dont-fear-the-parser) from his previous
Scalasyd talk ["Dont fear the parser"](http://mth.io/talks/dont-fear-the-parser/) as a starting point.

<section data-figure>
### [Parser recap](https://github.com/markhibberd/dont-fear-the-parser)

    case class Parser[A](run: String => ParseState[A])
 
</section>

<section data-figure>
### Parser recap

```scala
sealed trait ParseState[A]

case class ParseOk[A](input: String, value: A) extends ParseState[A]
case class ParseKo[A](message: String) extends ParseState[A]
```

</section>

Parsing is OK but I also want to render the parse tree into HTML, this is what Transformers are for.

<section data-figure>
### Transformer typeclass

```scala
trait Transformer[T] {
  type IN
  type OUT

  def run(t: T, in: IN): OUT
}
``` 
</section>

<section data-figure>
### Syntax pimp and [Aux Pattern](http://karlcode.owtelse.com/blog/2017/04/11/the-rise-and-hopefully-fall-of-the-aux-pattern-2/?mode=doc#slide-0) 

```scala
// syntax pimps
implicit class TransformerOps[T0](foo: T0) {

  /**
   * magic wand. pimp alias of Transformer.run eg a transform function
   */
  def ---*[A,B](bar: A)(implicit aux: Transformer.Aux[T0,A,B]) : B = {
    aux.run(foo, bar)
  }
  ...
}
```

</section>


See my previous talk on the [Aux Pattern](http://karlcode.owtelse.com/blog/2017/04/11/the-rise-and-hopefully-fall-of-the-aux-pattern-2/?mode=doc#slide-0)

Now lets look at a specific member of the Transformer typeclass. The `MarkdownToHtml` transformer.

I wanted to split the transform function into two parts, one to parse, and of course I want to use my markdown parser's run  function in this place, and one to render the `ParseResult` into HTML.

Not only does this make it easier to reason about but also (I Hope) easier to build a plugin interface where you can supply a function to parse modified markdown as long as it still produces a `ParseResult[Markdown]` and one to enrich the HTML or even transform it completely, say into rich text or PDF

<section data-figure>
### MarkdownToHtml

```scala
case class MarkdownToHtml(
    p: String => ParseState[MarkdownDoc],
    r: ParseState[MarkdownDoc] => Html)
```

* notice I've split it into 2 functions
  - one to parse, p
  - and one to render, r

</section>

<section data-figure>
### [MarkdownToHtml](https://github.com/karlroberts/scalasyd-markdownem/blob/master/src/main/scala/transformers/MarkdownToHtml.scala#L76)
##### use `instance` to join the Transformer typeclass
```scala
object MarkdownToHtml {
  import Transformer._
  import ast._

  // Use `instance` typeclass constructor to add MarkdownToHtml to the Transformer typeclass
  implicit val m2hTransformer:
     Transformer.Aux[MarkdownToHtml,String, parser.Html] =
       instance( (t, in) => t.r(t.p(in)) ) 
  ...
}
```
</section>
see [MarkdownToHtml](https://github.com/karlroberts/scalasyd-markdownem/blob/master/src/main/scala/transformers/MarkdownToHtml.scala#L76)

<section data-figure>
### MarkdownToHtml `---*` function
* Now MarkdownToHtml is in the Transformer typeclass
  - It has access to the transformer Magic Wand function
  - so my [`simple` implementation](https://github.com/karlroberts/scalasyd-markdownem/blob/master/src/main/scala/transformers/MarkdownToHtml.scala#L87)  can use it like so 

```
simple ---* """## this is h2 i presume"""
```
</section>




<section data-slide>
# 
### Demo~~lition~~ time

* Scala parser and render in the sbt console
</section>

So let's demonstrate the parser and renderer in the console.

<section data-figure>
### Demo parser: start console

    me@host $ sbt
    sbt:Markdownem> console
    scala> :paste consoleimports.txt
    Pasting file consoleimports.txt...
    import parser._
    import parser.markdownParser._
    import transformers._
    import transformers.Transformer._
    import transformers.MarkdownToHtml._

</section>

Notice that 

```
[warn] Scala REPL doesn't work with Scala.js. You are running a JVM REPL.
```

The Scala REPL is only available to the Scala code. So only code built without depending on 
JavaScript libraries will work in this REPL demo.

But that's OK, this demo has no JavaScript dependencies, it just generate JavaScript output.

<section data-figure>
### Demo headerParser
```
scala> headerParser.run("""## this is h2 i presume""")

```

```
res0: parser.ParseState[ast.Markdown] =
  ParseOk(,H2(List(this is h2 i presume)))

```
</section>

<section data-figure>
### Demo headerParser
```
scala> headerParser.run("""## this is h2 i presume
     | more input not in header""")

```

The header parser just parses a single header.
```
res3: parser.ParseState[ast.Markdown] =
  ParseOk(more input not in header,
    H2(List(this is h2 i presume)))

```
</section>

Notice that this is a successful parse, and that the `ParseOK` case class also contains the remaining input for further processing

Also notice that the H2 contains a List of more Markdown, in this case `rawHtml`.
This is because the link text could contain more inline markdown, like so...

<section data-figure>
### Demo headerParser
```
scala> headerParser.run("""## this _is_ h2 i **presume**""")

```

```
res1: parser.ParseState[ast.Markdown] =
  ParseOk(,H2(List(this ,
                Italic(List(is)),
                h2 i , Bold(List(presume)))))
```
</section>

<section data-figure>
### Demo headerParser failing
```
scala> headerParser.run("""this _is_ NOT h2 i presume""")

```

```
scala> headerParser.run("""this _is_ NOT h2 i presume""")
headerParser.run("""this _is_ NOT h2 i presume""")
res0: parser.ParseState[ast.Markdown] =
  ParseKo(Input failed to match predicate.: instead saw char 't')

```
</section>

Admittedly, this is not the best error message (for better errors use the built in Scala combinator parser library rather than this demo).
It failed to see a `#` as the first char in a header and so produced a `ParseKo` instead of `ParseOk`.

The important thing to see is that a parser stops as soon as it can go no further.

In order to parse a whole document we can use the combinator methods, such as [|||](https://github.com/karlroberts/scalasyd-markdownem/blob/master/src/main/scala/parser/parsers.scala#L76) i.e. `or` on [Parser](https://github.com/karlroberts/scalasyd-markdownem/blob/master/src/main/scala/parser/parsers.scala) and some of the parsers such a [list](https://github.com/karlroberts/scalasyd-markdownem/blob/master/src/main/scala/parser/parsers.scala#L145) to compose more powerful
parsers that continue parsing input by trying one parser after another.

An example is the [markdownParser](https://github.com/karlroberts/scalasyd-markdownem/blob/master/src/main/scala/parser/markdownParser.scala#L50) which will try all blockParsers followed by the inlineParsers continuously until it can parse no more.

However that will only occur when there is no more input because the last parser it tries is always the [rawHtml]() parser which will always succeed because any input that is not parsed as markdown must be is just treated as `RawHtml`.

<section data-figure>
### Demo markdownParser
```
scala> markdownParser.run("""this _is_ NOT h2 i presume
     | ## but this _is **h2**_""")

```

```
res4: parser.ParseState[List[ast.Markdown]] =
  ParseOk(,List(this ,
             Italic(List(is)),
              NOT h2 i presume,
             Hardwrap,
             H2(List(but this ,
               Italic(List(is , Bold(List(h2))))))))
```
</section>


Now we can see that the input parses into a List of `Markdown`. This is all very well but it'd be nice to see the rendered HTML.

This is where [simple](https://github.com/karlroberts/scalasyd-markdownem/blob/master/src/main/scala/transformers/MarkdownToHtml.scala#L87) MarkdownToHtml Transformer comes in.

I can now use the `---*` magic wand function

<section data-figure>
### Demo `simple` render
```
scala> simple ---* """this _is_ NOT h2 i presume
     | ## but this _is **h2**_"""

```

```
res1: transformers.MarkdownToHtml.m2hTransformer.OUT =
"this <em>is</em> NOT h2 i presume
<h2>but this <em>is <strong>h2</strong></em></h2>
"
```
</section>

<section data-figure>
### Demo `simple` render a complex list
```
scala> simple ---* """* unordered list item
     |   1. _nested_ list item
     |   2. **another _nested_** list item
     | * unorderd [link](http://foo.bar) list item
     | 
     | [a ref link][1] whose url detail is at the end
     | 
     | [1] http://the.reflink.com"""
```
</section>

<section data-figure>
### Demo `simple` render a complex list result
```
res0: transformers.MarkdownToHtml.m2hTransformer.OUT =
"<ul>
    <li>unordered list item</li>
    <ol>
        <li><em>nested</em> list item</li>
        <li><strong>another <em>nested</em></strong> list item</li>
    </ol>
    <li>unorderd <a href="http://foo.bar">link</a> list item</li>
</ul>

<a href="http://the.reflink.com">a ref link</a> whose url detail is at the end
<p>
<!-- [1] http://the.reflink.com --></p>
"
```
</section>

<section data-slide>
# 
### So... Performance?
</section>

What about Performance?

I haven't run proper benchmarks yet, but as a quick and dirty test
I have added timing output to the `main` function.

<section data-figure>
### remember this in `build.sbt`

```
scalaJSUseMainModuleInitializer := true
```
* After compiling to JavaScript
  - adds a call to the `main` function in the `MainClass`
  - at the end of the JavaScript.
* This makes the main function run when the JS is loaded
</section>

<section data-figure>
### We can get `sbt` run task to do the same for us

```
sbt
[info] Loading settings from idea.sbt ...
[info] Loading global plugins from /home/robertk/.sbt/1.0/plugins
[info] Loading settings from plugins.sbt ...
[info] Loading project definition from /home/robertk/projects/skunk/markdownem_js/project
[info] Loading settings from build.sbt ...
[info] Set current project to Markdownem (in build file:/home/robertk/projects/skunk/markdownem_js/)
[info] sbt server started at 127.0.0.1:5300
sbt:Markdownem> 
```
</section>

<section data-figure>
### We can get `sbt` run task to do the same for us
```
sbt:Markdownem> run
[info] Running tutorial.webapp.TestApp
[error] java.io.IOException: Cannot run program "node": error=2, No such file or directory
...
```
</section>

What happened? 

It is an error from sbt as it is trying to run the default JavaScript runtime `Node.js` to execute the generated JavaScript.

sbt can also run using other JavaScript runners such as `PhantomJS`, `Selenium` or `Rhino` see the [docs](https://www.scala-js.org/doc/project/js-environments.html)

I had better load NodeJS onto my PATH, i use `nvm` for this.

<section data-slide>
# &nbsp;
### WTF!

</section>

<section data-slide>
#
### WTF!
* It was trying to use `node` to run the JavaScript.
* &nbsp;
</section>

<section data-slide>
#
### WTF!
* It was trying to use `node` to run the JavaScript.
* I better load it onto my PATH
</section>

<section data-figure>

```
sbt:Markdownem> exit
$ nvm use v7.9.0
Now using node v7.9.0 (npm v4.2.0)
$ sbt
[info] Loading settings from idea.sbt ...
...
[info] Set current project to Markdownem (in build file:/home/robertk/projects/skunk/markdownem_js/)
[info] sbt server started at 127.0.0.1:5300
sbt:Markdownem> 

```
</section>

<section data-figure>
### We can get `sbt` running NodeJs
```
sbt:Markdownem> run
[info] Running tutorial.webapp.TestApp
>>>>>>>>>>> ms: -> 690
>>>>>>>>>>> ms: -> 443
>>>>>>>>>>> ms: -> 434
>>>>>>>>>>> ms: -> 447
>>>>>>>>>>> ms: -> 423
>>>>>>>>>>> ms: -> 430
[success] Total time: 4 s, completed 21/09/2017 9:53:01 AM
sbt:Markdownem> 
...
```
</section>

The [TestApp](https://github.com/karlroberts/scalasyd-markdownem/blob/master/src/main/scala/webapp/TestApp.scala) just renders 112 lines of markdown into HTML a few times.

We can see that after the initial run where it starts the node environment it ends up taking about 430ms.

That seems slow!

<section data-slide>
### seems a bit slow!
* 112 lines of markdown in 430ms

* &nbsp;
</section>

<section data-figure>
### seems a bit slow!
* 112 lines of markdown in 430ms

* lets compare the JS to a scala/JVM run
</section>

If we comment the JS lines in build.sbt we can build and run the main app in standard Scala on the JVM

<section data-figure>
### comment Scala.js from build.sbt
```
// enablePlugins(ScalaJSPlugin)

// This is an application with a main method
// change this to true if you want the The TestApp main class to be a JS "Application"
// scalaJSUseMainModuleInitializer := true

name := "Markdownem"
scalaVersion := "2.12.2"
...
```
</section>

<section data-figure>
### now run as a ScalaJVM app
```
sbt:Markdownem> reload
sbt:Markdownem> run
[info] Compiling 8 Scala sources to /home/markdownem_js/target/scala-2.12/classes ...
[info] Done compiling.
[info] Packaging /home/markdownem_js/target/scala-2.12/markdownem_2.12-0.1-SNAPSHOT.jar ...
[info] Done packaging.
[info] Running tutorial.webapp.TestApp 
>>>>>>>>>>> ms: -> 592
>>>>>>>>>>> ms: -> 263
>>>>>>>>>>> ms: -> 234
>>>>>>>>>>> ms: -> 229
>>>>>>>>>>> ms: -> 225
>>>>>>>>>>> ms: -> 235

```
</section>

<section data-slide>
### On the JVM same code runs 200ms faster
* 112 lines of markdown in ~ 230ms

* &nbsp;
* &nbsp;

* &nbsp;
</section>

<section data-slide>
### On the JVM same code runs 200ms faster
* 112 lines of markdown in ~ 230ms

* But this is not really a fair comparison with NodeJS
* &nbsp;

* &nbsp;
</section>

<section data-slide>
### On the JVM same code runs 200ms faster
* 112 lines of markdown in ~ 230ms

* But this is not really a fair comparison with NodeJS
* The Javascript was not fully optomised because it would take longer to compile

* &nbsp;
</section>

<section data-figure>
### On the JVM same code runs 200ms faster
* 112 lines of markdown in ~ 230ms

* But this is not really a fair comparison with NodeJS
* The Javascript was not fully optomised because it would take longer to compile

* So lets optomise it.
</section>

<section data-figure>
### use the optimising compiler

* The Javascript was compiled with the `FastOptStage` compiler
  - meaning it was fast to compile
* We can tell sbt to run with the `FullOptStage` compiler
  - which will optimise much more
</section>

<section data-figure>
### un-comment Scala.js, put it back into build.sbt
```
enablePlugins(ScalaJSPlugin)

// This is an application with a main method
// change this to true if you want the The TestApp main class to be a JS "Application"
scalaJSUseMainModuleInitializer := true

name := "Markdownem"
scalaVersion := "2.12.2"
...
```
</section>

<section data-figure>
### tell sbt to use Full optimisation
```
sbt:Markdownem> reload
sbt:Markdownem> set scalaJSStage in Global := FullOptStage
```

* N.B. we can set it back with

```
sbt:Markdownem> set scalaJSStage in Global := FastOptStage
```
</section>

<section data-figure>
### now run optimised Javascript
```
sbt:Markdownem> run
[info] Full optimizing ./target/scala-2.12/markdownem-opt.js
[info] Closure: 0 error(s), 0 warning(s)
[info] Running tutorial.webapp.TestApp
>>>>>>>>>>> ms: -> 590
>>>>>>>>>>> ms: -> 298
>>>>>>>>>>> ms: -> 281
>>>>>>>>>>> ms: -> 296
>>>>>>>>>>> ms: -> 270
>>>>>>>>>>> ms: -> 259
```
</section>

<section data-figure>
### Javascript in NodeJS almost as quick as JVM
* 112 lines of markdown in 260ms

</section>


<section data-slide>
### But still it seems slow
* Combinator parsers are recursive decent parsers
* every `or` `|||` branch backtracks on the input
  - and re-parses of the first parser fails
* &nbsp;

###### &nbsp;
</section>

<section data-slide>
### But still it seems slow
* Combinator parsers are recursive decent parsers
* every `or` `|||` branch backtracks on the input
  - and re-parses of the first parser fails
* Packrat parsing's memoization can massivly improve it.

###### &nbsp;
</section>

<section data-figure>
### But still it seems slow
* Combinator parsers are recursive decent parsers
* every `or` `|||` branch backtracks on the input
  - and re-parses of the first parser fails
* Packrat parsing's memoization can massivly improve it.

###### caveat: also I've done no code optimisation yet
</section>

Runing in the sbt prompt is all very well.

But how can I run this code in my browser?

<section data-slide>
# 
### So... how do I run it in my browser?
</section>


<section data-figure>
### export a javascript function to the "toplevel"
* this allows other javascript ion a page to call it.
* add `@JSExportTopLevel` annotation to the method to export
  - so in [MarkdownToHtml.scala line 3](https://github.com/karlroberts/scalasyd-markdownem/blob/master/src/main/scala/transformers/MarkdownToHtml.scala#L3) uncomment the `import`
```
import scala.scalajs.js.annotation.JSExportTopLevel
```
</section>

<section data-figure>
### export a javascript function to the "toplevel"
* add `@JSExportTopLevel` annotation to the method to export
  - so in [MarkdownToHtml.scala line 83](https://github.com/karlroberts/scalasyd-markdownem/blob/master/src/main/scala/transformers/MarkdownToHtml.scala#L3) uncomment the annotation and expose a top level function called `mdmagic`
```
@JSExportTopLevel("mdmagic")
def transform(md: String): String = simple ---* md
```
</section>

<section data-figure>
### compile the optimised JavaScript
```
sbt:Markdownem> fullOptJS
[info] Compiling 8 Scala sources to ./target/scala-2.12/classes ...
[info] Done compiling.
[info] Full optimizing /home/robertk/projects/skunk/markdownem_js/target/scala-2.12/markdownem-opt.js
[info] Closure: 0 error(s), 0 warning(s)
[success] Total time: 16 s, completed 21/09/2017 11:26:04 AM

```
</section>

<section data-figure>
### import the markdownem-opt.js in a html page

* see [test.html](https://github.com/karlroberts/scalasyd-markdownem/blob/master/test.html#L9)

```html
<script type="text/javascript" src="./target/scala-2.12/markdownem-opt.js"></script>
```

###### NB you probably want to set `scalaJSUseMainModuleInitializer := false` in build.sbt
###### to prevent the slow main app test from running when the page loads
</section>

<section data-figure>
##### simply use the [mdmagic](https://github.com/karlroberts/scalasyd-markdownem/blob/master/test.html#L101-L106) function in some javascript

```
element = document.getElementById(elementId)
theContent = element.innerHTML
element.innerHTML = mdmagic(theContent)
```
</section>

<section data-figure>
* Open test.html in your browser
  - to see it render the markdown as html
</section>

<section data-figure>
### For Remaining topics eg
#### Javascript interop

* RTF[M https://www.scala-js.org/doc/](https://www.scala-js.org/doc/)
* RTF[T https://www.scala-js.org/tutorial/](https://www.scala-js.org/tutorial/)
</section>



<section data-figure>
#### TODO....

* just use scala lib [PackratParsers](http://www.scala-lang.org/api/2.12.3/scala-parser-combinators/scala/util/parsing/combinator/PackratParsers.html)
or [sbt-rats](https://bitbucket.org/inkytonik/sbt-rats) 
  - better error messages
  - faster 
* add the plugin interface
* write the fragments plugin
* re-write suited.js in scala.js
* look at a recursion scheme for render
* Free Monad/Applicative for renderer/interpreter

</section>

<section data-figure>
#### The End

</section>

<section data-figure>
#### Thanks ....

* me @MrK4rl

* code used in demo [https://bitbucket.org/suited/markdownem](https://bitbucket.org/suited/markdownem)
* deck and talk (http://karlcode.owtelse.com/blog/2017/07/09/scala-js-markdown-combinator-parser/?mode=deck#slide-0)
* ref [Scala.js doco](https://www.scala-js.org/doc/)
* ref ["Dont fear the parser"](http://mth.io/talks/dont-fear-the-parser/) - Mark Hibberd - scalasyd talk
* ref ["Dont fear the parser"](http://github.com/markhibberd/dont-fear-the-parser) - Mark Hibberd - demo code
* ref [The Type Astronaut's Guide to Shapeless http://underscore.io/books/shapeless-guide/](http://underscore.io/books/shapeless-guide/)
* ref ["The rise and fall of the Aux pattern"](http://karlcode.owtelse.com/blog/2017/04/11/the-rise-and-hopefully-fall-of-the-aux-pattern-2) - Karl Roberts - scalasyd talk

</section>



