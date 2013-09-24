---
layout: post
author: Michael Bauer
title: Full stack datavis - scraperwiki, d3 and github.
username: mihi
---


The city of Vienna started releasing waiting times for some of its service
offices recently. I followed my usual hunch and just wrote a [small script
on scraperwiki](https://scraperwiki.com/dataset/guvh44q) that stows away
the JSON released by the city not knowing yet what to do with it.

Weeks later [Hacks/Hackers Vienna](http://hackshackers.at) decided to host
a hackathon. I couldn't make it (I thought I might) but had the idea to
develop the data into a visualization. I sat down later that week and
published a [visualization of waiting times](http://wannaufsamt.tentacleriot.eu). 

![Wann aufs amt?](http://wannaufsamt.tentacleriot.eu/waa.png)

### So why am I rambling on about this?

I realized a couple of things while doing this:

One or two years back,
facing a problem like this I would have: made space on a server, write an
extensive scraper in python, set up a database to store stuff, write a
backend web-application to generate graphics and spit them out.

Today: I have my scraper and backend run as a service by
[scraperwiki](http://scraperwiki.com), use [d3](http://d3js.org) to
generate graphics on the client (much better looking ones) and host the
whole thing for free on [github](http://github.com) - because I don't need
a backend anymore.

This is made possible by:

* More and more things offered as a service (often for free)
* Amazing frameworks in modern languages, that make development easier
* Fantastic resources to exchange knowledge

Developing a small data-driven application used to be a lot of work - not
anymore. While it takes a while to get used to the intricate ways of some
frameworks ([d3](http://d3js.org) has a quite unique way of doing things):
once you're over the hump, things get a lot easier. This leaves you in the
end thinking about the visualization or application you're building: not
worrying about server security, costs and setup.

This also means: Full stack datavisualization has become easier. You needed
a team of specialists (sysadmins, backend-developers, designers) to do a
decent dataviz: now you just learn the missing parts and you're able to
pull it off. 
