---
layout: post
title: "Google Contacts API - Service Account Howto"
date: 2014-07-06 10:29:39 +1000
comments: true
categories: [Service Account, Google, Contacts API, Authentication]
---
## Overview
I want to set up a server side App that can read list and filter the Google contacts in our company domain "mycompany.com". This server side app can then be queried by some of our internal webapps to display helpful info.

### Why not simply do it all in javascript?
Dunno. maybe that would be better. We'll See.

### Problems
There are a number of gotchas involved, and misleading documentation to contend with, so I'm going to go through setting up a service account to access your users contact info.

## Google Project <small>Authentication Authorisation</small>
This is likely to be the most confusing part.

For any app to use Googles API's it'll need to ble to authenticate with Google and be authorised to use the API's you want to use, or a subset of the API, eg the ability to read contact info but not edit it, it may also need to be granted permission from a user to see their data.

To allow any of this you need to set up a "Google Project" for your app in the [Google Developer Console](https://console.developers.google.com). The project manages the app's authentication as well as which API's it can use.
In the "API's & Auth" -> API section, add the Contacts api. 
Don't add any others yet, it is best to keep things as simple as possible while setting up your app and to test that your app can connect to the requested API before other authorisations are layered on it.

## Gotchas
* You NEED to make the scope exact including not trailing slashes!
  - eg use `https://www.google.com/m8/feeds` not `https://www.google.com/m8/feeds/`
* The Sevice Account ID is the Service account EMAIL NOT it's Client ID
  - eg `blahblah@@developer.gserviceaccount.com` not `blahblah.apps.googleusercontent.com`
* The service account must be delegated access to the the SCOPE you want it to use
  - see [The Admin SDK Google Docs](https://developers.google.com/admin-sdk/directory/v1/guides/delegation)
* The sevice account has no contacts of it's own so you must supply a User who's contactas you want to snarf, eg `GoogleCredential.Builder().setServiceAccountUser("me@mydomain.com")`
