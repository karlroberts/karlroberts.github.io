## My Test App

Simple Position Report Test application

+ Terminals in the field can Post a Position report to my app
+ Must be able to Scale

---

# Messages

+ Terminals can send messages that represent PositionReport objects
<pre><code data-trim>
&ldquo;---,01,000001,31.000000,31.000000,0201,031399895980443,%%fcff5402&rdquo;
</code></pre>

<small>which is isomorphic to (the same as ;-)</small>

<pre><code data-trim>
val testnow = now
val p1 = Position(31.000, 31.000)
val pr1 = PositionReport(Terminal("000001"), p1, OK, testnow)
}
</code></pre>

<small>or</small>

<pre><code data-trim>
val testnow: DateTime = now
val pr1 = PositionReport(Terminal("000001"), Position(31.000, 31.000), Status(OK), testnow)
}
</code></pre>




