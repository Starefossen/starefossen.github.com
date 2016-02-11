---
layout: post
title: Jekyll 3 and GitHub Pages
date: 2016-02-11
tag: [github, jekyll]
twitter: starefossen
published: true
---

Jekyll, the static site generator used by GitHub Pages, recently released their
third major version 💯 🌟 and GitHub Pages just announced their support. Here is a
list of all the new cool stuff and what _you_ need to change!

![Jekyll Static Site Generator](/uploads/2016/02/11/jekyll.png)

<!--more-->

## What is a static site generator?

[Jekyll]: http://jekyllrb.com/
[Jekyll Collections]: http://jekyllrb.com/docs/collections/

[Jekyll] is one of many static site generators perfect for making for personal,
project, or organization sites. Think of it like a file-based CMS, but without
all the complexity. A static site generator takes your content, often written in
some sort of Markdown flavor, and out comes a complete, static website ready to
be served by Apache, Nginx or another web server.

Because the output it is just bunch of static files it does not require any
database, it can be cached and served extremely efficient over HTTP. Jekyll is
the engine behind GitHub Pages, which you can use to host sites right from your
GitHub repositories for free.

## What is new in Jekyll 3.0?

[Pygments]: http://pygments.org/
[Rouge]: http://rouge.jneen.net/
[Liquid]: https://github.com/Shopify/liquid
[Liquid Filters]: https://github.com/Shopify/liquid/wiki/Liquid-for-Designers#standard-filters

Many of the important changes in Jekyll 3.0 are under the hood. The two most
prominent new features are related to performance and profiling.

The `--incremental` regeneration of changes makes local builds significantly
faster. This is especially important for large sites, and you will be able to
preview changes instantly.

The `--profile` option tells Jekyll to analyze your site's build time. This
enables you to find exactly the spots where you can speed things up if compile
time is an issue.

```
> jekyll build --profile
```

| Filename              | Count |   Bytes |  Time |
|:----------------------|:-----:|--------:|------:|
| feed.xml              |     1 |  58.48K | 0.200 |
| _layouts/default.html |    12 | 120.54K | 0.088 |
| sitemap.xml           |     1 |   3.06K | 0.054 |
| _includes/side.html   |    12 |  11.59K | 0.007 |
| _layouts/post.html    |     9 |  53.38K | 0.006 |
| _includes/head.html   |    12 |  18.30K | 0.003 |
| index.html            |     1 |   9.02K | 0.003 |
| _includes/header.html |    12 |   1.05K | 0.002 |
| timeline.html         |     1 |   6.42K | 0.001 |
| _includes/footer.html |    12 |  10.09K | 0.001 |
{: .table .table-striped .table-bordered .table-hover rules="groups"}

The default highlighter has been changed from [Pygments] to [Rouge] - a
pure-ruby code highlighter that is compatible with Pygments. The change should
be seamless for most users of Jekyll and GitHub Pages.

The {% raw %}`{{ site.collections }}`{% endraw %} is now array of collections
and {% raw %}`{{ site.posts }}`{% endraw %} is now a part of all the collections
and not a special array. Read more about [Jekyll Collections].

### New Filters

Also new is [Liquid] 3.0. Liquid is the templating engine which makes all the
`{% raw %}{{ }}{% endraw %}` and `{% raw %}{% %}{% endraw %}` magic work. As
with Jekyll, many of the changes in Liquid 3.0 are under the hood, but this
release also includes some new [Liquid Filters].

{% raw %}
| Filter     | Example                              | Output                   |
|------------|--------------------------------------|--------------------------|
| uniq       | `{{ [1,1,3,2,3,1,4,3,2,1] | uniq }}` | [1,3,2,4]                |
| url_encode | `{{ "Jackô & Jones" | url_encode }}` | Jack%C3%B4%20%26%20Jones |
| strip      | `{{ "\tab c  \n \t" | strip }}`      | ab c                     |
| default    | `{{ first_name | default: 'User' }}` | User                     |
{: .table .table-striped .table-bordered .table-hover rules="groups"}
{% endraw %}

## What is new in GitHub Pages?

[Kramdown]: http://kramdown.gettalong.org/
[Rediscount]: https://github.com/davidfstr/rdiscount
[Redcarpet]: https://github.com/vmg/redcarpet

As you might have guessed, GitHub Pages now uses Jekyll 3[^1] with all of the
new stuff mentioned above. However, there are some other changes as well, and
the most important is the change of Markdown parsing engine to [Kramdown]. If
you are using [Rediscount] or [Redcarpet] for rendering your Markdown (like I
did) you should read on!

![Jekyll Site Generating](/uploads/2016/02/11/incremental.png)

When working with the new changes locally I immediately ran into problems. First
of all there were some minor inconsistencies in how Jekyll was rendering
Markdown. Fenced code blocks using three or more backticks did not evaluate to
syntax highlighted code. This was solved by setting `input: GFM`[^2].

Setting this suddenly all my articles had very strange line breaks, after some
googling around I found a post on StackOverflow which suggested setting
`hard_wrap: false` which solved the line break problem[^3].

Still, syntax highlighting was not working correctly and after even more
googling I found a blog post which explained how to get Jekyll working with
Rouge syntax highlighter by explicitly setting `syntax_highlighter: rouge`[^4].

Your final `_config.yml` should include the following:

``` Yaml
markdown: kramdown
highlighter: rouge

kramdown:
    input: GFM
    hard_wrap: false
    syntax_highlighter: rouge
```

## Running Locally

[GitHub Pages Docker Image]: https://hub.docker.com/r/starefossen/github-pages/

The easiest way to run your Jekyll site locally is to use the [GitHub Pages
Docker Image] .

``` command
> docker pull starefossen/github-pages
> docker run -v "$PWD":/usr/src/app -p "4000:4000" starefossen/github-pages
```

## Footnotes

[^1]: [GitHub Pages now faster and simpler with Jekyll 3.0](https://github.com/blog/2100-github-pages-now-faster-and-simpler-with-jekyll-3-0)
[^2]: [Github Flavored Markdown Parser](http://kramdown.gettalong.org/parser/gfm.html)
[^3]: [Jekyll converting every newline as line break](http://stackoverflow.com/questions/25418399/jekyll-converting-every-newline-as-line-break)
[^4]: [Syntax Highlighting in Jekyll With Rouge](https://sacha.me/articles/jekyll-rouge/)
[^5]: [Kramdown Markdown Syntax Quick Reference](http://kramdown.gettalong.org/quickref.html)
[^6]: [Jonas Kersulis on «Upgrading to Jekyll 3.0»](https://kersulis.github.io/2015/10/31/jekyll-3)
