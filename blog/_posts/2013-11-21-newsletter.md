---
title: "Labs newsletter: 21 November, 2013"
author: Neil Ashton
username: nmashton
layout: post
---

This week, Labs members gathered in an online hangout to discuss what they've been up to and what's next for Labs. This special edition of the newsletter recaps that hangout for those who weren't there (or who want a reminder).

## Data Pipes update

Last week you heard about [Andy Lulham][1]'s improvements to [Data Pipes][2], the online streaming data transformations service. He didn't stop there, and in this week's hangout, Andy described some of the new features he has been adding:

* parse and render are now *streaming* operations
* option parsing now uses [optimist][3]
* a basic command-line interface
* ... and much, much more

Coming up next: [map & filter with arbitrary functions][4]!

## Crowdcrafting: progress and projects

New [Shuttleworth fellow][5] [Daniel Lombraña González][6] reported on progress with [CrowdCrafting][7], the citizen science platform built with [PyBossa][8].

CrowdCrafting now has more than 3,500 users (though Daniel cautions that this doesn't mean much in terms of participation), and the site now has more answers than tasks.

Last week, the team at [MicroMappers][9] used CrowdCrafting to classify [tweets about the typhoon disaster]() in the Philippines. Digital mapping activists [SkyTruth][11], meanwhile, have used CrowdCrafting to [map and track fracking sites][12] in the northeast United States. Daniel has also been in contact with [EpiCollect][13] about a project on trash collection in Spain.

## Open Data Button

Labs member [Oleg Lavrovsky][14] discussed the [Open Data Button][15], an interesting fork of the recently-launched [Open Access Button][16].

The Open Access Button, an idea of the Open Science working group at [OKCon 2013][17], is a bookmarklet that allows users to report their experiences of having their research blocked by paywalls. The Open Data Button applies this same idea to Open Data: users can use it to report their problems with legal and technical restrictions on data. (As Rufus pointed out, this ties in nicely with the [IsItOpenData][18] project.)

## Queremos Saber

Labs ally [Vítor Baptista][19] reported on a new development with [Queremos Saber][20], the Brazilian FOI request portal.

Changes in the way the Brazilian federal government accepts FOI requests have caused Queremos Saber problems. The federal government no longer accepts requests by email, forcing the use of a specialized FOI system which they are now promoting for local governments as well. This limits the number of places that will accept requests from Queremos Saber.

A solution to this problem is underway: an *email-based API* that will take emails received at certain addresses (e.g. *ministryofhealthcare@queremossaber.org.br*) and turn them into instructions for a web crawler to create an FOI request in the appropriate system. An interesting side effect of this would be the creation of an *anonymization layer*, allowing users to bypass the legal requirement that FOI requests not be placed anonymously.

## Philippines Projects

Labs data wrangler [Mark Brough][21] showed off a test project collecting [data on aid activities in the Philippines][22]. Mark's small static site, updated each night, collects [IATI][23] aid data  on projects in the Philippines and republishes it in a more browsable form.

Mark also discussed another data-mashup project, still in the planning stage, that would combine budget and aid data for Tanzania (or any other developing country)—similar to Publish What You Fund's old [Uganda project][24] but based on a non-static dataset.

## Global Economic Map

Alex Peek discussed his initiative to create the [Global Economic Map][25], "a collection of standardized data set of economic statistics that can be applied to every country, region and city in the world".

The GEM will draw data from sources like government publications and SEC filings and will cover [eleven statistics][26] that touch on GDP, employment, corporations, and budgets. The GEM aims to be [fully integrated with Wikidata][27].

## Frictionless data

Finally, [Rufus Pollock][28] discussed [data.okfn.org][29] and the mission of "frictionless data": making it "as simple as possible to get the data you want into the tool of your choice."

data.okfn.org aims to help achieve this goal by promoting, among other things, [simple data standards][30] and the tooling to support them. As reported in last week's newsletter, this now includes a [Data Package Manager][31] based on [npm][32], now working at a very basic level. It also includes the data.okfn.org [Data Package Viewer][33], which provides a nice view on data packages hosted on GitHub, S3, or wherever else.

## Improving the Labs site

The hangout wrapped up with a discussion of how to improve the Labs site. Besides some discussion of the possibility of a [one-click creation system for Open Data Maker Nights][34], talk focused on [improving the projects page][35].

Oleg, who has volunteered to take the lead in reforming the projects page, highlighted the need for a way to differentiate projects by their activity level and their need for more contributors. Mark agreed, suggesting also that it would be nice to be able to filter projects by the languages and technologies they use. Both ideas were proposed as a way to fill out [Tod Robbins][36]'s suggestion that the projects page needs *categories*.

See the [Labs hangout notes][37] for the full details of this discussion.

## Get involved

As always, Labs wants you to join in and get involved! Read more about how you can [join the community][38] and participate by coding, wrangling data, or doing outreach and engagement, and have a look at the [Ideas Page][39] to see what other members have been thinking.

[1]:	http://okfnlabs.org/members/andylolz
[2]:	http://datapipes.okfnlabs.org
[3]:	https://github.com/substack/node-optimist
[4]:	https://github.com/okfn/datapipes/issues/21
[5]:	http://www.shuttleworthfoundation.org/fellows/daniel-lombrana/
[6]:	http://okfnlabs.org/members/teleyinex
[7]:	http://crowdcrafting.org/
[8]:	http://dev.pybossa.com/
[9]:	http://micromappers.com/
[11]:	http://skytruth.org/
[12]:	http://crowdcrafting.org/app/frackfinder_tadpole/
[13]:	http://www.epicollect.net/
[14]:	http://okfnlabs.org/members/loleg
[15]:	http://button.datalets.ch/
[16]:	https://www.openaccessbutton.org/
[17]:	okcon.org
[18]:	https://github.com/okfn/ideas/issues/41
[19]:	http://vitorbaptista.com/
[20]:	http://www.queremossaber.org.br/
[21]:	http://okfnlabs.org/members/markbrough
[22]:	http://markbrough.github.io/philippines/
[23]:	iatistandard.org
[24]:	http://publishwhatyoufund.org/uganda/
[25]:	http://meta.wikimedia.org/wiki/Global_Economic_Map
[26]:	https://meta.wikimedia.org/wiki/Grants:IdeaLab/Global_Economic_Map#Format_and_economic_statistics
[27]:	https://meta.wikimedia.org/wiki/Grants:IdeaLab/Global_Economic_Map#Wikidata_integration
[28]:	http://okfnlabs.org/members/rgrp
[29]:	http://data.okfn.org
[30]:	http://data.okfn.org/standards
[31]:	https://github.com/okfn/dpm
[32]:	https://npmjs.org/
[33]:	http://data.okfn.org/tools/view
[34]:	https://github.com/okfn/okfn.github.com/issues/134
[35]:	https://github.com/okfn/okfn.github.com/issues/46
[36]:	http://www.todrobbins.com/
[37]:	http://pad.okfn.org/p/labs-hangouts
[38]:	http://okfnlabs.org/join/
[39]:	http://okfnlabs.org/ideas/