---
layout: post
author: Neil Ashton
title: PublicBodies.org progress
username: nmashton
---

There have been many new developments with [PublicBodies.org][1], the Labs project which aims to provide "a URL for every part of government", since [the last update][2] on the Labs blog.

The news includes: a new and improved backend; a push for integration with [Nomenklatura][3]; discussion of a revamp of the PublicBodies schema; lots of new data waiting to be integrated; and a new idea for how PublicBodies might be useful.

## PublicBodies: now much shinier

Thanks to the hard work of Labs member [Rowan Crawford][4], PublicBodies is now a proper webapp. It's now a [Node.js app][5] running on [Heroku][6], and its interface is much nicer than before. Let's all give Rowan a hand!

Development of the PublicBodies website is ongoing. The next task for improving the site will be [adding search][7].

## Nomenklatura integration

Entity reconciliation is crucial for a service like PublicBodies. Luckily, the Labs has another project that simplifies reconciliation, namely [Nomenklatura][8]. The obvious step is to start pushing PublicBodies data to Nomenklatura and pulling it when it gets updated. This idea is discussed more fully in [an issue][9].

Contributor [David Read][10] has got the ball rolling with Nomenklatura integration by pushing [UK public bodies data][11]. This is a great start – but we want to automate this and start automatically pushing CSVs across to Nomenklatura. Volunteers to build this functionality, please step up!

## Popolo schema integration

[Popolo][12] is a project with a goal very relevant to PublicBodies: the creation of "international open government data specifications relating to the legislative branch of government". These include a data specification for [organizations][13].

We're considering reworking the PublicBodies schema to follow the Popolo organization spec. The changes would be nontrivial but wouldn't involve any massive reorganization of the data. Please help us think this through by joining in the discussion [in the issues][14].

## Lots of new data

Once the matter of revamping the schema is resolved, we can start integrating the heaps of new data which has been contributed. The new data includes public bodies from the US, Germany, China, Quebec, Italy, and Slovenia. You can see it all [here][15]. Thanks to the contributors who have brought this data together.

The sooner we come to a decision about the Popolo schema, the sooner we can start incorporating all of this new material – so please let us know what you think!

## Discussion: organization identifiers

Contributor [Mark Brough][16] has come up with an interesting idea for how PublicBodies might be useful: it could be used to generate organisation identifiers usable in situations calling for unique identifiers, such as IATI data publication. As Mark observes, public organizations often lack these identifiers, which makes publishing data a struggle.

Read the details of Mark's proposal [in the issues][17], and let him know what you think.

[1]:	http://publicbodies.org
[2]:	http://okfnlabs.org/blog/2013/05/01/publicbodies.org-an-update.html
[3]:	http://nomenklatura.okfnlabs.org/
[4]:	http://okfnlabs.org/members/wombleton/
[5]:	https://github.com/okfn/publicbodies
[6]:	https://www.heroku.com/
[7]:	https://github.com/okfn/publicbodies/issues/3
[8]:	http://nomenklatura.okfnlabs.org/
[9]:	https://github.com/okfn/publicbodies/issues/2
[10]:	https://github.com/davidread
[11]:	http://nomenklatura.okfnlabs.org/uk-public-bodies
[12]:	http://popoloproject.com/
[13]:	http://popoloproject.com/specs/organization.html
[14]:	https://github.com/okfn/publicbodies/issues/29
[15]:	https://github.com/okfn/publicbodies/issues?direction=desc&labels=Data&page=1&sort=updated&state=open
[16]:	https://github.com/markbrough
[17]:	https://github.com/okfn/publicbodies/issues/41