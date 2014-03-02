#!/bin/sh

clear

printf "layout (default: 'default'): "
read layout
: ${layout:="default"}

printf "date (default: Y-m-d): "
read date
: ${date:=$(date +"%Y-%m-%d")}

printf "title (default: 'untitled'): "
read title
: ${title:="untitled"}

printf "category: "
read category

printf "published (default: 'true'): "
read published
: ${published:="true"}

echo "---
layout: $layout
title: $title
category: $category
published: $published
---


" > "_posts/"$date"-"$title".md"

vim -c "startinsert" + "_posts/"$date"-"$title".md" -c 'w'

jekyll --no-server

