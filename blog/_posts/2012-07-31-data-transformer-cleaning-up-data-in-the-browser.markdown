---
layout: post
title: The Data Transformer - Cleaning Up Data in the Browser
author: Rufus Pollock
username: rgrp
---

This a brief post to announce an alpha prototype version of the Data Transformer, an app to let you clean up data in the browser using javascript:

<http://transformer.datahub.io/>

### 2m overview video:

<iframe width="560" height="315" src="http://www.youtube.com/embed/zM1USNaEcVQ" frameborder="0" allowfullscreen="1" style="margin-bottom: 30px;">&nbsp;</iframe>

### What does this app do?

1. You load a CSV file from github (fixed at the moment but soon to be customizable)
2. You write simple javascript to edit this file (uses ReclineJS transform and grid views + CSV backends -- here's the [original ReclineJS transform demo](http://reclinejs.com/demos/multiview/?currentView=transform))
3. You save this updated file back to github (via oauth login - this utilizes Michael's great work in Prose!)

This prototype was hacked together in an afternoon a couple of weeks ago when I was fortunate enough to spend an an afternoon with Michael Aufreiter, Chris Herwig, Mike Morris and others at the Development Seed offices. It builds on ReclineJS + oauth / github connectors borrowed from Prose.

It's part of an ongoing plan to create a "Data Orchestra" of lightweight data services that can play nicely together with each
other and connect to things like the DataHub (or GitHub ...): <http://notebook.okfn.org/2012/06/22/datahub-small-pieces-loosely-joined/>

