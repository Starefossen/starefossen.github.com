---
layout: post
title: Automatic Publishing of npm Packages
date: 2015-09-20
tag: [node, npm, jenkins, travis, wercker]
twitter: starefossen
published: true
---

If you are actively maintaining more than a couple of packages in the npm
registry this will be a life saver for you; automatically publish new versions of
your packages directly from your CI server 📡

![Wercker CI deploys to npm](/uploads/2015/09/20/wercker-deploys.png)

<!--more-->

As the *only* package maintainer at [the Norwegian Trekking
Association](http://english.turistforeningen.no), and currently maintaining [16
packages](https://www.npmjs.com/~turistforeningen) in the public npm registry,
time is of essence. Anything that can ease the burden of maintaining all the
packages is a welcomed addition 😅

* **Also read:** [Tagging software releases with git and
  GitHub](/post/2015/04/06/git--tagging-releases/)

## The problem

So what exactly is the problem we are trying to solve? The `npm publish` command
requires the user to be authenticated before they can publish. If you publish
from multiple machines and/or have multiple maintainers you will need to make
sure that all of those are authenticated with npm.

![npm publish command output](/uploads/2015/09/20/npm-publish.gif)

By “manually” having to publish to npm you introduce the risk of publishing
versions that do not pass the tests (you do have tests right?!), and introduce
the possibility of inconsistencies between published versions.

## npm publish

The  `npm publish` (and more recently `npm adduser`) commands requires some user
interaction to type in user credentials. This makes it problematic for use on
servers since there is no user there to type in the username and password.

Becuase of this limitation some CI servers offers plugins or addons to make the
integration with npm easier for maintainers.

### npm publish for Travis CI

Travis CI can automatically release your npm package to the npm registry after
a successful build. All you need to do is add the following to your
`.travis.yml` configuration:

```yaml
deploy:
  provider: npm
  api_key: "YOUR API KEY"
  on:
    - tags: true
```

* **Also Read:** [npm Releasing - Travis
  CI](http://docs.travis-ci.com/user/deployment/npm/)

### npm publish for Wercker CI

Wercker CI can automatically release your npm package to the npm registry after
a successful build. All you need to do is add the following to your
`wercker.yml` configuration and add the `NPM_TOKEN` environment variable:

```yaml
deploy:
  steps:
    - turistforeningen/npm-publish
```

You also need to add your `NPM_TOKEN` as an Environment Variable to your Deploy
Pipeline in the Wercker settings page for your project.

* **Also checkout:**
  [turistforeningen/wercker-npm-publish](https://github.com/Turistforeningen/wercker-npm-publish)

![Publish to npm](/uploads/2015/09/20/wercker-deploy-target.png)
