---
layout: post
title: Testing Docker apps with Wercker
date: 2015-05-19
tag: [docker, testing, ci]
twitter: starefossen
published: true
facts:
  - title: Docker
    facts:
      - Docker is an open platform for developing, shipping, and running
        applications.
      - First released 13th of March 2013.
      - You can build Docker images that hold your applications.
      - You can create Docker containers from those Docker images to
        run your applications.
      - You can share those Docker images via Docker Hub or your own
        registry.
    source: docs.docker.com
  - title: Wercker
    facts:
      - Wercker is a continuous delivery platform made by engineers previously
        with OpenStack, Google AppEngine, Simple, Digg and Disqus.
      - Launched publicly early 2012.
      - Initial Docker support November 2013.
      - Second round of funding October 2014.
      - Full Docker support April 2015.
    source: wercker.com
---

Wercker is a free and hosted continuous delivery platform with a lot of
flexibility.  Wercker offers everything you expect from a CI service, and
recently announced full support for the Docker container runtime.

![Wercker Promo](/uploads/2015/05/19/wercker.png "Wercker Promo")

<!--more-->

The Wercker platform has two modes (known as stacks) to run applications;
`Classic` using custom made pre-built containers, and `Ewok` using the Docker
container runtime.  If you don't know what Docker is, I suggest you read [this
article](http://docs.docker.com/introduction/understanding-docker/) in order to
get a basic understanding of Docker.

With the `Ewok` stack your application is run using Docker containers from
Docker Hub - linked together just as you would have locally or in production.
Yay for identical environments!!

## Boxes

You application code is run in a primary container (known as a `box`).  In Ewok
the name this `box` is the name of a [Docker
image](http://docs.docker.com/terms/container/) from [Docker
Hub](https://hub.docker.com/) + an optional image tag.

```yaml
box: node:0.10
```

## Services

Adhering to the [Docker best
practices](https://docs.docker.com/articles/dockerfile_best-practices/) you
should only run a single process per container.  If your application depends on
another service (such as a database or a cache) you can link multiple containers
together using `services`.

The services directive looks just like a box, but you can define as many of them
as you like.  They will automatically be linked together with your box before your
application starts.

```yaml
services:
    - mongo:2.6
    - redis:2.8
```

When Wercker starts, any service you have defined will be started and [linked
together](http://docs.docker.com/userguide/dockerlinks/) with your box
automatically.  The IP-address of a given service will be available as a
hostname corresponding to the name of the image.  Any ports exposed by the
container can be used as they are.

Wercker also has support for [advanced service
configurations](http://devcenter.wercker.com/docs/services/advanced-services.html),
such as injecting custom environment variables and altering the startup command.

```yaml
services:
    - id: mariadb
      env:
          MYSQL_ROOT_USERNAME: myusername
          MYSQL_ROOT_PASSWORD: mysecretpassword
```

## Build Steps

Your containers are started and linked together, and it is time to run the
build. This is done with one, or many, build steps. Wercker has an
astonishingly amount of pre-defined build steps for every language in their
step registry.

```
build:
    steps:
        - npm-install
        - npm-test
```

You can also submit your own build steps to the step registry, or script them in
your build configuration using the `script` build step like this.

```
build:
    steps:
        - script:
            name: my custom script
            code: |
                # some command
                # more command
```

## Putting it all togheter

And there you have it; `box`, `services` and `build steps` all go into one file
in your project repository named `wercker.yml`.  This is your Wercker build
configuration file.

```yaml
box: node:0.10

services:
    - mongo:2.6
    - redis:2.8

build:
    steps:
        - npm-install
        - npm-test
```

## Getting Started

You can read more about the Wercker platform at
[devcenter.wercker.com](http://devcenter.wercker.com), or check out their GitHub
repo [werkcer/docs](https://github.com/wercker/docs) where you can search
through all of their documentation which is nicely formatted in Markdown.

Wercker also provides a lot of example projects to get you started.  Check them
out as well:

 * [Python Wercker Example](https://github.com/wercker/getting-started-python)
 * [Go Wercker Example](https://github.com/wercker/getting-started-golang)
 * [Node.JS Wercker Example](https://github.com/wercker/getting-started-nodejs)
 * [Ruby Wercker Example](https://github.com/wercker/getting-started-ruby)
