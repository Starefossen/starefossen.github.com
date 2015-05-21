---
layout: post
title: "Django Performance: POSTGIS_VERSION"
date: 2015-05-21
tag: [django, performance, postgis, geodjango]
twitter: starefossen
published: true
facts:
  - title: Norwegian Trekking Association (DNT)
    facts:
      - Norway's largest outdoor life organization.
      - 250.000 members across 57 local member organizations.
      - Maintain a network of 20,000 km marked foot trails and 7000 km of
        branch-marked ski tracks.
      - DNT activities are based on extensive volunteer work spanning more
        than 175,000 work hours each year.
    source: dnt.no
  - title: Django
    facts:
      - Free and open source web application framework, written in Python.
      - Emphasizes reusability and "pluggability" of components, rapid
        development, and the principle of don't repeat yourself.
      - Initial release July 21th 2005.
      - Maintained by the Django Software Foundation (DSF).
    source: djangoproject.com
---

This is the first post in a series of posts about boosting performance in the
main Django application for the [Norwegian Trekking
Association](http://english.turistforeningen.no) (DNT).  The application is
scheduled to serve all of DNTs 200+ official web sites with a total of 1.5
million monthly page views by the end of 2015.

<!--more-->

[Sherpa](https://github.com/turistforeningen/sherpa) is a fairly typical Django
application.  It uses Django 1.7 served through Gunicorn 1.8 via Nginx 1.9 using
memcachd 1.4 for caching and Postgres 9.3 with Postgis 2.1 as its main database.
I will try to get a another post out outlining the technical details of our
production setup soon.

## Step 1 - Gathering Data

We have been measuring the response time of some key pages through our Pingdom
monitoring checks for years, and they all yielded the same average of 730ms
(originating from Europe since our servers are located in the eu-west-1 aws
region).

![Pre Response Time](/uploads/2015/05/21/response_pre.png "Pre Response Time")

Other than that we had fairly little data to work with so we decided to log all
Postgres queries <del>longer than 300 ms</del> over the weekend using the [
log\_min\_duration\_statement](http://www.postgresql.org/docs/current/static/runtime-config-logging.html#GUC-LOG-STATEMENT)
method as suggested in [this Postgres wiki
page](https://wiki.postgresql.org/wiki/Logging_Difficult_Queries) on logging
difficult queries. **Update:** We later learned that our configuration was not
entirely correct, and subsequently *all* queries were logged. 😁  Oops!

## Step 2 - Analyze

When we returned to work next Monday we had 10 GB of query logs to sift through.
😥.  A few days later the log file had doubled in size!  [Postgres System Impact
report (pgsi)](https://bucardo.org/wiki/Pgsi) to the rescue!

```
perl pgsi.pl --file=postgresql-head.log > pg_analyze.html
```

Now we had a nicely formatted html page with all the different queries ordered
by type (SELECT, INSERT, UPDATE, etc) and system impact.  The first entry
immediately stood out as a big surprise! 😮

```
System Impact:    3.43
Mean Duration:    9.69 ms
Median Duration:  5.34 ms
Total Count:      624439
Mean Interval:    282.11 ms
Std. Deviation:   208.81 ms

SELECT postgis_lib_version()
```

The query with the most system impact of all the logged queries was a simple
call to retrieve the version of the installed PostGIS library.  How could this
be? The total count for this query indicated that it had to be executed for each
request to the application.

Searching the [django/django](https://github.com/django/django) repository on
GitHub returned one result for a test, and one in what appeared to be the
PostGIS driver for Django / GeoDjango – no issues 😕.

```python
def postgis_lib_version(self):
    "Returns the version number of the PostGIS library used with PostgreSQL."
    return self._get_postgis_func('postgis_lib_version')
```

Upon further inspection of [the
driver](https://github.com/django/django/blob/master/django/contrib/gis/db/backends/postgis/operations.py#L297)
we reviled the following function call chain: `postgis_lib_version()` <=
`postgis_version_tuple()` <= `spatial_version()`.  In the `spatial_version()`
function definition there where this comment:

> Trying to get the PostGIS version because the function signatures will depend
> on the version used.  The cost here is a database query to determine the
> version, which can be mitigated by setting `POSTGIS_VERSION` with a 3-tuple
> comprising user-supplied values for the major, minor, and subminor revision of
> PostGIS.

And there we had it! For each connection to the Postgres database Django's
PostGIS driver would try to determine what version of PostGIS was installed in
order for it to communicate correctly.  This is done by executing the
`postgis_lib_version` function **unless** `POSTGIS_VERSION` setting is set.

## Step 3 - Act

We quickly added `POSTGIS_VERSION` based on an environment variable to our
Django settings, and deployed to production.

```
if 'POSTGIS_VERSION' in os.environ:
    POSTGIS_VERSION = os.environ['POSTGIS_VERSION']
```

## Step 4 - Profit

Response time immediately dropped by 45%, from 730ms to 400ms. We would never
have expected these two lines of code to impact the overall performance of the
system in such a way!

![Post Response Time](/uploads/2015/05/21/response_post.png "Post Response Time")
