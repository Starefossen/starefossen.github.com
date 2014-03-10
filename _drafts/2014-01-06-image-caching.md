---
layout: post
title: "Caching images by intercepting 404s"
date: "2014-01-06 07:29:00 +0100"
twitter: starefossen
tag: [javascript, caching]
---

I recently had the pleasure to do some work with a new REST API. For my
particular use case the API was not fairly well optimized. I needed to list a
set of items and show their related images.

## The Problem

The REST API consists of three API enpoints:

1. `GET /items/` - returns `N` items
2. `GET /items/:item_id/` - returns `M` image ids
3. `GET /images/:image_id/` - returns image url

In order to get an image for a given item you first need to know the `item_id`
and then the `image_id`. In order to accomplish this I had to do `2N`
requests to the API where `N` is the number of items returned from `GET /items/`.

<!--more-->

## Solution 1: Fetch everything at once

Fetching the first image for all items could be done in the following way using
this psudocode procedure.

```
items = http.get("/items/")

for id in items
  item = http.get("/items/" + id)
  image = http.get("/images/" + item.images[0])
end for
```

Each request to the API takes `250ms` to process and at least `16` items are returned
from `GET /items/`.  `250 * 2 * 16`

