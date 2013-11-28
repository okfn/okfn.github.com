---
title: "Labs newsletter: 28 November, 2013"
author: Neil Ashton
user: nmashton
layout: post
---

Another busy week at the Labs! We've had lots of discussion around the idea of "bad data", a blog post about Mark's aid tracker, new PyBossa developments, and a call for help with a couple of projects. Next week we can look forward to another [Open Data Maker Night][1] in London.

## Bad Data

Last Friday, Rufus announced [Bad Data][2], a new educational mini-project that highlights real-world examples of how data *shouldn't* be published.

This announcement was greeted with glee and with contributions of new examples. Open government activist [Ivan Begtin][3] chimed in with the Russian Ministry of the Interior's [list of regional offices][4] and the Russian government's [tax rates for municipalities][5]. Labs member [Friedrich Lindenberg][6] added the [German finance ministry][7]'s new open data initiative. As [Andy Lulham][8] said, "bad data" will be very useful for testing the new [Data Pipes][9] operators.

You can follow the whole discussion thread [in the list archive][10].

## Blog post: Looking at aid in the Philippines

At last week's hangout, you heard about [Mark Brough][11]'s new project, a [browser for aid projects in the Philippines][12] generated from [IATI data][13].

Now you can read more about Mark's project [on the blog][14], learning about where the data comes from, how the site is generated from the data (interestingly, it uses the Python-based static site generator [Frozen-Flask][15]), and what Mark plans to do next.

## New PyBossa cache system

Labs member and citizen science expert [Daniel Lombraña González][16] has been "working really hard to add a new cache system to [PyBossa][17]", the open source crowdsourcing platform.

As Daniel has discovered, the [Redis][18] key-value store meets all his requirements for a load-balanced, high-availability, persistent cache. As he put it: "Redis is *amazing*. Let me repeat it: amazing."

Read the [blog post][19] to learn more about the new Redis-based PyBossa setup and its benefits.

## Contributions needed: iOS and Python development

Philippe Plagnol of [Product Open Data][20] needs a few good developers to help with some projects.

Firstly, the [Product Open Data Android app][21] has been out for a while ([source code][22]), and it's high time there was a port for Apple devices. If you're interested in contributing to the port, leave a comment at [this GitHub issue][23].

Secondly, work is now underway on a brand repository which will assign a Brand Standard Identifier Number (BSIN) to each brand worldwide, making it possible to integrate products in the product repository. Python developers are needed to help make this happen. If you want to help out, join in [this GitHub thread][24]. (Lots of people have already signed up!)

## Next week: Open Data Maker Night London #7

On the 4th of December next week, the [seventh London Open Data Maker Night][25] is taking place. Anyone interested in building tools or insights from data is invited to drop in at any time after 6:30 and join the fun. (Please note that the event will take place on Wednesday rather than the usual Tuesday.)

What is an Open Data Maker Night? [Read more about them here][26].

## Get involved

Labs is always looking for new contributors. Read more about how you can [join the community][27], whether you're a coder, a data wrangler, or a communicator, and check out the [Ideas Page][28] to see what else is brewing.

[1]:	http://okfnlabs.org/events/open-data-maker/
[2]:	http://okfnlabs.org/bad-data/
[3]:	http://about.me/IvanBegtin
[4]:	http://mvd.ru/opendata/od1
[5]:	http://nalog.ru/ru/opendata/p9/
[6]:	http://okfnlabs.org/members/pudo/
[7]:	http://www.bundeshaushalt-info.de/download.html
[8]:	http://okfnlabs.org/members/andylolz/
[9]:	http://datapipes.okfnlabs.org/
[10]:	http://lists.okfn.org/pipermail/okfn-labs/2013-November/001165.html
[11]:	http://okfnlabs.org/members/markbrough/
[12]:	http://pwyf.github.io/philippines/
[13]:	http://iatiregistry.org/
[14]:	http://okfnlabs.org/blog/2013/11/25/philippines.html
[15]:	http://packages.python.org/Frozen-Flask/
[16]:	http://okfnlabs.org/members/teleyinex/
[17]:	https://www.google.ca/url?sa=t&rct=j&q=&esrc=s&source=web&cd=3&cad=rja&ved=0CDsQFjAC&url=https%3A%2F%2Fgithub.com%2FPyBossa%2Fpybossa&ei=BUyXUuA0zfyoAcyogegG&usg=AFQjCNErY8CeTnsLM8hOLUYr5xGR5qlvzw&bvm=bv.57155469,d.aWM
[18]:	http://redis.io/
[19]:	http://daniellombrana.es/blog/2013/11/26/pybossa-cache.html
[20]:	http://www.product-open-data.com
[21]:	https://play.google.com/store/apps/details?id=org.okfn.pod
[22]:	https://github.com/okfn/product-browser-android
[23]:	https://github.com/okfn/product-browser-ios/issues/1
[24]:	https://github.com/okfn/brand-manager/issues/9
[25]:	http://www.meetup.com/OpenKnowledgeFoundation/London-GB/1062882/
[26]:	http://okfnlabs.org/events/open-data-maker/
[27]:	http://okfnlabs.org/join/
[28]:	http://okfnlabs.org/ideas/