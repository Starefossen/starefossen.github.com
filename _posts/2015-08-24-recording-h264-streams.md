---
layout: post
title: Recording H.264 Streams
date: 2015-08-19
tag: [media, h.264, ffmpeg]
twitter: starefossen
published: true
facts:
  - title: ffmpeg
    facts:
      - ffmpeg is a command line program for transcoding multimedia files.
      - It supports the most obscure ancient formats up to the cutting edge.
      - It is licensed under the terms of the GNU LGPL 2.1 license.
      - Latest stable release v2.7.2 of July 20, 2015.
    source: ffmpeg.org
  - title: H.264
    facts:
      - Also known as MPEG-4 Part 10, Advanced Video Coding (MPEG-4 AVC).
      - One of the most used video coding format recording, compressing, and
        distributing video content.
      - It is widely used by video streaming services, such as Vimeo, YouTube,
        and the iTunes Store.
      - H.264 is typically used for lossy compression in the strict mathematical
        sense of the word.
    source: wikipedia.org
---

This is a project I did a while a go, but I never got a round to write a post
about it 😩  So here it is.  It was a ☔️ wet and cold spring in Norway (like most
of them are).  We were going on a 🚙 trip for the weekend, and I wanted to bring
some 📺 TV shows my son could watch on the way.

![Summer marked trails in Norway](/uploads/2015/08/24/trail.jpg)

Summer marked trails in Norway by Hans Kristian Flaatten.  Licensed under [CC
BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/).

<!--more-->

Here in Norway we have a public broadcasting company - the Norwegian
Broadcasting Corporation (NRK). I have had the opportunity to work with them on
UT.no - Norway's Trip Planner - but more on that later.  NRK makes available all
of their shows through their online media player [tv.nrk.no](https://tv.nrk.no)
for a period of 6 to 12 months before they are taken offline.

All this is well and good, except for the disability to save shows for offline
viewing.  Since we have so spotty cellular connection because of all the high
mountains and deep fjords, and streaming 200 episodes of Sesame Street is not an
economically viable option anyways, I opted for making my own offline copies.
[ffmpeg](http://ffmpeg.org) 🎥 to the rescue!

## m3u-to-mp4

Getting the `m3u`-steam was just a matter of right clicking on it in Safari and
saving to disk. Once I had the `m3u` playlist file it was time to fire up
`ffmpeg`, and by the way, there's a [Docker Image for
that](https://hub.docker.com/r/nachochip/ffmpeg/) 😅

`m3u` is not the actual video stream itself. It is just a playlist composed of
links to several small videos that are downloaded and played in rapid succession.
ffmpeg has built in support for downloading and concatenate into one video file.

```
ffmpeg -i playlist.m3u -c copy -bsf:a aac_adtstoasc recording.mp4
```

Here is a rundown of what the different [cli
flags](http://ffmpeg.org/ffmpeg.html) do:

* `-i playlist.m3u` is location of the playlist file we want to record.
* `-c copy` do not re-encoding the video stream since it is already the desired
  format of H.264.
* `-bsf:a aac_adtstoasc` converts the audio such that it is compatible with the
  `mp4` container.
* `recording.mp4` is the location of the outputted recording.


### 🐳 Docker All Things

Since I do not install program directly on my computer any more I of course had
to run this too in a Docker container. You can check out the project on
[github.com/Starefossen/m3u-to-mp4](https://github.com/Starefossen/m3u-to-mp4) 🚀

```bash
docker run --rm
  -v $(pwd)/playlists:/playlists
  -v $(pwd)/recordings:/recordings
  nachochip/ffmpeg
    -i /playlists/episode1.m3u
    -c copy
    -bsf:a aac_adtstoasc
    /recordings/episode1.mp4
```
