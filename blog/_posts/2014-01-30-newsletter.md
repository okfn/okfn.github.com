---
title: "Labs newsletter: 30 January, 2014"
author: Neil Ashton
user: nmashton
layout: post
---

From now on, the Labs newsletter will arrive through a special announce-only mailing list, *newsletter@okfnlabs.org*, more details on which can be found below.

Keep reading for other new developments including the fifth Labs Hangout, the launch of SayIt, and new developments in the vision of "Frictionless Data".

## New newsletter format

Not everyone who wants to know about Labs activities wants or needs to observe those activities unfolding on the main Labs list. For friends of Labs who just want occasional updates, we've created a new, [Sendy][1]-based announce-only list that will bring you a Labs newsletter every two weeks.

Everyone currently subscribed to *okfn-labs@lists.okfn.org* has been added to the new list. To join the new announce list, see the [Labs Contact page](http://okfnlabs.org/contact/), where there's a form.

## Labs Hangout no. 5

Last Thursday, [Andy Lulham][2] hosted the fifth OKFN Labs Hangout. The Labs Hangouts are a way for people curious about Labs projects to informally get together, share their work, and talk about the future of Labs.

For full details, check out the [minutes from the hangout][3]. Highlights included:

* SayIt, a new publication platform for speeches & transcripts, introduced by [Tom Steinberg][4] of [mySociety][5] (see below for more!)
* announcement of an [Open Literature Sprint][6] this past Saturday
* full coverage of PyBossa source code with [unit tests][7]
* [Tom Morris][8]'s work parsing and importing e-publications from [Open Library][9]
* updates to [Frictionless Data][10] (see below)

## SayIt

[SayIt][11], an open-source tool for publishing and sharing transcripts, has just been launched by [Poplus][12]. At last week's Labs Hangout, [Tom Steinberg][13] of [mySociety][14] (one half of Poplus, alongside [Ciudadano Inteligente][15]) shared some of the motivations behind the creation of the tool, which was also discussed [on the okfn-discuss mailing list][16].

As Tom explained, mySociety's [They Work For You][17] has proven the popularity of transcript data. But making the transcripts available in a nice way (e.g. with a decent API) has so far called for bespoke software development. SayIt is designed to encourage "nice" publication as the starting-point—and to serve as a pedagogical example of what a good data publication tool looks like.

## Frictionless data: vision, roadmap, composability

We've heard about [Rufus][18]'s vision for an ecosystem of "frictionless data" in the past. Now the discussion is starting to get serious. [data.okfn.org][19] now hosts two key documents generated through the conversation:

* [the vision][20]: what will create a dynamic, productive, and attractive open data ecosystem?
* [the roadmap][21]: what has to happen to bring this vision to life?

The new roadmap is a particularly lucid overview of how the frictionless data vision connects with concrete actions. Would-be creators of this new ecosystem should consult the roadmap to see where to join in.

[Discussion on the Labs list][22] has also generated some interesting insights. [Data Unity][23]'s Kev Kirkland discussed his work with Semantic Web formalization of composable data manipulation processes, and [Štefan Urbánek][24] made a connection with his work on "abstracting datasets and operations" in the ETL framework [Bubbles][25].

## On the blog: OLAP part two

Last week, [Štefan Urbánek][26] wrote us an [introduction to Online Analytical Processing][27]. Shortly afterwards, he followed up with a second post taking a closer look at [how OLAP data is structured and why][28].

Check out Štefan's post to learn about how OLAP represents data as multidimensional "cubes" that users can slice and dice to explore the data along its many dimensions.

## TimeMapper improvements

[Andy Lulham][29] has started working on [TimeMapper][30], Labs's easy-to-use tool for the creation of interactive timelines linked to geomaps.

Some of the improvements he has made so far have been bugfixes (e.g. [preventing overflowing form controls][31], [fixing the template settings file][32]), but one of them is a new user feature: adding a way to [change the starting event][33] on a timeline so that they don't always have to start at the beginning.

## Get involved

Want to get involved with Labs's projects? Now is a great time to join in! Check out the [Ideas Page][34] to see some of the many things you can do once you [join Labs][35], or just jump on the [Labs mailing list][36] and take part in a conversation.

[1]:	http://sendy.co/
[2]:	http://okfnlabs.org/members/andylolz
[3]:	http://pad.okfn.org/p/labs-hangouts
[4]:	http://twitter.com/steiny
[5]:	http://t.co/KKNpVhbitu
[6]:	http://humanities.okfn.org/open-literature-sprint-jan-2014/
[7]:	https://coveralls.io/r/PyBossa/pybossa
[8]:	http://twitter.com/tfmorris
[9]:	http://openlibrary.org
[10]:	http://data.okfn.org/vision
[11]:	http://sayit.mysociety.org/
[12]:	http://poplus.org/
[13]:	http://twitter.com/steiny
[14]:	http://t.co/KKNpVhbitu
[15]:	http://www.ciudadanointeligente.org/?lang=en
[16]:	https://lists.okfn.org/pipermail/okfn-discuss/2014-January/010083.html
[17]:	http://www.theyworkforyou.com/
[18]:	http://okfnlabs.org/members/rgrp
[19]:	http://data.okfn.org/
[20]:	http://data.okfn.org/vision
[21]:	http://data.okfn.org/roadmap
[22]:	https://lists.okfn.org/pipermail/okfn-labs/2014-January/001260.html
[23]:	http://t.co/pL0Yy7uNuf
[24]:	http://okfnlabs.org/members/Stiivi/
[25]:	https://github.com/Stiivi/bubbles
[26]:	http://okfnlabs.org/members/Stiivi/
[27]:	http://okfnlabs.org/blog/2014/01/10/olap-introduction.html
[28]:	http://okfnlabs.org/blog/2014/01/20/olap-cubes-and-logical-model.html
[29]:	http://okfnlabs.org/members/andylolz
[30]:	http://timemapper.okfnlabs.org
[31]:	https://github.com/okfn/timemapper/pull/119
[32]:	https://github.com/okfn/timemapper/pull/118
[33]:	timemapper.okfnlabs.org
[34]:	http://okfnlabs.org/ideas/
[35]:	http://okfnlabs.org/join/
[36]:	http://lists.okfn.org/mailman/listinfo/okfn-labs