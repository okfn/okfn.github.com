---
title: Hangouts - Events
layout: events
---

# Hangouts

We run regular online hangouts where we get together to discuss and build.

## 20th March 2014

The hangout is an opportunity for folks to present projects and ideas and also to discuss any general Labs items such as improvements to website, events etc.

It’s super informal and anyone can come along and contribute. If you’d like specifically to present something please jump into [the etherpad][etherpad] and add it to the agenda (slots are max 5m).

* When: Thursday 20th March 2014. 1700-1800 GMT (1300-1400 EDT, 1800-1900 CET) [time zone schedule](http://www.worldtimebuddy.com/?qm=1&lid=3117735,2643743,5128581,100&h=3117735&date=2014-3-20&sln=18-19)
* Where: Google Hangout - we’ll announce link on the day on the [list and IRC (#okfn)][contact]
* Sign up: (optional but recommended) add your name to [the etherpad][etherpad]


## 20th February 2014

The hangout is an opportunity for folks to present projects and ideas and also to discuss any general Labs items such as improvements to website, events etc.

It’s super informal and anyone can come along and contribute. If you’d like specifically to present something please jump into [the etherpad][etherpad] and add it to the agenda (slots are max 5m).

* When: Thursday 20th February 2014. 1700-1800 GMT (1200-1300 EST, 1800-1900 CET) 
* Where: Google Hangout - we’ll announce link on the day on the [list and IRC (#okfn)][contact]
* Sign up: (optional but recommended) add your name to [the etherpad][etherpad]

## 23rd January 2013

The hangout is an opportunity for folks to present projects and ideas and also to discuss any general Labs items such as improvements to website, events etc.

It’s super informal and anyone can come along and contribute. If you’d like specifically to present something please jump into [the etherpad][etherpad] and add it to the agenda (slots are max 5m).

* When: Thursday 23rd January. 1700-1800 GMT (1200-1300 EST, 1800-1900 CET) 
* Where: Google Hangout - we’ll announce link on the day on the [list and IRC (#okfn)][contact]
* Sign up: (optional but recommended) add your name to [the etherpad][etherpad]

## 19th November 2013

The hangout is an opportunity for folks to present projects and ideas and also to discuss any general Labs items such as improvements to website, events etc.

It’s super informal and anyone can come along and contribute. If you’d like specifically to present something please jump into [the etherpad][etherpad] and add it to the agenda (slots are max 5m).

* When: Tuesday 19th November. 1700-1800 GMT (1200-1300 EST, 1800-1900 CET) 
* Where: Google Hangout - we’ll announce link on the day on the [list and IRC (#okfn)][contact]
* Sign up: (optional but recommended) add your name to [the etherpad][etherpad]

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
