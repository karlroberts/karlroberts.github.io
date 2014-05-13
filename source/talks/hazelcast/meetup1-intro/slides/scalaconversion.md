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

see [testGet](./data/testGet1/simplescazelcastgettest2-20140513123407/index.html)