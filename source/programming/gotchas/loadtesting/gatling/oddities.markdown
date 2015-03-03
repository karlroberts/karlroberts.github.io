---
layout: page
title: "oddities"
date: 2014-12-23 15:39
comments: true
sharing: true
categories: [gotcha, gatling]
footer: true
---

After recording a session  I had trouble replaying a post without errors.
The post contained

    http("request_53")
    .post(uri6 + """/Api/v1/Jobs""")
    .headers(headers_53)
    .formParam("""jobReceived""", """2014-09-17T16:04:50+10:00""")
    .formParam("""supportJob""", """false""")
    .formParam("""aviationJob""", """false""")
    .formParam("""address%5Blocality%5D""", """SHELLHARBOUR""")
    .formParam("""address%5Btype%5D""", """L""")

The problem was that the recorder had replace square brackets with %5B and %5D. I needed to replace then back to 

    http("request_53")
    .post(uri6 + """/Api/v1/Jobs""")
    .headers(headers_53)
    .formParam("""jobReceived""", """2014-09-17T16:04:50+10:00""")
    .formParam("""supportJob""", """false""")
    .formParam("""aviationJob""", """false""")
    .formParam("""address[locality]""", """SHELLHARBOUR""")
    .formParam("""address[type]""", """L""")

Also The timestamp field had %3A instead of ':' and %2B instead of '+'. Again these needed to be reset.
Note that this stuff is fine in URL's that clearly need to be URL encoded, but shouldn't happen in Posted request parameters... at least when testing on a .NET web framework, which didn't URL decode stuff.
