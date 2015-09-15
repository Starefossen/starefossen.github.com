---
layout: post
title: Atom (RSS) feeds for GitHub Pages
date: 2015-09-16
tag: [GitHub Pages]
twitter: starefossen
published: true
---

GitHub recently rolled out support for automatic ATOM (RSS) feed generation for
their GitHub Pages platform. It literally only take seconds to set up and get
going!

<!--more-->

### _config.yml

Add the [`jekyll-feed` gem](https://github.com/jekyll/jekyll-feed) to the list
of installed gems for your Jekyll blog. Make sure you have filled out `name`,
`description`, and `author` information too.

```yaml
name: "Blog Name"
description: "Blog Description"
author:
    name: "Your Name"
    email: "you@email.com"

...

gems:
    - jekyll-feed
```

### &lt;head&gt;

Inside the `<head>` tag, add the {% raw %}`{% feed_meta %}{% endraw %}` tag to
automatically add a link to your ATOM feed. This makes you ATOM feed visible to
users visiting your blog with a capable feed reader.

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    {% raw %}<meta name="description" content="{{ site.description }}">{% endraw %}

    <!-- jekyll-feed link -->
    {% raw %}{% feed_meta %}{% endraw %}
  </head>
```

### 🐳  Testing Locally

You are running Docker right?! If so, just pull the [`starefossen/github-pages`
Docker Image](https://github.com/Starefossen/docker-github-pages) and your blog
is up and running locally without having to install a single thing!

```
$ docker pull starefossen/github-pages
$ docker run --rm -it -v "$PWD":/usr/src/app -p "4000:4000" starefossen/github-pages
```

**ProTip™** Changes reloads automatically as you go when using the Docker Image!

### 💰  Profit

Commit and push you changes to GitHub and your ATOM feed is up and running in
under a minute!
