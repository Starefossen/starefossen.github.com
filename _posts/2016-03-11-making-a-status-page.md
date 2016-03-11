---
layout: post
title: Making a Status Page
date: 2016-03-11
tag: [devops, uptime, monitoring]
twitter: starefossen
published: true
---

We recently had (another) a major outage from one of our payment providers. I
decided to make a simple status page that we could direct customers to when
something like this happened next time.

![System Status Page](/uploads/2016/03/11/system-status.gif)

<!--more-->

## Vision

[pyupio/statuspage]: https://github.com/pyupio/statuspage
[CachetHQ/Cachet]: https://github.com/CachetHQ/Cachet
[Status.io]: https://status.io/
[StatusPage.io]: https://www.statuspage.io/

The status page should use existing monitoring infrastructure - we don't want to
duplicate the monitoring effort already in place. The status page itself should
be statically hosted, to minimize the risk of the status page itself going down,
and fetch service status dynamically - client side - so it does not need to be
updated manually.

Status page is not a new thing, in fact there quite a few alternatives out
there. [pyupio/statuspage] and [CachetHQ/Cachet] are two open source
alternatives; while [Status.io] and [StatusPage.io] are two commercial
proprietary options. As a hacker for a non-profit organization the proprietary
ones were out of the question :wink:

I ended up borrowing layout, and concepts, from [pyupio/statuspage] - a shout
out goes to @pyupio for sharing such a solid piece of work with the community
:tada:

## Service Status

[Pingdom API]: https://www.pingdom.com/resources/api
[Starefossen/status-api]: https://github.com/Starefossen/status-api

As I mentioned, we already had extensive monitoring of applications, internal-
and external services set up through Pingdom. All outages are posted directly to
a Slack channel in real time. If left unresolved for enough time alerts are sent
out through push notifications and SMS.

The [Pingdom API] requires user authentication - of course - in order to get out
any status data. This would be a problem for the client side status page vision.
In order to overcome this restriction I made a simple API proxy (written in
Node.js :rocket:) dubbed [Starefossen/status-api].

```
GET /api/v1/checks HTTP/1.1
Host: status.app.dnt.no

HTTP/1.1 200 OK
Access-Control-Allow-Origin: *
Content-Type: application/json; charset=utf-8

{
    "checks": [ ... ]
}
```

Since we have more checks than what we would like, or should, expose on a status
page we needed to organize our existing checks. Pingdom had the solution – tags.
We tagged all checks we would like to expose with `public` as well as what kind
of check this was `app`, `service`, or `payment`.

![Pingdom Check Tags](/uploads/2016/03/11/tags.png)

## Incident Messages

[Turistforeningen/status]: https://github.com/Turistforeningen/status

The next thing we would like for our status page was the ability to post
messages about various incidents. We wanted to reuse existing infrastructure as
much as possible and we know GitHub had an awesome API, that could even be used
without any user authentication.

We could simply create issues directly in the [Turistforeningen/status] issue
tracker on GitHub and fetch them using the GitHub API. This was just what we
needed! We added some labels to indicate outage status levels and others to
indicate the various systems that could be affected.

![GitHub Issue Labels](/uploads/2016/03/11/labels.png)

Closing the issues would resolve the incident and return the status page to it's
normal green status.

## The Power of GitHub Pages

[GitHub Pages]: https://help.github.com/articles/what-are-github-pages/

All we needed now was a reliable place to host the status page static files
(`index.html`, JavaScript, and CSS). Since the source code was up on GitHub and
we have had good experience with [GitHub Pages] it was the obvious decision.

```
> git push -u origin gh-pages
```

[status.dnt.no]: http://status.dnt.no
[MIT license]: https://github.com/Turistforeningen/status/blob/gh-pages/LICENSE

By adding a `CNAME` file with we could use a custom domain like [status.dnt.no].
The complete source code is up at [Turistforeningen/status] and licensed under
the [MIT license].

* **Also read:** [Jekyll 3 and GitHub Pages](/post/2016/02/11/jekyll-3-on-github-pages/)

## Future Work

As any other project, the Status Page is not done done - there is always more
features that could be implemented. Here are some of my thoughts for future
improvements.

### Response Time

Service response time is currently not considered. Service status could be based
on a threshold with regards to the average response time over x amount of time
in addition to the downtime.

Response time graphs would also be a nice addition to the `operational` and
`major outage` labels.

### Downtime

Currently the Status Page only checks how long since last reported downtime.
This is because the Pingdom API only returns this when listing all the checks.
A natural thing to do would be to fetch the duration from the `summary` API
endpoint for services with downtime within some amount of time.
