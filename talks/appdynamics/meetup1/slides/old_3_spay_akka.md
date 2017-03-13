## [Spray.io](http://spray.io/) and [Akka](http://akka.io/)
+ Akka is an Actor System
  - It enables non blocking async systems <!-- .element: class="fragment" -->
  - light weight <!-- .element: class="fragment" -->
    - 50 million msg/sec on a single machine. Small memory footprint; ~2.5 million actors per GB of heap <!-- .element: class="fragment" -->
  - Actors receive messages in their own "thread" and send response "messages" <!-- .element: class="fragment" -->
+ Spray.io is a WWW library built on Akka

<aside class="notes">
  Sounds like real OO to me ;-)
</aside>

---

## Meh?
+ So my simple app is a Web proxy to Hazelcast to store (and fetch) Position Reports
+ No GUI yet, mayby for the next Meetup? ;-) <!-- .element: class="fragment" -->



