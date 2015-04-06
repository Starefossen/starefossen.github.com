---
layout: post
title: "git: tagging releases"
date: 2015-04-06
tag: [git,flow]
twitter: starefossen
published: true
---

I assume you are using git for your source control management, but are you
tagging your versions? And are you tagging them *correctly*?! A part of being a
good open source maintainer is keeping your git history in good shape.

![git history with properly tagged releases](/uploads/2015/04/06/history.png)

### What are git tags?

A `tag` is a special point in your git history. A tag does not necessary have to
indicate a release, but for the sake of this blog post lets say it is, it makes
things a bit easier. You can list all your tags in your git repo using the `git
tag` command with no options.

To create a new tag you simply run `git tag -a v2.0.1 -m 'v2.0.1'` which will
create a new tag with the name of `v2.0.1`. Remember to add the `--tags` flag in
order to push your newly created tag to your repository.

### Why should I tag?

Tagging makes it super easy to jump back in time to a specific release of your
code without digging around and looking for something which indicates a release.
Simply checkout the tag to a new branch by `git checkout -b version2 v2.0.1` to
get on with it.

Secondly, if you are using GitHub your tags will automatically show up as
`releases` which your users can download, and you can annotate by adding extra
information to in [GitHub Flavored
Markdown](https://help.github.com/articles/github-flavored-markdown/).

![](/uploads/2015/04/06/releases.png)

### Automate all the things!

Tagging your releases may become tedious work after the first couple of times.
It is time to automate the process of bumping all the version numbers,
committing the changed files, and tagging the new release to git.

The following `release.sh` script will update your `package.json` project file
with the new version and tag the release. Run it with `./release x.y.z`.

<script src="https://gist.github.com/Starefossen/4c272ff5fe214fa0b45f.js"></script>

### Semantic visioning

And for the love of God, use [semantic versioning](http://semver.org)!

