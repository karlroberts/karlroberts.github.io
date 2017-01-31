---
layout: post
title: "push a docker image to a personal repository"
date: 2017-01-25 13:30:53 +1100
comments: true
published: true
categories:
- docker
---
## Why push your own image?
After using docker for a while you may find that you want more control over the images you want to base your containers on.<!--more-->

If you have a Dockerfile, you can always use it to build an image locally using

    docker build .

Alternatively if you want the image to have a tag name to make it easier to recognise

    docker build -t myimage .

After the base image has downloaded and all the commands in the Docker file have run you'll have an image locally.

This is great as it gives you the ability to spin up a container based on the image and run a command there, such as to kick off your micro-service.

    # find the correct image id

    $ docker image ls
    REPOSITORY                                     TAG                 IMAGE ID            CREATED             SIZE
    <none>                                         myimage             5f157f802a51        2 minutes ago       533 MB
    ubuntu                                         xenial-20160914     45bc58500fa3        4 months ago        127 MB

    # start the container and ls the home dir as an example rather than start
    # my super-cool microservice
    $ docker run --name mycont1 5f157f802a51 ls

A potential issue with the above process is that if I want a co-worker to kick of his micro service, or we want to run it in 
multiple "environments" then he will have to run the docker build first and then run it.

This takes some time

Imagine  how long it would take if your container was based on ubuntu 
and in the Dockerfile you ran `apt-get update` and `apt-get upgrade -y`, not to mention the time it takes to install
necessary software such as Java, Mono, Python or Ruby. The whole process could easily take 10 minutes or more to run the build.

But that isn't the biggest problem. What if a Python dependency or Ruby Gem had changes since you ran your build?
Not only could the install fail because, in this case, other different dependencies would need to be pre-installed
but also your co-worker's build will now be different to yours.

All your version controlled guaranties are now moot.

Clearly we want him to have the same exact image as us.

## Create an image from your container
The way to do this is to create an image from your container. In Docker-speak we will `commit` the image.
Think of it like committing all the changes to the layered file system that you have made in the container after starting it from an image.

If you run up your container as described above, then you need to find out its container ID. 

If it is still running use:

    $ docker ps

If it has stopped use:

    $ docker ps -a

You will see info about your container, this is where naming the container using the `-name` flag, see above, will be useful. For example this is what I see:

    $ docker ps -a
    CONTAINER ID    IMAGE          COMMAND        CREATED         STATUS                       PORTS   NAMES
    2fdc41c14fc6    5f157f802a51   "/bin/sh ls"   7 minutes ago   Exited (137) 13 seconds ago          mycont1

So the container Id for `mycont1` is `2fdc41c14fc6`. I can now use this to commit an image. Note that you can even cut an image if the container is running because by default it will pause the container before committing, see `man docker commit`

Now you can create the image

    $ docker commit -m "my microservice added to ubuntu xenial" -a "Karl" 2fdc41c14fc6 ubuntu-xenial-mymicro

You can see the newly minted image as before

    $ docker image ls
    REPOSITORY              TAG                 IMAGE ID            CREATED             SIZE
    ubuntu-xenial-mymicro   latest              d2c713fdb832        10 seconds ago      795 MB
    ubuntu                  xenial-20160914     45bc58500fa3        4 months ago        127 M

## Push to a repository
Now we have an image we want to push it to our repository so our co-workers can pull and run up a container from it.

The trick to all of this is that Docker uses the image tag name in a special way. When you pull or run an image the name you give it is actually a location (URI) that also refers to the repository host. By default if no host is specified then the [Docker hub repo](https://hub.docker.com/) is assumed.

Therefore if you wanted to push your image to Docker Hub, you would first create an account to get a Docker ID that also maps to a "repo" in Docker Hub,
e.g. if my Docker ID was `karlcode` I would create an image tag that referenced my repo in Docker Hub. Remember that "Docker Hub" is assumed so I could do this:

    docker tag ubuntu-xenial-mymicro karlcode/ubuntu-xenial-mymicro:latest
    docker push karlcode/ubuntu-xenial-mymicro:latest

This creates a tag of my image, you can use `docker image ls` to confirm this, and then uses the tag to push the image to the repository host/repo of the same name as the tag.

Of course you would need to let docker know how to login to your docker hub account in order to run the push.

This is done with the `docker login` command.

It asks for your Docker Hub Docker ID and password and stores a token in your HOME directory at `~/.docker/config.json` if you have not run `docker login` before, so you don't need to login every time you push or pull.

## Push to your private repository
The same principle applies to push to a private repository such as your company's own Docker repository. The only difference is that you need to specify the repository host in the tag name.

Lets say that my repository was running at `docker.owtelse.com` running on port `443` and that my project is called `magicmicro` I may choose to do this:-

    $ docker login docker.owtelse.com:443
    $ docker tag ubuntu-xenial-mymicro docker.owtelse.com:443/magicmicro/ubuntu-xenial-mymicro:latest
    $ docker tag ubuntu-xenial-mymicro docker.owtelse.com:443/magicmicro/ubuntu-xenial-mymicro:20170125

I would then have local images which we can see like:-
    
    $ docker image ls
    REPOSITORY                                                TAG              IMAGE ID      CREATED          SIZE
    docker.owtelse.com:443/magicmicro/ubuntu-xenial-mymicro   20170125         d2c713fdb832  10 minutes ago   795 MB
    docker.owtelse.com:443/magicmicro/ubuntu-xenial-mymicro   latest           d2c713fdb832  10 minutes ago   795 MB
    ubuntu-xenial-mymicro                                     latest           d2c713fdb832  10 minutes ago   795 MB
    ubuntu                                                    xenial-20160914  45bc58500fa3  4 months ago     127 M

You may notice that I have two alias for my image with two tags one with the date and the other with the `latest` tag.

Images with the `latest` tag are  pulled by default if the tag is not specified.

This allows a user to easily get the latest version by not specifying a preference or by picking a specific release, e.g. for debugging a particular version or for a production environment.

Now to push it:-

    $ docker push docker.owtelse.com:443/magicmicro/ubuntu-xenial-mymicro:latest
    $ docker push docker.owtelse.com:443/magicmicro/ubuntu-xenial-mymicro:20170125

And that is it!

## Test it
To prove this to yourself, delete the local images, remember to use your own image ID in the command below :-

    $ docker rmi -f docker.owtelse.com:443/magicmicro/ubuntu-xenial-mymicro
    $ docker rmi -f d2c713fdb832

Then you can pull the image from your private repo and use `docker image ls` to confirm you have it

    $ docker pull docker.owtelse.com:443/magicmicro/ubuntu-xenial-mymicro:latest

Alternatively you and you co-worker can simply try to run it. If you have already run `docker login docker.owtelse.com:443` the image will download and run, when you type:

    $ docker run --name mymicro docker.owtelse.com:443/magicmicro/ubuntu-xenial-mymicro:latest

For more info see the man page `man docker push`.

I hope you find this information useful and you are now able take more advantage of Docker in both the development and production environment.

The end.
