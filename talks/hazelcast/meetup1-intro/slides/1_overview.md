## Overview
+ What am I doing here?
+ (Cache | !Cache)?
+ My Test App
+ Spray.io & Akka
+ Hazelcast
  - architecture not code <!-- .element: class="fragment" -->
+ Demo
+ TODO

---

## What am I doing here?
![Alt Ecetera logo](./images/Ecetera_Logo_Grey.png) <!-- .element: class="fragment" ata-fragment-index="1" -->

> &ldquo;Ridding the world of badly behaving Web applications&rdquo; <!-- .element: class="fragment" data-fragment-index="3" -->
  >> <small>Peter Brown, CEO Ecetera</small>                         <!-- .element: class="fragment" data-fragment-index="2" -->

---

## (Cache | !Cache)? 
+ Rememering stuff you've seen before speeds up apps 
+ Caching is good!                                   
  - right?                                           <!-- .element: class="fragment" -->

Note: ???
<aside class="notes">
  ???
</aside>

---

## (Cache | !Cache)? 
+ Can remove need to repeat expensive operations
  - But what if it changes?                                                    <!-- .element: class="fragment" -->
+ Memory access is Fast
  - But it doesn't scale over clusters                                         <!-- .element: class="fragment" -->
+ My laptop has loads of memory
  - But we're not shipping my laptop! ;-)                                      <!-- .element: class="fragment" -->
  - JVM Garbage collection will suffer if I use it all                 <!-- .element: class="fragment" -->
  - If we use a small heap I can't cache everything and eviction policies dominate my code  <!-- .element: class="fragment" -->
+ Fast is Good
  - CAP says you'll sacrifice somewhere                                        <!-- .element: class="fragment" -->

Note: CAP Consistency Availably Performance - can have 2 of these when distributed

---

## (Cache | !Cache)? 
+ rememering stuff you've seen before speeds up apps 
  - if you have enough memory                        <!-- .element: class="fragment" -->
  - and the data hasn't changed since you read it.   <!-- .element: class="fragment" -->

+ Caching is good!                                  
  - maybe                                           <!-- .element: class="fragment" -->
  - ![Alt arms cache](./images/arms_cache1.jpg)  <!-- .element: class="fragment" -->
    <small>weapons cache</small>    <!-- .element: class="fragment" -->
  - They will complicate your life!                          <!-- .element: class="fragment" -->
