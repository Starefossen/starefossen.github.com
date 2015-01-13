#!/bin/sh

clear

printf "layout (default: 'post'): "
read layout
: ${layout:="post"}

printf "date (default: Y-m-d): "
read date
: ${date:=$(date +"%Y-%m-%d")}

printf "title (default: 'untitled'): "
read title
: ${title:="untitled"}

printf "tag (default: 'rand'): "
read tag
: ${tag:="rand"}

printf "twitter (default: 'starefossen'): "
read twitter
: ${twitter:="starefossen"}

printf "published (default: 'true'): "
read published
: ${published:="true"}

slug=`echo $title | tr '[:upper:]' '[:lower:]' | sed -e 's/[^a-z0-0]/-/g'`

echo "---
layout: $layout
title: $title
date: $date
tag: [$tag]
twitter: $twitter
published: $published
---

" > "_posts/"$date"-"$slug".md"

vim -c "startinsert" + "_posts/"$date"-"$slug".md" -c 'w'

