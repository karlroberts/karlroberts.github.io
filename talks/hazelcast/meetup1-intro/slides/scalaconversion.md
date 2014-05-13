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

---

see [testGet](./data/testGet1/simplescazelcastgettest2-20140513123407/index.html)

see [testPostNoHazelcast](./data/testPost1/simplescazelcastpostloadtest2-20140513131810/index.html)


see [testPostQithHazelcast](./data/testPostHC1/simplescazelcastpostloadtest2-20140513161743/index.html)

log under load:- 
scazelcast-demo[ERROR] INFO: [192.168.2.126]:5701 [dev] [3.2.1] memory.used=460.8M, memory.free=317.2M, memory.total=778.0M, memory.max=1.7G, memory.used/total=59.23%, memory.used/max=26.69%, load.process=45.00%, load.system=82.00%, load.systemAverage=1281.00%, thread.count=41, thread.peakCount=41, event.q.size=0, executor.q.async.size=0, executor.q.client.size=0, executor.q.operation.size=0, executor.q.query.size=0, executor.q.scheduled.size=0, executor.q.io.size=0, executor.q.system.size=0, executor.q.operation.size=0, executor.q.priorityOperation.size=0, executor.q.response.size=0, operations.remote.size=0, operations.running.size=0, proxy.count=1, clientEndpoint.count=0, connection.active.count=0, connection.count=0
