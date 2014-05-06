---
layout: page
title: "marshalling"
date: 2014-05-06 08:31
comments: true
sharing: true
footer: true
published: false
categories: [spray, spray.io, marshalling, scala]
---
Marshalling in spray.io
=======================

## Issue

When generating output from a Data type Spray looks for implicit Marshaller or UnMarshallers in the scope of the route in question.

There are some default marshallers for most of the common value types such as Int Long String and the Collections, as well as automatic marshallers for case classes

However these may or may not be available, because:-

* Your type has not been added to the Marshaller typeclass
* Your type is a case class but some of it's fields have no marshallern 
* You invoke a Future using the ask pattern and there is no execution context in scope.

### Example

* consider this [route](http://spray.io/documentation/1.2.1/spray-routing/) from the Spray route [Example project](https://github.com/spray/spray/blob/master/examples/spray-routing/on-spray-can/src/main/scala/spray/examples/DemoService.scala) 

{% codeblock Coffeescript Tricks lang:coffeescript start:51 mark:51,54-55 %}
# Given an alphabet:
alphabet = 'abcdefghijklmnopqrstuvwxyz'

# Iterate over part of the alphabet:
console.log letter for letter in alphabet[4..8]
{% endcodeblock %}

{% codeblock lang:scala Demo start:35 mark:38,64-69 %}
trait DemoService extends HttpService {

  // we use the enclosing ActorContext's or ActorSystem's dispatcher for our Futures and Scheduler
  implicit def executionContext = actorRefFactory.dispatcher

  val demoRoute = {
    get {
      pathSingleSlash {
        complete(index)
      } ~
      path("ping") {
        complete("PONG!")
      } ~
      path("stream1") {
        // we detach in order to move the blocking code inside the simpleStringStream into a future
        detach() {
          respondWithMediaType(`text/html`) { // normally Strings are rendered to text/plain, we simply override here
            complete(simpleStringStream)
          }
        }
      } ~
      path("stream2") {
        sendStreamingResponse
      } ~
      path("stream-large-file") {
        encodeResponse(Gzip) {
          getFromFile(largeTempFile)
        }
      } ~
      path("stats") {
        complete {
          actorRefFactory.actorFor("/user/IO-HTTP/listener-0")
            .ask(Http.GetStats)(1.second)
            .mapTo[Stats]
        }
      }
    }
  }
{% endcodeblock %}

