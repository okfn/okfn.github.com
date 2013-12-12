---
title: "Labs newsletter: 12 December, 2013"
author: Neil Ashton
user: nmashton
layout: post
---

We're back after taking a break last week with a bumper crop of updates. A few things have changed: Labs activities are now coordinated entirely through GitHub. Meanwhile, there's been some updates around the [Nomenklatura][1], [Annotator][2], and [Data Protocols][3] projects and some new posts on the [Labs blog][4].

## Migration from Trello to GitHub

For some time now, Labs activities requiring coordination have been organized on [Trello][5]—but those days are now over. Labs has moved its organizational setup over to [GitHub][6], coordinating actions and making plans by means of GitHub issues. This change comes as a big relief to the many Labs members who already use GitHub as their main platform for collaboration.

General Labs-related activities are now tracked on the [Labs site's issues][7], and activities around individual projects are managed (as before!) through those projects' own issues.

## New Bad Data

New examples of [bad data][8] continue to roll in—and we invite even more [new submissions][9].

Bad datasets added since last newsletter include the [UK's Greater London Authority spend data][10] (65+ files with 25+ different structures!), [Nature Magazine's supplementary data][11] (an awful PDF jumble), and more.

## Nomenklatura: new alpha

As we've previously noted, Labs member [Friedrich Lindenberg][12] has been thinking about producing "a fairly radical re-framing" of the [Nomenklatura][13] data reconciliation service.

Friedrich has now released an alpha version of a new release of Nomenklatura at [nk-dev.pudo.org][14]. The major changes with this alpha include:

* A fully JavaScript-driven frontend
* String matching now happens inside the PostgreSQL database
* Better introductory text explaining what Nomenklatura does
* "entity" and "alias" domain objects have been merged into "entity"

Friedrich is keen to hear what people think about this prototype—so jump in, give it a try, and leave your comments at the [Nomenklatura repo][15].

## Annotator v1.2.9

A new maintenance release of [Annotator][16] came out ten days ago. This new version is intended to be one of the last in the v1.2.x  series—indeed, v1.2.8 itself was intended to be the last, but that version had some significant issues that this new release corrects.

Fixes in this version include:

* Fixed a major packaging error in v1.2.8. Annotator no longer exports an excessive number of tokens to the page namespace.
* Notification display bugfixes. Notification levels are now correctly removed after notifications are hidden.

The new Annotator is available, as always, [from GitHub][17].

## Data Protocols updates

[Data Protocols][18] is a project to develop simple protocols and formats for working with open data. [Rufus Pollock][19] wrote a [cross-post to the list][20] about several new developments with Data Protocols of interest to Labs. These included:

* Close to final agreement on a spec for adding "primary keys" to the [JSON Table Schema][21] ([discussion][22])
* Close to consensus on spec for "foreign keys" ([discussion][23])
* Proposal for a JSON spec for views of data, e.g. graphs or maps ([discussion][24])

For more, check out [Rufus's message][25] and the [Data Protocols issues][26].

## On the blog

Labs members have added a couple new posts to the blog since the last newsletter. Yours truly (with extensive help from Rufus) posted on [using Data Pipes to view a CSV][27]. [Michael Bauer][28], meanwhile, wrote about the new [Reconcile-CSV service][29] he developed while working on education data in Tanzania. Look to the [Labs blog][30] for the full scoop.

## Get involved

If you have some spare time this holiday season, why not spend it helping out with Labs? We're always always looking for new people to [join the community][31]—visit the [Labs issues][32] and the [Ideas Page][33] to get some ideas for how you can join in.

[1]:	nomenklatura.okfnlabs.org
[2]:	http://okfnlabs.org/annotator/
[3]:	http://www.dataprotocols.org
[4]:	http://okfnlabs.org/blog/
[5]:	trello.com
[6]:	http://github.com
[7]:	https://github.com/okfn/okfn.github.com/issues/
[8]:	http://okfnlabs.org/bad-data/
[9]:	http://okfnlabs.org/bad-data/add/
[10]:	http://okfnlabs.org/bad-data/ex/gla-spending/
[11]:	http://okfnlabs.org/bad-data/ex/nature-magazine-supplementary/
[12]:	http://pudo.org/
[13]:	http://nomenklatura.okfnlabs.org/
[14]:	http://nk-dev.pudo.org/
[15]:	https://github.com/pudo/nomenklatura
[16]:	http://okfnlabs.org/annotator/
[17]:	https://github.com/okfn/annotator/releases/tag/v1.2.9
[18]:	http://dataprotocols.org/
[19]:	http://okfnlabs.org/members/rgrp/
[20]:	https://lists.okfn.org/pipermail/okfn-labs/2013-December/001185.html
[21]:	http://dataprotocols.org/json-table-schema/
[22]:	https://github.com/dataprotocols/dataprotocols/issues/21
[23]:	https://github.com/dataprotocols/dataprotocols/issues/23
[24]:	https://github.com/dataprotocols/dataprotocols/issues/77
[25]:	https://lists.okfn.org/pipermail/okfn-labs/2013-December/001185.html
[26]:	https://github.com/dataprotocols/dataprotocols/issues
[27]:	http://okfnlabs.org/blog/2013/12/05/view-csv-with-data-pipes.html
[28]:	http://okfnlabs.org/members/mihi
[29]:	http://okfnlabs.org/blog/2013/12/06/Introducing-Reconcile-csv.html
[30]:	http://okfnlabs.org/blog/
[31]:	http://okfnlabs.org/join/
[32]:	https://github.com/okfn/okfn.github.com/issues/
[33]:	http://okfnlabs.org/ideas/