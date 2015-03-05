---
layout: post
title: Geospatial Data for Developers
date: 2014-04-23
tag: [geodata, gis]
length: 15 minutes
twitter: starefossen
published: true
---

In your class algebra class you that x and y coordinates marks the position of a point in a grid
(e.g. a graph). You might have heard about one or thwo coordinate systems in geography class and a
few might have used a map and a compass for orientation while hiking. But that is probably it. For
all intents and purposes you are orienting yourself on a mosly flat suface.

<div class="thumbnail">
  <img src="/uploads/2014/04/23/graph_4.gif" alt="...">
  <div class="caption"><strong>Figure 1</strong> <small>Point <em>P</em> with the (x,y) coordinate pair of (2,1).</small></div>
</div>

In this post I will attempt to give a short introduction to geospatial data and some commonly known
geospatial information systems which might come in handy for software developers if you wnat to work
with maps or other location aware software. I have no formal background in geomatics but experience
working with geospatial data and systems professionally for some years now.

## What is geospatial data?

`Geospatial` data, or `geodata` for short, is data with a spatial component (i.e. an object that
occupies some ammount of space), most commonly on the surface of the earth [1]. Geospatial is an
industry made term which is an attempt of a middle ground between the very broad term `spatial`
(having to do with space) and the narrow term `geographical` (its graphicial presentation) [2].

`Note` Add some nice examples here :)

## Why is this important?

`Note` Why this understanding important for developers.

## Coordinate Systems

### Geographic Coordinate Systems (GCS)

* graticular network
* spheriods and spheres
* datum

### Projected Coordinate Systems (PCS)

*

## Geospatial Information Systems (GIS)

### Popular formats

* Shape
* KML
* GeoJSON

### WMS and WFS

If you have

### Popular systems

* ArcGIS by eris (commercial)
* QGIS (open source)


### Popular tools

* GDAL

```json
$ ogr2ogr -f "GeoJSON" /tmp/world.json world_borders.shp world_borders
$ cat /tmp/world.json
{
  "type": "FeatureCollection",
  "features": [
    { "type": "Feature", "properties": { "CAT": 1.000000, "FIPS_CNTRY": "AA",
      "CNTRY_NAME": "Aruba", "AREA": 193.000000, "POP_CNTRY": 71218.000000 },
      "geometry": { "type": "Polygon", "coordinates": [ [ [ -69.882233, ...
       ...
```
Source: http://stackoverflow.com/a/2251856/2384509

## Litterature

* [1] [Define “geospatial data” for a non-GIS professional](http://gis.stackexchange.com/questions/735)
* [2] [Spatial data? Geodata? Geographic Data? Geospatial data?](http://gis.stackexchange.com/questions/34733)
* [] [What are Raster and Vector data in GIS and when to use?](http://gis.stackexchange.com/questions/7077)
* [] [What's the difference between a projection and a datum?](http://gis.stackexchange.com/questions/664)
* [] [Spatial reference for dummies?](http://gis.stackexchange.com/questions/22996)

* [] [Geospatial Data Abstraction Library](http://www.gdal.org)
* [] [OGR2OGR Cheatsheet](http://www.bostongis.com/PrinterFriendly.aspx?content_name=ogr_cheatsheet)
* [] [Reprojecting geographic features](http://www.directionsmag.com/articles/reprojecting-grids/124167)
* [] [Cartographical Map Projections](http://www.progonos.com/furuti/MapProj/Normal/TOC/cartTOC.html)
* [] [MKMapView and Zoom Levels: A Visual Guide](http://troybrant.net/blog/2010/01/mkmapview-and-zoom-levels-a-visual-guide/)

