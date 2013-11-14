---
title: "Labs newsletter: 14 November, 2013"
author: Neil Ashton
username: nmashton
layout: post
---

Labs was bristling with discussion and creation this week, with major improvements to two projects, interesting conversations around a few others, and an awesome new blog post.

## Data Pipes: lots of improvements

[Data Pipes][1] is a Labs project that provides a web API for a set of simple data-transforming operations that can be chained together in the style of Unix pipes.

This past week, [Andy Lulham][2] has made a *huge* number of improvements to Data Pipes. Just a few of the new features and fixes:

* new operations: `strip` (removes empty rows), `tail` (truncate dataset to its last rows)
* new features: a `range` function and a "complement" switch for `cut`; options for `grep`
* all operations in pipeline are now trimmed for whitespace
* basic tests have been added

Have a look at the [closed issues][3] to see more of what Andy has been up to.

## Webshot: new homepage and feature

Last week we introduced you to [Webshot][4], a web API for screenshots of web pages.

Back then, Webshot's home page was just a screenshot of GitHub. Now Webshot has a [proper home page][5] with a form interface to the API.

Webshot has also added support for *full page* screenshots. Now you can capture the whole page rather than just its visible portion.

## On the blog: natural language processing with Python

Labs member [Tarek Amr][6] has contributed an awesome post on [Python natural language processing][7] with the NLTK toolkit to the Labs blog.

"The beauty of NLP," Tarek says, "is that it enables computers to extract knowledge from unstructured data inside textual documents." Read his post to learn how to do text normalization, frequency analysis, and text classification with Python.

## Data Packages workflow à la Node

Wouldn't it be nice to be able to initialize new [Data Packages][8] as easily as you can initialize a Node module with  `npm init`?

[Max Ogden][9] started a [discussion thread][10] around this enticing idea, eventually leading to [Rufus Pollock][11] booting a new repo for [dpm][12], the Data Package Manager. Check out [dpm's Issues][13] to see what needs to happen next with this project.

## Nomenklatura: looking forward

[Nomenklatura][14] is a Labs project that does data reconciliation, making it possible "to maintain a canonical list of entities such as persons, companies or event streets and to match messy input, such as their names, against that canonical list".

[Friedrich Lindenberg][15] has noted on the Labs mailing list that [Nomenklatura has some serious problems][16], and he has proposed "a fairly radical re-framing of the service".

The conversation around what this re-framing should look like is still underway—check out [the discussion thread][17] and jump in with your ideas.

## Data Issues: following issues

Last week, the idea of [Data Issues][18] was floated: using GitHub Issues to track problems with public datasets. The idea has generated a few comments, and we'd love to hear more.

Discussion on the Labs list highlighted another benefit of using GitHub. [Alioune Dia][19] suggested that Data Issues should let users register to be notified when a particular issue is fixed. But [Chris Mear][20] pointed out that GitHub already makes this possible: "Any GitHub user can 'follow' a specific issue by using the notification button at the bottom of the issue page."

## Get involved

Anyone can join the Labs community and get involved! Read more about how you can [join the community][21] and participate by coding, wrangling data, or doing outreach and engagement. Also check out the [Ideas Page][22] to see what's cooking in the Labs.

[1]:	http://datapipes.okfnlabs.org/
[2]:	http://okfnlabs.org/members/andylolz
[3]:	https://github.com/okfn/datapipes/issues?page=1&state=closed
[4]:	http://webshot.okfnlabs.org/
[5]:	http://webshot.okfnlabs.org/
[6]:	http://okfnlabs.org/members/tamr/
[7]:	http://okfnlabs.org/blog/2013/11/11/python-nlp.html
[8]:	http://data.okfn.org/standards/data-package
[9]:	http://www.maxogden.com
[10]:	https://github.com/okfn/datapackage.js/issues/3
[11]:	http://okfnlabs.org/members/rgrp
[12]:	https://github.com/okfn/dpm
[13]:	https://github.com/okfn/dpm/issues
[14]:	http://nomenklatura.okfnlabs.org/
[15]:	http://okfnlabs.org/members/pudo
[16]:	http://lists.okfn.org/pipermail/okfn-labs/2013-November/001138.html
[17]:	http://lists.okfn.org/pipermail/okfn-labs/2013-November/001138.html
[18]:	http://okfnlabs.org/blog/2013/11/06/tracking-data-issues.html
[19]:	https://github.com/aliounedia
[20]:	http://feedmechocolate.com/
[21]:	http://okfnlabs.org/join/
[22]:	http://okfnlabs.org/ideas/
