---
layout: post
title: "Node.js Drama of 2016: Express.js"
date: 2016-02-13
tag: [nodejs, drama, express]
twitter: starefossen
published: true
---

[Express]: http://expressjs.com/

[Express] was originally created by TJ Holowaychuk (@tj) in 2009, under the the
slogan «*Insanely fast (and small) server-side JavaScript web development
framework*». It has since grown to become one of the most widely installed
package from the npm registry with over 4.5 million monthly downloads. Now, it
may be facing a new beginning!

![Screenshot of IBM's acquisition of StrongLoop in TechCrunch](/uploads/2016/02/13/techcrunch.png)

<!--more-->

## Transferred to StrongLoop

[StrongLoop]: https://strongloop.com/
[LoopBack]: http://loopback.io/

To understand the drama surrounding Express you need to know some of the history
of the Express project. Lets rewind to the spring of 2014. Node.js is growing
rapidly much thanked to modules like Express which makes it super easy for
anyone to spin up websites and services using Node.js.

Since 2013 TJ had greatly reduced his involvement in Epxress development, and by
May of 2014 Douglas Wilson (@dougwilson) had more or less taken over the role as
lead maintainer of Express. Then, shortly thereafter, TJ announced he was
leaving the Node.js community[^1] and the Express project would find a new home
at StrongLoop[^2].

[StrongLoop] is the author of the [LoopBack], a framework for creating APIs
built on top of, you might have already guessed it, Express. The transfer of
Express to StrongLoop came as a shock to the maintainers[^3]. They had not been
informed, and they had lost access to the main repository during the transfer.

> […] TJ has not been the one maintaining express day to day for a long time
> and I think this move came as a surprise to all of the current maintainers.
>
> –@defunctzombie ([source](https://github.com/expressjs/express/issues/2264#issuecomment-50509818))

The maintainers were upset and they felt this was a move in the wrong direction.
Rumors of StrongLoop purchasing Express from TJ did not exactly help. TJ even
did a follow up post in an attempt to defuse the situation[^4] but to little or
no avail. StrongLoop co-founder Bert Belder (@piscisaureus) promised Express
would remain an open source project.

> […] express will remain a community open source project; that's what makes it
> interesting in the first place.
>
> -@piscisaureus ([source](https://github.com/expressjs/express/issues/2264#issuecomment-50685504))

![Contributors graph for the Express project](/uploads/2016/02/13/contributors.png)

## Acquired by IBM

Fast forward to September 10Th, 2015. The dust over the transfer to StrongLoop
had settled, and the development of Express had slowly declined. IBM announced
they had acquired StrongLoop[^5] and a prophecy from a year earlier may be about
to come true.

> Strongloop may not be a thing in 1 year or 2 years […]
>
> –@defunctzombie ([source](https://github.com/expressjs/express/issues/2264#issuecomment-50509818))

This leads to a very special situation where the new owner of Express, IBM, and
the employer of the lead maintainer for Express, Sencha Labs, are competing
companies.

> […] @dougwilson (who has maintained express for two years) can no longer
> contribute to the Express project because IBM is a direct competitor to his
> employer.
>
> –@chipersoft ([source](https://github.com/nodejs/TSC/pull/39#issuecomment-178216742))

Whats left of the maintainers, and other concerned user, makes another attempt
to have Express moved to it's own organization on GitHub - under the banner of
«returning Express back to the community». Several attempts was made with IBM
during the fall of 2015 but the situation looked more deadlocked than ever. This
was apparently the last drop for Doug Wilson in a growing frustration with
corporate overlords.

> I did not voluntarily give up on Express, IBM forced me out of this
> repository.
>
> -@dougwilson ([source](https://github.com/expressjs/express/issues/2844#issuecomment-171430278))

By January of 2016 IBM was still figuring out what to do with the sticky
situation they had inherited from StrongLoop acquisition. While more and more
disgruntled users piled on the discussion about what should happen with Express
next, James M Snell (@jasnell) from IBM and Ritchie Martori (@ritch) from
StrongLoop was working with various stakeholders within IBM to conclude a
solution[^7].

> The express project is applying to become an incubating top level project.
>
> –@jasnell ([source](https://github.com/nodejs/TSC/pull/39#issue-129621635))

This stirred up the discussion again, and after a lengthy (and heated)
discussion back and forth, the incubating application was merged. This means, if
everything goes as planned, that Express will become an official Node.js project
outside of what is known as Node.js core.

## Epilogue

[expressjs/express]: https://github.com/expressjs/express/

Express has now been transferred to it's new home at [expressjs/express], and
Doug Wilson also transferred the ownership of his modules that Express depends
on, either directly or indirectly, to the Node.js foundation.

> I am donating all of my Node.js modules to the Node.js foundation, to go along
> with Express.
>
> –@dougwilson ([source](https://github.com/expressjs/express/issues/2844#issuecomment-177043519))

The intellectual property of Express, however, is still owned by IBM and will
probably remain so for a long time. The API documentation, a blog post worthy in
and of itself, will be pulled into the main repository[^8].

>  […] currently there is no IP transfer indicated. The question over the
>  expressjs.com domain name will need to be looked at again a bit later but it
>  will not be included in this initial proposal.
>
> –@jasnell ([source](https://github.com/nodejs/TSC/pull/39#issuecomment-181944178))

:sparkles: Stay tuned for more drama! :sparkles:

## Footnotes

[^1]: [Farewell Node.js - Leaving node.js land](https://medium.com/@tjholowaychuk/farewell-node-js-4ba9e7f3e52b#.kta3541lp)
[^2]: [TJ Holowaychuk Passes Sponsorship of Express to StrongLoop](https://strongloop.com/strongblog/tj-holowaychuk-sponsorship-of-express/)
[^3]: [This repo needs to belong in the expressjs org](https://github.com/strongloop/express/issues/2264)
[^4]: [StrongLoop & Express](https://medium.com/@tjholowaychuk/strongloop-express-40b8bcb8e5af#.vsa9sx3zs)
[^5]: [IBM Acquires StrongLoop to Extend Enterprise Reach using IBM Cloud](http://www-03.ibm.com/press/us/en/pressrelease/47577.wss)
[^6]: [adjust TSC membership for IBM+StrongLoop](https://github.com/nodejs/node/pull/2858)
[^7]: [Add initial TLP application for express](https://github.com/nodejs/TSC/pull/39)
[^8]: [Move API doc source from expressjs.com repo](https://github.com/expressjs/express/issues/2887)
