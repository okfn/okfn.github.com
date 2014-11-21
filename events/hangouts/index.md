---
title: Hangouts - Events
layout: events
---

# Hangouts

We run regular online hangouts where we get together to discuss and build.

## Next labs hangout: 15th May 2014

The hangout is an opportunity for folks to present projects and ideas and also to discuss any general Labs items such as improvements to website, events etc.

It’s super informal and anyone can come along and contribute. If you’d like specifically to present something please jump into [the etherpad][etherpad] and add it to the agenda (slots are max 5m).

* When: Thursday 15th May 2014. 1700-1800 BST (1200-1300 EDT, 1800-1900 CEST) [time zone schedule](http://www.worldtimebuddy.com/?qm=1&lid=3117735,2643743,5128581,100&h=3117735&date=2014-5-15&sln=18-19)
* Where: Google Hangout - we’ll announce link on the day on the [list and IRC (#okfn)][contact]
* Sign up: (optional but recommended) add your name to [the etherpad][etherpad]

# Past labs hangouts

 * 20th March 2014
 * 20th February 2014
 * 23rd January 2013
 * 19th November 2013

[contact]: /contact/
[etherpad]: http://pad.okfn.org/p/labs-hangouts

## Humanities Hangout

The Humanities Hangout is for people interested in tapping in to the increasing amount of **open cultural data and content** to create **apps and insights**.

<ul>
{% for post in site.categories.blog %}
{% if post.event == 'hangout' %}
  <li>{{post.eventdate}} &ndash; <a href="{{post.url}}">{{post.title}}</a></li>
{% endif %}
{% endfor %}
</ul>
