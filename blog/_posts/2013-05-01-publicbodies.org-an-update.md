---
layout: post
author: Rufus Pollock
title: Update on PublicBodies.org - a URL for every part of Government
username: rgrp
---

This is an update on [PublicBodies.org][pb] - a Labs project whose aim is to provide a "URL for every part of Government": <http://publicbodies.org/>

PublicBodies.org is a database and website of "Public Bodies" &ndash; that is Government-run or controlled organizations (which may or may not have distinct corporate existence). Examples would include government ministries or departments, state-run organizations such as libraries, police and fire departments and more.

<a href="http://publicbodies.org/"><img src="http://i.imgur.com/2AbIjSu.png" alt="" style="margin-top: 15px; margin-bottom: 15px;" /></a>

We run into public bodies all the time in projects like OpenSpending (either as spenders or recipients). Back in 2011 as part of the "Organizations" data workshop at OGD Camp 2011, Labs member Friedrich Lindenberg scraped together a first database and site of "public bodies" from various sources (primarily FoI sites like WhatDoTheyKnow, FragDenStaat and AskTheEU).

We've recently redone the site converting the sqlite DB to simple flat CSV files:

- Main github repo: <https://github.com/okfn/publicbodies>
- Example raw CSV: <https://raw.github.com/okfn/publicbodies/master/data/gb.csv>

The site itself is now super-simple flat-files hosted on s3 ([build code here][site-code]). Here's an example of the output:

- European Parliament: <http://publicbodies.org/eu/european-parliament.html>
- Associated JSON API (with CORS!) <http://publicbodies.org/eu/european-parliament.json>

The simplicity of CSV for data plus simple templating to flat-files is very attractive. There are some drawbacks such as changes to primary template resulting in a full rebuild and upload of ~6k files so, especially as the data grows, we may want to look into something a bit nicer but for the time being this works well. 

[pb]: http://publicbodies.org/
[site-code]: https://github.com/okfn/publicbodies/tree/master/site

## Next Steps

There's plenty that could be improved e.g.

* More data - other jurisdictions (we only cover EU, UK and Germany) + descriptions for the bodies (this could be a nice crowdcrafting app)
* Search and Reconciliation (via nomenklatura)
* Making it easier to submit corrections or additions

The full list of issues is on github here: <https://github.com/okfn/publicbodies/issues>

Help is most definitely wanted! Just grab one of the issues or [get in touch](http://okfnlabs.org/contact/) ...

