---
layout: post
title: Spaghetti, Notebooks, and Modeling
date: 2016-03-09
tag: [agile, lean coffee]
twitter: starefossen
published: true
facts:
  - title: Lean Coffee
    facts:
      - Lean Coffee is a structured, but agenda-less meeting. Participants
        gather, build an agenda, and begin talking. Conversations are directed
        and productive because the agenda for the meeting was democratically
        generated.
    source: leancoffee.org
  - title: Kanban
    facts:
      - Kanban is another framework used to implement agile. Back in the 1940s,
        Toyota optimized its engineering process by modeling it after how
        supermarkets stock shelves.
      - Kanban does the same for software teams. By matching the amount of work
        in progress to the team's capacity.
    source: atlassian.com
---

[Lean Coffee Bergen]: http://www.meetup.com/Lean-Coffee-Bergen/

Microservices dependency spaghetti, the concept of an engineering notebook, and
the importance of software modeling was three main topics discussed at this
meeting with [Lean Coffee Bergen].

![Lean Coffee Kanban board in action](/uploads/2016/03/09/lean-coffee.jpg)

<!--more-->

## Microservice Spaghetti

The microservice oriented approach is not a new concept in the world of software
engineering, and is more traditionally known as service oriented architecture[^1] -
or SOA for short. Such a services should be unassociated, loosely coupled units
of functionality that are self-contained.

In reality, however, many of the services had in fact hard dependencies such the
ability for inter process communication; programming language and version. Even
though they appeared unassociated there ware in fact tightly coupled with one
another.

A more modern definition of microservices are web services. They implement the
same functionality as their SOA counterpart over standard Internet protocols
independent of platforms and programming languages. This allows services to be
moved around, switched out, rebuilt, and scaled without having to worry about
other their dependents (in theory at last).

## The Engineering Notebook

[JIRA]: https://www.atlassian.com/software/jira/

The concept of an Engineering Notebook is the method of to precisely record all
work, from concept to prototype - preferably in a notebook by hand. Should
software engineers adopt more of this mindset too?

The notebook is always on and it comes with no distracting notifications. You
will be able to have one canonical source of history - instead of sifting
through multiple git repositories or issue trackers. The notebook also has an
infinite amount of different drawings and support for complex notations without
installing any special tool or ad-on.

On the other hand, notebooks are not easily searchable and depending on your
handwriting may not be easily readable after some amount of time. Some attempts
has been made to use digital notebooks (tablets) with handwriting recognition
software with varied amount of success.

A notebook can be quite useful for personal planning. Project management tools
like [JIRA] are often better for information sharing than personal task
management. Simply making a list in your notebook and crossing them out as you
go during the day may be a good solution for keeping track of your day to day
activities.

## Software Modeling

[Gliffy]: https://www.gliffy.com/

Many software engineers have a formal understanding of software modeling through
UML diagrams[^2] from their university education and the formal waterfall
software development process[^3]. But what role does software modeling play in
today's world of agile software development?

With Agile development there is less design up front, however, this is not an
excuse for not making proper models and diagrams of the system(s) in question.
This is a good practice that all engineers must restrain and remember to use.

Diagrams are useful for modeling entities and their relations or dependencies.
Some diagram can be thrown away when the implementation is done, while others
can be kept as reference or documentation for later. Be mindful if the diagram
is one or the other.

If you are using JIRA it might be worth to take a look at [Gliffy] - a digital
tool to create and manage flowcharts, wireframes, UML diagrams directly from
issues and wiki pages.

## Footnotes

[^1]: [Service-oriented architecture](https://en.wikipedia.org/wiki/Service-oriented_architecture)
[^2]: [Unified Modeling Language](https://en.wikipedia.org/wiki/Unified_Modeling_Language)
[^3]: [Waterfall model](https://en.wikipedia.org/wiki/Waterfall_model)
