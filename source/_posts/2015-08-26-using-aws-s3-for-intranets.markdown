---
layout: post
title: "Private Websites in S3 Buckets"
date: 2015-08-26 14:25:25 +1000
comments: true
categories: 
- S3
- static website
- intranet
- private
---

Many people now realise that you can use Amazon Web Services (AWS) S3 buckets to [host a static website](http://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteHosting.html).

This is cool because it is very reliable and extremly cheap.
You don't pay to have an EC2 instance constantly running

- you just get charged s3 costs
- $0.03 per GB and $0.004 per 10000 requests.

But what if I want to host my company private web pages?
Can I use S3?
Will other people be able to see my stuff?

The answer is yes you can use S3.

The trick is you need to modify the bucket policy to have constraints.

For example here is a public s3 buckets policy:-

```
{
  "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "PublicReadGetObject",
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::testfoo/*"
        }
      }
    ]
}
```

And here is a policy that allows access only from my ip address or CIDR range
and denies a some other specified ip-addreses that would otherise be included.

NB any other ip is automatically excluded too

```
{
  "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "PublicReadGetObject",
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::testfoo/*",
        "Condition": {
          "IpAddress": {
            "aws:SourceIp": "150.101.204.0/24"
          },
          "NotIpAddress": {
            "aws:SourceIp": "150.101.204.188/32"
          }
        }
      }
    ]
}
```

The full list of AWS Condition keys is available [here](http://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements.html#AvailableKeys)

Cheap private web hosting here I come!
