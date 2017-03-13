var stats = {
    type: "GROUP",
contents: {
"helloworld-68e109f0f40ca72a15e05cc22786f8e6": {
        type: "GROUP",
contents: {
"request-1-46da482b5ba7614b7124accf72d8b1ce": {
        type: "REQUEST",
        name: "request_1",
path: "HelloWorld / request_1",
pathFormatted: "helloworld---request-1-ce56dad46c77f9c94b9a5269e705572a",
stats: {
    "name": "request_1",
    "numberOfRequests": {
        "total": "500200",
        "ok": "500200",
        "ko": "0"
    },
    "minResponseTime": {
        "total": "0",
        "ok": "0",
        "ko": "-"
    },
    "maxResponseTime": {
        "total": "646",
        "ok": "646",
        "ko": "-"
    },
    "meanResponseTime": {
        "total": "193",
        "ok": "193",
        "ko": "-"
    },
    "standardDeviation": {
        "total": "65",
        "ok": "65",
        "ko": "-"
    },
    "percentiles1": {
        "total": "257",
        "ok": "257",
        "ko": "-"
    },
    "percentiles2": {
        "total": "328",
        "ok": "328",
        "ko": "-"
    },
    "group1": {
        "name": "t < 800 ms",
        "count": 500200,
        "percentage": 100
    },
    "group2": {
        "name": "800 ms < t < 1200 ms",
        "count": 0,
        "percentage": 0
    },
    "group3": {
        "name": "t > 1200 ms",
        "count": 0,
        "percentage": 0
    },
    "group4": {
        "name": "failed",
        "count": 0,
        "percentage": 0
    },
    "meanNumberOfRequestsPerSecond": {
        "total": "9117",
        "ok": "9117",
        "ko": "-"
    }
}
    }
},
name: "HelloWorld",
path: "HelloWorld",
pathFormatted: "helloworld-68e109f0f40ca72a15e05cc22786f8e6",
stats: {
    "name": "HelloWorld",
    "numberOfRequests": {
        "total": "2501",
        "ok": "2501",
        "ko": "0"
    },
    "minResponseTime": {
        "total": "31755",
        "ok": "31755",
        "ko": "-"
    },
    "maxResponseTime": {
        "total": "41896",
        "ok": "41896",
        "ko": "-"
    },
    "meanResponseTime": {
        "total": "38709",
        "ok": "38709",
        "ko": "-"
    },
    "standardDeviation": {
        "total": "2094",
        "ok": "2094",
        "ko": "-"
    },
    "percentiles1": {
        "total": "41249",
        "ok": "41249",
        "ko": "-"
    },
    "percentiles2": {
        "total": "41508",
        "ok": "41508",
        "ko": "-"
    },
    "group1": {
        "name": "t < 800 ms",
        "count": 0,
        "percentage": 0
    },
    "group2": {
        "name": "800 ms < t < 1200 ms",
        "count": 0,
        "percentage": 0
    },
    "group3": {
        "name": "t > 1200 ms",
        "count": 2501,
        "percentage": 100
    },
    "group4": {
        "name": "failed",
        "count": 0,
        "percentage": 0
    },
    "meanNumberOfRequestsPerSecond": {
        "total": "45.59",
        "ok": "45.59",
        "ko": "-"
    }
}

    }
},
name: "Global Information",
path: "",
pathFormatted: "missing-name-b06d1db11321396efb70c5c483b11923",
stats: {
    "name": "Global Information",
    "numberOfRequests": {
        "total": "500200",
        "ok": "500200",
        "ko": "0"
    },
    "minResponseTime": {
        "total": "0",
        "ok": "0",
        "ko": "-"
    },
    "maxResponseTime": {
        "total": "646",
        "ok": "646",
        "ko": "-"
    },
    "meanResponseTime": {
        "total": "193",
        "ok": "193",
        "ko": "-"
    },
    "standardDeviation": {
        "total": "65",
        "ok": "65",
        "ko": "-"
    },
    "percentiles1": {
        "total": "257",
        "ok": "257",
        "ko": "-"
    },
    "percentiles2": {
        "total": "328",
        "ok": "328",
        "ko": "-"
    },
    "group1": {
        "name": "t < 800 ms",
        "count": 500200,
        "percentage": 100
    },
    "group2": {
        "name": "800 ms < t < 1200 ms",
        "count": 0,
        "percentage": 0
    },
    "group3": {
        "name": "t > 1200 ms",
        "count": 0,
        "percentage": 0
    },
    "group4": {
        "name": "failed",
        "count": 0,
        "percentage": 0
    },
    "meanNumberOfRequestsPerSecond": {
        "total": "9117",
        "ok": "9117",
        "ko": "-"
    }
}

}

function fillStats(stat){
    $("#numberOfRequests").append(stat.numberOfRequests.total);
    $("#numberOfRequestsOK").append(stat.numberOfRequests.ok);
    $("#numberOfRequestsKO").append(stat.numberOfRequests.ko);

    $("#minResponseTime").append(stat.minResponseTime.total);
    $("#minResponseTimeOK").append(stat.minResponseTime.ok);
    $("#minResponseTimeKO").append(stat.minResponseTime.ko);

    $("#maxResponseTime").append(stat.maxResponseTime.total);
    $("#maxResponseTimeOK").append(stat.maxResponseTime.ok);
    $("#maxResponseTimeKO").append(stat.maxResponseTime.ko);

    $("#meanResponseTime").append(stat.meanResponseTime.total);
    $("#meanResponseTimeOK").append(stat.meanResponseTime.ok);
    $("#meanResponseTimeKO").append(stat.meanResponseTime.ko);

    $("#standardDeviation").append(stat.standardDeviation.total);
    $("#standardDeviationOK").append(stat.standardDeviation.ok);
    $("#standardDeviationKO").append(stat.standardDeviation.ko);

    $("#percentiles1").append(stat.percentiles1.total);
    $("#percentiles1OK").append(stat.percentiles1.ok);
    $("#percentiles1KO").append(stat.percentiles1.ko);

    $("#percentiles2").append(stat.percentiles2.total);
    $("#percentiles2OK").append(stat.percentiles2.ok);
    $("#percentiles2KO").append(stat.percentiles2.ko);

    $("#meanNumberOfRequestsPerSecond").append(stat.meanNumberOfRequestsPerSecond.total);
    $("#meanNumberOfRequestsPerSecondOK").append(stat.meanNumberOfRequestsPerSecond.ok);
    $("#meanNumberOfRequestsPerSecondKO").append(stat.meanNumberOfRequestsPerSecond.ko);
}
