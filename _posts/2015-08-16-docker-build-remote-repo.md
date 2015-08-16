---
layout: post
title: Building Docker Images from remote repositories
date: 2015-08-16
tag: [docker]
twitter: starefossen
published: true
---

I recently wanted to build a Docker Image directly form a source repository
without having to clone the repository locally *before* building it. This turned
out to be such a neat little trick that I thought it was worth sharing.

<!--more-->

Inspecting what the `docker build` command had to offer with regards to building
repote repositories yield an interesting parameter named `URL`.

```
$ docker build --help
> Usage: docker build [OPTIONS] PATH | >>> URL <<< | -
> Build a new image from the source code at PATH
```

Consulting the [online build
documentation](http://docs.docker.com/reference/commandline/build/) confirmed my
suspicion that this was in fact an option to build a Docker Image directly form
a remote repository.

> The URL parameter can specify the location of a Git repository; the repository
> acts as the build context.

The URL parameter also has the optional possibilities to specify a which branch,
tag, or commit sha to build, as well as the location (directory) of the
Dockerfile you want to build.

```
$ docker build https://github.com/docker-library/hello-world.git#master:/
> Sending build context to Docker daemon 132.1 k
> Sending build context to Docker daemon
> Step 0 : FROM scratch
>  --->
> Step 1 : COPY hello /
>  ---> a1e6124c9115
> Removing intermediate container b27bf9c2271f
> Step 2 : CMD /hello
>  ---> Running in 80cd51769b8e
>  ---> 3ec9c8c47f66
> Removing intermediate container 80cd51769b8e
> Successfully built 3ec9c8c47f66
```

### Epilogue

I later realized that the repository is cloned locally behind the scenes which
makes that sense when you think about authentication, vpn etc to private
repositories.

> This command runs in a temporary directory on your local host. After the
> command succeeds, the directory is sent to the Docker daemon as the context.
> Local clones give you the ability to access private repositories using local
> user credentials, VPNs, and so forth.

### A Node.JS Example

If you are interested in how to build a remote repository using the Docker Remote
API with the [dockerode](https://github.com/apocas/dockerode) Docker client
library for Node.JS, this is how you do it:

```javascript
const options = {
  t: 'docker-library/hello-world',
  remote: 'https://github.com/docker-library/hello-world.git',
};

docker.buildImage(null, options, function(err, res) {
  if (err) { throw err; }

  res.on('data', function(data) {
    console.log(data.toString());
  });
});
