# Scala vs Hazelcast
+ The biggest issue is that Hazelcast returns ICollections
+ These map to Java Collections
+ Scala as a functional language prefers Immutable Types

<pre><code data-trim>
def getFromCache(key: String): Option[String] = {
  import scala.collection.convert.WrapAsScala._
  import collection.mutable.{Map => MMap}
  import java.util.{Map => JMap}

    val x:JMap[String, String] = hazelcast.getMap("PositionReports")
    val y:MMap[String, String] = x
    y.get(key)
}
</code></pre>

n.b. implict conversion from java.util.Map => scala.collection.mutable.Map
 
<aside class="notes">Option = Algebraic Data Type Some None returned NOT String, type has concept of calculation failure

  NB implicit conversion from x => y

come to scalasyd tomorrow :-)
</aside> 

---

## Hazelcast as an Actor

<pre><code data-trim>
class HazelcastActor(hostname: String , port: Int, confFileName: String , timeout: FiniteDuration) extends Actor with HazelcastService
{
  val config = if(confFileName.isEmpty) new Config() else new ClasspathXmlConfig(confFileName)  
  val hazelcast: HazelcastInstance = Hazelcast.newHazelcastInstance(config)

  def receive: Receive = {
    case GetPosRep(key) => {
      sender ! getFromCache(key) // sender needs to handle None or Some(PositionReport)
    }
    case PutPosRep(key, value) => putInCache(key, value)
    case wtf => unhandled(s"Dont know what to do with this ${wtf.toString}")
  }

  def getFromCache(key: String): Option[PositionReport] = {    
    val x:JMap[String, String] = hazelcast.getMap("PositionReports")
    val y:MMap[String, String] = x
    y.get(key).flatMap {x =>  PositionReportExtractor.fromMessage(x) }
  }

  def putInCache(key:String, value:PositionReport) = {
    import java.util.{Map => JMap}
    val x:JMap[String, String] = hazelcast.getMap("PositionReports")
    x.put(key, value.wireMessage)
  }
}
</code></pre>


