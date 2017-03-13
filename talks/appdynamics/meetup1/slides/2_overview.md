## Overview
* This is a talk about AppDynamics from the Dev perspective.
* But AppD is an Op&rsquo;s tool, isn&rsquo;t it? <!-- .element: class="fragment" -->
* Why do devs need it?                          <!-- .element: class="fragment" -->
* Can&rsquo;t they just read the source code?     <!-- .element: class="fragment" -->

![matrix](./images/Neo_Matrix_code_small.jpg) <!-- .element: class="fragment" -->

* ... or use a profiler? <!-- .element: class="fragment" -->

Note: pause on Why do devs need.... we are super clever right?

-----
# Confession.
* My name is Karl
* And I am a Developer. <!-- .element: class="fragment" -->

-----
<!-- .slide: data-background="./images/precision.jpg" data-background-size="100%" -->
# <font color="#2A4A4A">What developers think</font>

---
## Clean logical call structure
<!-- ![apachesyscalls](./images/apache_systemcalls.jpg) -->
<img src="./images/apache_systemcalls.jpg" width="70%"/>

---
## The reality - Enterprise code
<!-- ![iissyscalls](./images/iis_spaghetti.jpg) -->
<img src="./images/iis_spaghetti.jpg" width="70%"/>

---

## Reasons
* This is the reality within a single standalone app.
* Nothing a decent IDE and profiler can&rsquo;t fix.
* Right? <!-- .element: class="fragment" -->
* But modern applications aren&rsquo;t standalone. <!-- .element: class="fragment" -->
* Web-apps are systems. <!-- .element: class="fragment" -->

---
## So why the big deal?
* Programs are deterministic.
* We can reason literally about them. <!-- .element: class="fragment" -->
* After all, a dumb machine can &quot;understand&quot; it. <!-- .element: class="fragment" -->
* The problem is degrees of freedom. Moving parts. <!-- .element: class="fragment" -->
* Simple pendulum is predictable, it runs like clockwork. <!-- .element: class="fragment" -->
* Newtonian physics lets us predict exactly where it will be at any given time. <!-- .element: class="fragment" -->



