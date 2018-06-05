---
layout: post
title: "Stand alone docker container joins a Compose network"
date: 2018-04-27 01:01:22 +0000
comments: true
published: false
categories: 
---

To create a seemless dev env that allows testing of our cloud based production architecture.

tldr;
    dont rely on default (legacy see link???) bridge network run stand alone docker run on a named network (use ENV Var expansion to override default name) see run command snippet.
    ????
    ????

add default env var to compose .env file
    ????

add magic network sauce to compose.yml files name the outside external network that compose doesnt manage use v3.5 yml syntax to make it pretty and use name variable
    ????

run the compose
   ???

perhaps pre-create the docker network if you havnt already kicked off your other container
   docker network create docker-network # you will be told to do this by compose if necessary.

Why? Want a service that I just kick off to have access to compose services or visa versa.
Why? Want to refer to it by name not just by ip address
Why? want to leave my firewall running, if use ip address then a-exposes it b-need to turn off firewall

dev env Ops-Dev
 ionic command run in docker (so dont have complex install just git clone run and go)
 ionic serve exposed so you can debug in the browser

 compose kicks off needed services like database of dynamodb that would normally be in the backend eg provisioned in the cloud. backend rest services exposed as a Spring boot app running locally (mimicing my AWS lambda API gateway deploy see other blog on our Running and dev architecture.

But now we have a problem, ionic serve is on a different port to Spring MVC app which means we have browser CORS problems... to get around this we have compose spinup an NGINX sever to reverse proxy to ionic serve and Spring MVC to make them appear to come from the same domain... now the browser and phone app are happy.
