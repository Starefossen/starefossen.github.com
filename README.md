starefossen.github.io
=====================

### Running locally

Run the website locally over port 3002.

```shell
vagrant up
vagrant ssh
jekyll serve --host 0.0.0.0 --watch --force_polling
```

### New Post

```shell
./_create.sh
```

### Spellchecking

```shell
aspell -x -c _posts/yyy-mm-dd-post-title.md
```

### Push changes

```shell
git push origin master
```

### Jekyll & Liquid

* https://github.com/mojombo/jekyll/tree/master/site
* http://jekyllrb.com/docs/variables/
* http://jekyllrb.com/docs/templates/
* https://github.com/Shopify/liquid/wiki/Liquid-for-Designers

