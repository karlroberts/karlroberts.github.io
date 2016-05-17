---
layout: post
title: "Writing a markdown-it plugin"
date: 2016-05-17 12:45:11 +1000
comments: true
published: false
categories: 
- plugin
- markdown-it
---
<!-- suited default style  -->
<link rel="stylesheet" type="text/css" href="http://test.aws.owtelse.com/suited/css/suited-light-f7ea56d9ab.css">
<script type="text/javascript" src="http://test.aws.owtelse.com/suited/js/shared-52a5b2efa569322d6fda.js"></script>
<script type="text/javascript" src="http://test.aws.owtelse.com/suited/js/bundle-52a5b2efa569322d6fda.js"></script>

## What is Markdown-it?
Markdown-it is a javascript library for parsing markdown, by default into HTML.
It is also extensible, allowing you to write plugins that can extend markdown syntax to add your own special meaning.

## Use sparingly.
Of course the benefit of markdoen is that it allows people to easily remember a few simple syntax rules that will produce
nice looking html, while still looking good and easily readable in a plain text editor.

With this in mind, it is best not to add loads of new syntax, because

1. It will be hard to remember
2. It will be hard to type
3. It may not look nice in text, obscuring the message.

## Why blog this?
The markdown-it website gives clues to how to write plugins, but basically says "RTFM" where in this case RTFM -> "Read the Source"

The conventions used are not immediatly obvious and there are no recipies.

I will attempt to flag the conventions and give a simple recipie for a couple of diffent plugins (or point you at some examples once the conventions are known).

## Preliminary info
read this to grok later stuff.

* markdown-it is based on [CommonMark](http://commonmark.org/)
  - so the syntax and extentions to markdown provided by CommonMark should not be messed with.
  - strikethough and table are examples of the extentions provided out of the box.
  - [markdown-it demo](https://markdown-it.github.io/)

* [Devoloper Docs are here](https://github.com/markdown-it/markdown-it/tree/master/docs)
  - skim read this before coming back here to reason about it.
* [API Docs are here](https://markdown-it.github.io/markdown-it/)
  - but it may be better to just checkout the code
* [Code is here](https://github.com/markdown-it/markdown-it)


### Terms glossary
markdown-it talks about verious things like you are expected to understand them/

* block
  - A block of markdown code that will form a block level HTML construct
  - eg '# title' forms a html &lt;h1&gt;title&lt;/h1&gt; block level element
  - or a table block that forms a html table. see [demo](https://markdown-it.github.io/)
  - note that many markdown blocks only have a starting token and are new line terminated
    - or may spread over several lines
  - NB `block` in markown-it is a block (one or more lines) of markdown NOT a HTML block-level element
  
* inline
  - a token delimited section of markdown with__in__ a __line__
    - hence the name.
  eg in a line I may have &#42;&#42;bold text&#42;&#42; whiche would render in **bold** the stuff surrounded by &#42;&#42;
  - ususlly inline markdown has a starting and ending token to delimit the section that gets rendered differently.
  
* Chains

* Rules

* Plugins

* Renderer

### HOWTO

#### use a plugin
a Plugin is added to markdownit using the use() function
 see examples below or [here](https://github.com/markdown-it/markdown-it#usage-examples)
 
```
var MarkdownIt = require('markdown-it');
var md = new MarkdownIt()
var myplugin = require("./markdown-it-suited-figure.js");
md.use(myplugin);
```

A plugin is a function of the form

    function (md [, arg1, arg2, ...])
that is a function that takes the MarkdownIt object it is passed to as its first argument followed by 
any number of further arguments.

to pass the extra arguments to the plugin the `use` function can take a curried list of the further arguments eg

```
var MarkdownIt = require('markdown-it');
var md = new MarkdownIt()
var myplugin = require("./markdown-it-suited-figure.js");
var arg1 = "hello";
var arg2 = "world";
var arg3 = "again";
md.use(myplugin, arg1, arg2, arg3);
```

#### disable a plugin
pass an  options object to the `MarkdownIt` object on contruction
full details are [here](https://github.com/markdown-it/markdown-it#init-with-presets-and-options) where you can see
some of the default builtin plugins being disabled in the config.
Any plugin can be disabled using its name this way. ???? checj this


#### build a plugin
* Plugins basically add rules to one or more chains ???? check this
  - The rules enable markdown-it to handle the new markdown syntax extentions
  
so

1. So decide if your plugin is addin `block` rules or `inline` rules
1. Build the Rules
1. add the Rules to the appropriate `Ruler` in `md`

#### build a Rule

I worked out what Rules have to be like by following the parse() method which calls tokenize() method in the block parser 
https://github.com/markdown-it/markdown-it/blob/master/lib/parser_block.js
and the inline parser https://github.com/markdown-it/markdown-it/blob/master/lib/inline_block.js
until I found where the rules were run.

the results are as follows

block rules are functions that look like this

    /**
     * state = a StateBlock as defined at https://github.com/markdown-it/markdown-it/blob/master/lib/rules_block/state_block.js
     *   - contains the src markdown
     * startline = index into the source that the rule is working from
     * endline = index into the src where the end of the file is
     * isValidation, by default is false ie the rule will run and modify state etc, if true just ruturn true if the syntax looks ok
    function(state, startline, endline, isValidation)

// On success, a block rule should:
    //
    // - update `state.line`
    // - update `state.tokens`
    // - return true
    
inline rules look like:

    /**
     * state = a StateBlock as defined at https://github.com/markdown-it/markdown-it/blob/master/lib/rules_block/state_block.js
     *   - contains the src markdown
     * isValidation, by default is false ie the rule will run and modify state etc, if true just ruturn true if the syntax looks ok
     function(state, isValidation)
     
// On success, rule should:
    //
    // - update `state.pos`
    // - update `state.tokens`
    // - return true     


#### add a rule

* if a block rule
  md.block.ruler.push
  // this.ruler.push(_rules[i][0], _rules[i][1], { alt: (_rules[i][2] || []).slice() });
  
* if inline