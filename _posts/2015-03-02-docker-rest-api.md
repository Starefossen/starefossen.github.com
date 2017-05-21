---
layout: post
title: Docker REST API
date: 2015-03-02
tag: [devops, docker]
twitter: starefossen
published: true
---

<p class="lead">Docker has an awesome REST API right out of the box – no other
tools are required. The API is actually what is powering the docker CLI, and a
bunch of other Docker related tools, which means anything you can do via the
CLI can be done through the API.</p>

By default the API is avaiable through through `unix:///var/run/docker.sock`,
but if you like you can have Docker listen on a TCP port as well by using the
`-H tcp://addr:port` option [1]. Make sure you know what you are doing before
exposing Docker over a TCP port; failure to do so may expose all only Docker
containers to the entire Internet.

### API Endpoints

`@TODO`

### Practical Example

Lets try to spin up a [Redis](http://redis.io) server inside a new Docker
container using the official [redis image](https://registry.hub.docker.com/_/redis/).

```
docker run --name redis -v /some/dir:/data redis:2.8 redis-server
```

The algorithm for replicating the above `docker run` command onto the API is
fairly simple and straight forward:

 1. Create the container
 2. Start the container
 3. Attach to the container output

Lets create the a container based of the `redis:2.8` image.

```
    POST /containers/create?name=redis HTTP/1.1
    Content-Type: application/json

    {
      "Cmd": [
        "redis-server"
      ],
      "Image": "redis:2.8",
      "HostConfig": {
        "Binds": [
          "/some/dir:/data"
        ]
      }
    }
```

If the container was successfully crates a `201` response code will be
returned. The response will also include the `id` of the newly created
container. We need this in subsequent requests to the API.

```
    HTTP/1.1 201 Created
    Content-Type: application/json

    {
         "Id":"e90e34656806"
         "Warnings":[]
    }
```

A `404` response code indicates that the `image` we specified does not yet
exist on this Docker host. We need to pull that image from the Docker Regstry,
and then retry the request above.

```
    POST /images/create?fromImage=redis&tag=2.8 HTTP/1.1
    Content-Type: application/json
```

We are now ready to start the container.

```
    POST /containers/(id)/start HTTP/1.1
    Content-Type: application/json
```

```
    POST /containers/(id)/attach?logs=1&stream=1 HTTP/1.1
    Content-Type: application/json
```

### UNIX Socket Communication


From the `nc` man page:

> The nc (or netcat) utility is used for just about anything under the sun
> involving TCP or UDP. It can open TCP connections, send UDP packets, listen
> on arbitrary TCP and UDP ports, do port scanning, and deal with both IPv4 and
> IPv6.

```
echo -e "GET /images/json HTTP/1.0\r\n" | nc -U /var/run/docker.sock
```

[1] http://docs.docker.com/reference/commandline/cli/#daemon-socket-option
