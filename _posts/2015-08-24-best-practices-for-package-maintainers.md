---
layout: post
title: Best Practices for Package Maintainers
date: 2016-01-01
tag: [open source, maintainer, soft skills]
twitter: starefossen
published: true
---

Maintaining all of the open source Node.js libraries for the Norwegian Trekking
Association throughout almost three years, and a bunch of personal ones, has
been an amazing experience. Here are my 10 best tips to open source maintainers.

<!--more-->

* **Communication**
  * [1. Be Polite](#be-polite)
  * [2. Be Honest](#be-honest)
  * [3. Define the Scope](#define-the-scope)
* **Testing**
  * [4. Include Tests](#include-tests)
  * [5. Set up Continuous Integration](#set-up-continuous-integration)
* **Code**
  * [6. Implement Coding Conventions](#implement-coding-conventions)
  * [7. Use Semantic Visioning](#use-semantic-visioning)
  * [8. Keep a Changelog](#keep-a-changelog)
* **GitHub**
  * [9. Use the README.md](#use-the-readme-md)
  * [10. Add Collaborators](#add-collaborators)

## Communication

### Be Polite

Since there no room for body language on the Internet (except for emojies of
course :wink:), and many users are not nativ English speakers, it is easy to
misinterpret comments and suggestions. Give your users the benefit of the doubt,
treat them with respect, and be polite.

When dealing with support questions; ask yourself «how was the user supposed to
find the answer, or know what to do, in this situation?» More often than not the
answer to this question is lack of, or poorly written, documentation.

### Be Honest

If you don't have time to dig around in obscure stack traces from some random
bug report, or the feature request is clearly out of scope for this particular
project. Instead of ignoring it, hoping it goes away, just be honest and say it
as it is.

If you don't have time, tell them you don't have time to debug this and suggest
some other way the user can get their problems solved. You can even write this
in the README. If you don't want to implement a certain feature, tell them to
submit a PR or fork the project.

### Define the Scope

Unless you will only be supporting *one* package, defining the scope of the
proejct will help to avoid the dreaded «feature creep» which is a major source
of developer burnout. The scope will inform your users what they can expect, and
also what not to expect. Whenever a new issue, or pull request, is opened you
should check the scope and refere to it if necessary.

I am a big believer of «Do one thing well!» where every package does one job and
can be composed together. Rather than jamming every possible functionality into
one gigantic package you should create smaller packages that can be joined
together – much like the well known [Unix
philosophy](https://en.wikipedia.org/wiki/Unix_philosophy):

> The Unix philosophy emphasizes building simple, short, clear, modular, and
> extensible code that can be easily maintained and repurposed by developers
> other than its creators. The Unix philosophy favors composability as opposed
> to monolithic design.

* **Check out:** [The Changelog #159: Sustaining Open Source
Software with Mike Perham](https://changelog.com/159/)

## Testing

### Include Tests

There is no excuse for not having a single test in 2016. You don't need to have
a 100% test coverage, but you should at least have the basic functionality
tested. Preferably you should write your tests while developing, but in case you
didn't do that, go and create some tests right away!

**Format verification** - tests will help you verifying the software is working
as intended. You may often find input that will causes unexpected results, or
even crash the application, while you are writing your tests.

~~~ js
describe('geoutil.pointDistance()', function() {
  it('returns distance in meters', function() {
    var meters = geoutil.pointDistance([60.39826, 5.32907], [60.62869, 6.41474]);
    assert.equal(meters, 64781.55866944858);
  });
});
~~~

**Backwards compatibility** - tests will also help you maintain backwards
comparability with previous versions, and prevent inadvertently introducing
breaking changes without a major version bump. This is not a critique of
breaking changes (I am all for backwards incompatible versions) but they must be
deliberate and well documented!

**Tests as example** - for more experienced users, your tests can serve as an
additional source of code examples. I often find myself exploring the project's
`/test` directory when checking out new open source projects.

### Set up Continuous Integration

This is a topic near and dear to me. I stribe to automate everything possible,
and testing is _the_ prime example of good automation in practice. There are
plenty of good (and free) services that can help you to run your tests in an
automated fashion. Circle CI, Codeship, Drone.io, Jenkins CI, Travis CI, and
Wercker to mention a few.

If your code is up on a public code hosting platform like GitHub, Bitbucket, or
GitLab you should choose a CI server that integrates well with your platform of
choice. This will enable you to run your test suite automaticly when you push
code changes, as well as contributions from other users, automaticly!

![GitHub Pull Request with status checks](/uploads/2015/08/24/status.png)

## Code

### Implement Coding Conventions

Coding conventions, or a _coding style_ / _coding standard_, is a set of rules
and conventions on how to strucure and format the source code for a given
plattform, programming language, or framework.

Keeping the source code consistent accross the entire project will improve the
overall readability (for new and experienced users), and ease the overall
maintenance of the project. Make sure you properly state what coding convention
your project follows to any new users.

Some programming languages, like Python, C#, Go, Java, have an officially
recommended coding convention while others have no _one_ coding standard, like
C/C++, HTML/CSS, JavaScript, PHP, and Shell/Bash. I have attempted to compile a
list of recognized conventions for popular programming languages bellow:

| Language | Coding Convention |
|----------|-------------------|
| C | [C Coding Standard](https://users.ece.cmu.edu/~eno/coding/CCodingStandard.html) |
| C# | [C# Coding Conventions](https://msdn.microsoft.com/en-us/library/ff926074.aspx) |
| C++ | [GCC C++ Coding Conventions](http://gcc.gnu.org/wiki/CppConventions) |
| PHP | [PHP - PEAR Coding Standards](http://pear.php.net/manual/en/standards.php) |
| Python | [PEP 0008](https://www.python.org/dev/peps/pep-0008/) |
| Go | [How to Write Go Code](https://golang.org/doc/code.html) |
| Java | [Java Code Conventions](http://www.oracle.com/technetwork/java/codeconvtoc-136057.html) |
| JavaScript | [Airbnb JavaScript Style Guide() {](https://github.com/airbnb/javascript#readme)<br>[Douglas Crockford's JavaScript Code Conventions](http://javascript.crockford.com/code.html) |
| HTML/CSS | [Code Guide by @mdo (author of Bootstrap)](http://codeguide.co/)<br>[Google HTML/CSS Style Guide](https://google.github.io/styleguide/htmlcssguide.xml) |
{: .table .table-striped}

Another good source of coding conventions and style guides is @google's
[styleguide repository](https://github.com/google/styleguide). As you may know
they operate the world's largest (known) code base, so they must know a thing or
two about best practices for development and maintenance of software projects.

### Use Semantic Visioning

SEMVER.ORG. SEMVER.ORG. SEMVER.ORG. SEMVER.ORG. SEMVER.ORG. SEMVER.ORG.

> In the world of software management there exists a dread place called
> "dependency hell." The bigger your system grows and the more packages you
> integrate into your software, the more likely you are to find yourself, one day,
> in this pit of despair.

### Keep a Changelog

**TODO**

* **Also read:** [Tagging software releases with git and GitHub]()

**TODO**

* **Check out:** [The Changelog #127: Keep a CHANGELOG with Olivier
Lacan](https://changelog.com/127/)

## GitHub

### Use the README.md

This is about documenting you project. You know, that boring task you need to do
after you have written those awesome lines of code! But for the love of God; put
the documentation in the `README.md` file in your repository. No, don't create a
sepeare website, don't put it in some other clever named file. *Just don't!!!*

Keep the documentation simple, easy to read, and do not assume too much of the
reader. Remeber to utilize all the awesome power of [GitHub Flavored
Markdown](https://help.github.com/articles/github-flavored-markdown/) (if your
code is hosted on GitHub).

#### Here is what you need

**Title and Description** - this goes back to a previous point; [Define the
Scope](#define-the-scope). Start by writing a decent title and describe, in one
paragraph, what the project is about.

**Short Example** - write a short example (max 10 lines) where you showcase how
easy it is to get started with your library or how this solve a particular
problem.

**Installation** (and requirements) - how do a new user install the project and
what are the requirments (with versions!).

**Features** -

**API Documentation** -

**Development** (and testing) -

**License**

Examples:

* https://github.com/request/request
* https://github.com/caolan/async
* https://github.com/strongloop/express
* https://github.com/chalk/chalk

### Add Collaborators

Open Source is very much about community and collaboration. You are not alone
and you should not carry all your projects alone. If you want to make sure all
your open source projects are happy you should adopt the [**OPEN open source**
governance model](http://openopensource.org/):

> Individuals making significant and valuable contributions are given
> commit-access to the project to contribute as they see fit.

Whenever a new user proposes a pull request (and it looks decent) you should add
them as collaborators to the project. Those who care enough to submit a PR are
generally good people in my experience!

The sense of *ownership* and *responsibility* by becoming a **collaborator**
makes them step up. Suddenly they start contribute like never before; answering
support issues, enahancing the documentation, and fixing those tiny bugs you
said you would fix a year ago.
