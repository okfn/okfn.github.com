---
layout: post
author: Rufus Pollock
title: Javascript Timeline Libaries - A Review
username: rgrp
---

This post is a rough and ready overview of various javascript timeline libraries that arose from research in creating a timeline view for [Recline JS](http://reclinejs.com/). Note this material hung around on my hard disk for a few months so some of it may already be a little bit out of date!

<div class="alert alert-info">
<strong>October 2013</strong>: We have released <strong><a href="http://timemapper.okfnlabs.org/">TimeMapper</a></strong> a new online app for creating <strong>Timelines and TimeMaps</strong> quickly and easily. Check it out at <strong><a href="http://timemapper.okfnlabs.org/">http://timemapper.okfnlabs.org/</a></strong>
</div>

I want to start with a general comment. Timeline libraries consist of various components:

* Data loading
  * Date parsing
* Band (timeline) rendering
* Showing render info on individual items

For me a timeline visualization library need only be the second of these but most that I've come across do more.

In fact a major issue in my opinion with most libraries is that they are *under-componentized* - they don't separate cleanly into these different components and end up doing everything.

To take one example, the Verite timeline (in my view is one of the best libraries out there) has a whole bunch of its own custom date parsing built in inside an internal utility library which are hard to override or replace and also has a large chunk of code just for loading from google docs and other data sources. (You can of course somewhat solve this somewhat -- as I do in Recline by parsing the dates directly  and then submitting in a standardized form).

In my view, even if library authors do want to include these sorts of things, it would be good to do it in a way that allowed for a clean separation so that you could just use the parts you wanted (and/or over-ride parts more cleanly).

## Propublica Timeline Setter

* <http://propublica.github.com/timeline-setter/>
* HTML + JS
  * But Requires a build step (using ruby)
* Very simple and compact design (nice!)

## Verite Timeline

* <http://timeline.verite.co/>
* Very elegant frontend design
* 2 bands in timeline segment and tight integration of item display 
* Includes much more than Timeline (e.g. sourcing data from google docs etc)
* Mozilla Public License (was GPL)

## Simile Timeline

* http://www.simile-widgets.org/timeline/
* The original open-source JS timeline but less regularly update and maintained today: "As of Spring 2012, Exhibit is the only Simile widget seeing active development." and the timeline control has not been updated since 2009 (see this [stackoverflow question for more](http://stackoverflow.com/questions/4700419/alternative-to-simile-timeline-for-timeline-visualization)

## Chronoline

* <http://stoicloofah.github.com/chronoline.js/>
* Recently developed and updated
* MIT licensed

## Timeglider

* <https://github.com/timeglider/jquery_widget>
* Non-open license (but was MIT licensed [earlier on](https://github.com/timeglider/jquery_widget/tree/345442fa3dc7c66b23c36031a6569693ecf309bd)

## CHAPS Timeline

* <http://almende.github.com/chap-links-library/timeline.html>
* Looks pretty nice though CSS is not quite as elegant (probably fixable!)
* Not clear whether it supports multiple bands

