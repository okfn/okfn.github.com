---
title: "Labs newsletter: 16 January, 2014"
author: Neil Ashton
user: nmashton
layout: post
---

Welcome back from the holidays! A new year of Labs activities is well underway, with long-discussed improvements to the Labs projects page, many new PyBossa developments, a forthcoming community hangout, and more.

## Labs projects page

[Getting the Labs project page organized better][1] has been high on the agenda for some time now. In the past little while, significant progress has been made. New improvements to the project page include:

* [a custom filter menu][2]
* [individual project lightbox][3]
* [attributes for projects][4]

[Oleg Lavrosky][5], [Daniel Lombraña González][6], and [Andy Lulham][7] have all contributed to this development—and work is still ongoing, with [further enhancements to attributes][8] and [more work on the UI][9] still to come.

## Lots of PyBossa milestones

PyBossa has achieved so many milestones since the last newsletter that it's hard to know where to begin.

PyBossa v0.2.1 was released by [Daniel Lombraña González][10], becoming a more robust service through the inclusion of a new rate-limiting feature for API calls. Alongside rate limits, the new PyBossa has improved security through the addition of a secure cookie-based solution for posting task runs. Full details can be found [in the documentation][11].

Daniel also released [a new PyBossa template][12] for annotating pictures. The template, which incorporates the [Annotorious.JS][13] JavaScript library, "allow\[s] anyone to extract structured information from pictures or photos in a very simple way".

The [Enki][14] package for analyzing PyBossa applications was also released over the break. Enki makes it possible to download completed PyBossa tasks and associated task runs, analyze them with [Pandas][15], and share the result as an [IPython Notebook][16]. Check out Daniel's [blog post][17] on Enki to see what it's about.

## New on the blog

We've had a couple of great new contributions on the [Labs blog][18] since the last newsletter.

[Thomas Levine][19] has written about [how he parses PDF files][20], lovingly exploring a problem that all data wranglers will encounter and gnash their teeth over at least a few times in their lives.

[Stefan Urbanek][21], meanwhile, has written an [introduction to OLAP][22], "an approach to answering multi-dimensional analytical queries swiftly", explaining what that means and why we should take notice.

## Dānabox

Labs friend [Darwin Peltan][23] reached out to the list to point out that his friend's project [Dānabox][24] is looking for testers and general feedback. Labs members are invited to pitch in by finding bugs and breaking it.

Dānabox is "Heroku but with public payment pages", crowdsourcing the payment for an app's hosting costs. Dānabox is [open source][25] and built on the [Deis platform][26].

## Community hangout

It's almost time for the Labs community hangout. The Labs hangout is the regular event where Labs members meet up online to discuss their work, find ways to collaborate, and set the agenda for the weeks to come.

When will the hangout take place? [Rufus][27] proposes [moving the hangout from the 21st to the 23rd][28]. If you want to participate, leave a comment on the thread to let Labs know what time would work for you.

## Get involved

Labs is the Labs community, no more and no less, and you're invited to become a part of it! [Join the community][29] by coding, blogging, kicking around ideas on the [Ideas Page][30], or joining the conversation on the [Labs mailing list][31].

[1]:	https://github.com/okfn/okfn.github.com/issues/46
[2]:	https://github.com/okfn/okfn.github.com/pull/168
[3]:	https://github.com/okfn/okfn.github.com/pull/165
[4]:	https://github.com/okfn/okfn.github.com/pull/159
[5]:	http://okfnlabs.org/members/loleg/
[6]:	http://okfnlabs.org/members/teleyinex/
[7]:	http://okfnlabs.org/members/andylolz/
[8]:	https://github.com/okfn/okfn.github.com/issues/161
[9]:	https://github.com/okfn/okfn.github.com/issues/160
[10]:	http://okfnlabs.org/members/teleyinex/
[11]:	http://docs.pybossa.com/en/latest/api.html#rate-limiting
[12]:	http://daniellombrana.es/taggingpictures.html
[13]:	http://annotorious.github.io/
[14]:	https://github.com/PyBossa/enki
[15]:	http://pandas.pydata.org/
[16]:	http://ipython.org/notebook.html
[17]:	http://daniellombrana.es/blog/2013/12/16/pybossa-enki.html
[18]:	http://okfnlabs.org/blog/
[19]:	http://okfnlabs.org/members/tlevine/
[20]:	http://okfnlabs.org/blog/2013/12/25/parsing-pdfs.html
[21]:	http://okfnlabs.org/members/Stiivi/
[22]:	http://okfnlabs.org/blog/2014/01/10/olap-introduction.html
[23]:	http://okfn.org/members/darwin/
[24]:	http://danabox.io/
[25]:	https://github.com/danabox
[26]:	http://deis.io/
[27]:	http://okfnlabs.org/members/rgrp
[28]:	https://github.com/okfn/okfn.github.com/issues/167
[29]:	http://okfnlabs.org/join/
[30]:	http://okfnlabs.org/ideas/
[31]:	http://lists.okfn.org/mailman/listinfo/okfn-labs