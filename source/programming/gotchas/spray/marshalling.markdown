---
layout: page
title: "Marshalling in Spray.io"
date: 2014-05-06 08:31
comments: true
sharing: true
footer: true
published: true
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
* the route that get's the Stats is the problem

{% codeblock lang:scala "DemoSevice.scala" start:35 mark:38,64-69 https://github.com/spray/spray/blob/master/examples/spray-routing/on-spray-can/src/main/scala/spray/examples/DemoService.scala %}
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

* the code calls the listener actor, the one that sends the Bound message, and passes it the `Http.GetStats` message.
* that actor responds with a Stats object.
* to prevent blocking the code uses the ask pattern to get a Future[Stats] object, ask returns a Future[Any] so it is cast to Future[Stats]
* complete looks for a way to marshall Stats to a HttpEntity but runs into trouble.... 
  - lets break it down

1. Execution Context
* if you kick of a Future, eg with the ask pattern for the Stats, you must include the following
  - This uses the default execution context of the actor system and makes it implicitly available
  
{% codeblock "execution context" lang:scala start:38 mark:39 https://github.com/spray/spray/blob/master/examples/spray-routing/on-spray-can/src/main/scala/spray/examples/DemoService.scala %}
  // we use the enclosing ActorContext's or ActorSystem's dispatcher for our Futures and Scheduler
  implicit def executionContext = actorRefFactory.dispatcher
{% endcodeblock %}

* failure to do so will rsult in an error like, note we are trying to create a `Marshaller[Future[Stats]]`
{% codeblock %}
[error] DemoService.scala:68: could not find implicit value for parameter marshaller: spray.httpx.marshalling.ToResponseMarshaller[scala.concurrent.Future[spray.can.server.Stats]]
[error]               .mapTo[Stats]
{% endcodeblock %}

2. Can't marshall
* the marshalling system for Spray needs an implicit marshaller for Stats
* Stats doesn not have one in it's companion object
* in fact it doesn't have a companion object it is a case class
* note the error is identical to the previous which is annoying!
{% codeblock %}
[error] DemoService.scala:68: could not find implicit value for parameter marshaller: spray.httpx.marshalling.ToResponseMarshaller[scala.concurrent.Future[spray.can.server.Stats]]
[error]               .mapTo[Stats]
{% endcodeblock %}

* so we need to bring one into scope, something like this will do although we could use Marshaller.of[Stats] function too with a bit more boilerplate.
{% codeblock "implicit Marshaller" lang:scala start:168 https://github.com/spray/spray/blob/master/examples/spray-routing/on-spray-can/src/main/scala/spray/examples/DemoService.scala %} 
val statsMarshaller: Marshaller[Stats] =
    Marshaller.delegate[Stats, String](ContentTypes.`text/plain`) { stats =>
      "Uptime                : " + stats.uptime.formatHMS + '\n' +
      "Total requests        : " + stats.totalRequests + '\n' +
      "Open requests         : " + stats.openRequests + '\n' +
      "Max open requests     : " + stats.maxOpenRequests + '\n' +
      "Total connections     : " + stats.totalConnections + '\n' +
      "Open connections      : " + stats.openConnections + '\n' +
      "Max open connections  : " + stats.maxOpenConnections + '\n' +
      "Requests timed out    : " + stats.requestTimeouts + '\n'
    }
{% endcodeblock %}

### JSON
  So with the points above the code will work and on hittingthe `/Stats` URL will render the stats as a String
  **But what about JSON?**

Spray supports JSON an even automatically supports case classes made up from standard value fields all you have to do is 
{% codeblock %}
Just mix in spray.httpx.SprayJsonSupport or import spray.httpx.SprayJsonSupport._.
{% endcodeblock %}
* ie mix that into your route or just import the Object's vals
  - and it will bring an implicit RootJsonFormat[T] into scope which is a Marshaller
  - and job done right?

#### Stats has a FiniteDuration 
* look at `Stats`
* is not made of the default value types it has a FiniteDuration
{% codeblock %}
case class MyStats(uptime: FiniteDuration,
                   totalRequests: Long,
                   openRequests: Long,
                   maxOpenRequests: Long,
                   totalConnections: Long,
                   openConnections: Long,
                   maxOpenConnections: Long,
                   requestTimeouts: Long)
{% endcodeblock %}
* there is no default RootJsonFormat for that

so we need some help
##### Create an implicit RootJsonFormat[FiniteDuration]
{% codeblock %}
import MyJsonMarshaller._

{% endcodeblock %}
{% codeblock %}
object MyJsonMarshaller extends DefaultJsonProtocol {

  // implicit JSON marshaller for FiniteDuration
  implicit object finiteDurationJsonFormat extends RootJsonFormat[FiniteDuration] {
    def write(c: FiniteDuration) = JsNumber(c.toNanos) // toNanos just a hack to create a Long could be cleverer

    def read(value: JsValue) = value match {
      case JsNumber(nanos) => new FiniteDuration(nanos.longValue, TimeUnit.NANOSECONDS)
      case _ => deserializationError("FiniteDuration in Nanos expected")
    }
  }
  
  //use the jsonFormat8() factory to convert Stats
  implicit val statsFormat = jsonFormat8(Stats) 
}
{% endcodeblock %}

the end.




