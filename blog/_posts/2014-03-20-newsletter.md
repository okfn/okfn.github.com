---
layout: post
author: Neil Ashton
title: "Labs newsletter: 20 March, 2014"
username: nmashton
projects: [textus]
---

We're back with a bumper crop of updates in this new edition of the now-monthly Labs newsletter!

## Textus Viewer refactoring

The [TEXTUS Viewer][1] is an HTML + JS application for viewing texts in the format of [TEXTUS][2], Labs's open source platform for collaborating around collections of texts. The viewer has now been [stripped down][3] to its bare essentials, becoming a leaner and more streamlined beast that's easier to integrate into your projects.

Check out [the demo][4] to see the new Viewer in action, and see the [full usage instructions][5] in the repo.

## JSON Table Schema: foreign key support

The [JSON Table Schema][6], Labs's schema for tabular data, has just added an important new feature: support for [foreign keys][7]. This means that the schema now provides a method for linking entries in a table to entries in a separate resource.

This update has been in the works for a long time, as you can see from [the discussion thread on GitHub][8]. Many thanks to everyone who participated in that year-long discussion, including [Jeff Allen][9], [David Miller][10], [Gunnlaugur Thor Briem][11], [Sebastien Ballesteros][12], [James McKinney][13], [Paul Fitzpatrick][14], [Josh Ferguson][15], [Tryggvi Björgvinsson][16], and [Rufus Pollock][17].

## Renaming of Data Explorer

[Data Explorer][18] is Labs's in-browser data cleaning and visualization app—and it's about to get a name change.

For the past four months, [discussion around the new name][19] has been bubbling. As of right now, [Rufus Pollock][20] is proposing to go with the new name *DataDeck*.

What do you think? If you object, now's your chance to jump in the thread and re-open the issue!

## On the blog: SEC EDGAR database

Rufus has been doing some work with the [Securities and Exchange Commission (SEC) EDGAR database][21], "a rich source of data containing regulatory filings from publicly-traded US corporations including their annual and quarterly reports". He has written up his initial findings on the blog and created a [repo][22] for the extracted data.

This is an interesting example of working with XBRL, the popular XML framework for financial reporting. You can find several good Python libraries for working with XBRL in [Rufus's message to the mailing list][23].

## Labs Hangout: today!

Labs Hangouts are a fun and informal way for Labs members and friends to get together, discuss their work, and seek out new contributions—and the next one is happening today (20 March) at 1700-1800 GMT!

If you want to join in, [visit the hangout Etherpad][24] and record your name. The URL of the Hangout will be announced on the Labs mailing list as well as reported on the pad.

## Get involved

Want to join in Labs activities? There's lots to do! Possibilities for contribution include:

* [Google Spreadsheet imports][25] for [data.okfn.org][26]
* [JSON and CSV import][27] for [TimeMapper][28]
* [developer documentation][29] for [Data Pipes][30]

And much much more. Leave an idea on the [Ideas Page][31], or visit the Labs site to learn more about how you can [join the community][32].

[1]:    http://okfnlabs.org/textus-viewer/
[2]:    http://okfnlabs.org/projects/textus/
[3]:    https://github.com/okfn/textus-viewer/issues/5
[4]:    http://okfnlabs.org/textus-viewer/
[5]:    https://github.com/okfn/textus-viewer#usage
[6]:    http://dataprotocols.org/json-table-schema/
[7]:    http://dataprotocols.org/json-table-schema/#foreign-keys
[8]:    https://github.com/dataprotocols/dataprotocols/issues/23
[9]:    http://trestletechnology.net
[10]:   http://deadpansincerity.com
[11]:   https://github.com/gthb
[12]:   http://standardanalytics.io
[13]:   http://opennorth.ca
[14]:   http://robotrebuilt.com/people/paulfitz/
[15]:   https://github.com/besquared
[16]:   https://github.com/tryggvib
[17]:   http://okfnlabs.org/members/rgrp
[18]:   http://okfnlabs.org/projects/data-explorer/
[19]:   https://github.com/okfn/dataexplorer/issues/150
[20]:   http://okfnlabs.org/members/rgrp
[21]:   http://okfnlabs.org/blog/2014/03/04/sec-edgar-database.html
[22]:   https://github.com/datasets/edgar
[23]:   https://lists.okfn.org/pipermail/okfn-labs/2014-March/001337.html
[24]:   http://pad.okfn.org/p/labs-hangouts
[25]:   https://github.com/okfn/data.okfn.org/issues/24
[26]:   http://data.okfn.org
[27]:   https://github.com/okfn/timemapper/issues/107#issuecomment-37631369
[28]:   http://timemapper.okfnlabs.org/
[29]:   https://github.com/okfn/datapipes/issues/107
[30]:   http://datapipes.okfnlabs.org
[31]:   http://okfnlabs.org/ideas/
[32]:   http://okfnlabs.org/join/
