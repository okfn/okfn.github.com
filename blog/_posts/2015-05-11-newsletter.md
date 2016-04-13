---
title: "Labs newsletter: Q1 2015"
author: Paul Walsh
username: pwalsh
projects: []
---

Welcome to the first Labs Newsletter of 2015! There has been some great activity around open data and tech in the Open Knowledge network over the first quarter of 2015. Let's dive straight in!

## Labs <3 Discourse

In case you don't know, [Discourse][discourse] is an open source forum/mailing list hybrid for communities. Open Knowledge runs a Discourse server, and of course, there is a home there for the Open Knowledge Labs community. We hope to move community discussion there going forward, so, check out the [Open Knowledge Labs][labs-discussion] category, signup, and set your digest preferences.


## Labs hangouts

The first Open Knowledge Labs hangout for 2015 was held on April 16th to a full house, and the next one is currently scheduled for May 14. Checkout the previous agenda, and planning for the next one, [here at okfnpad][labs-pad].


## Core datasets

Core datasets is a project for collecting and maintaining important and commonly-used (“core”) datasets in high-quality, standardized and easy-to-use form. There has been quite some activity here, with a [call for data curators][core-datasets] (jump in if you are interested!). Currently, 35+ volunteers are contributing, with leadership from super contributor @sxren.

Most action takes place [here][core-issues] with datasets then appearing on the [frictionless data site][core-published].

Some notable recent contributions include:

* [Media Types][core-one] (@bluechi and @sxren)
* [Membership to Copyright Treaties][core-two] (@bluechi)
* [Transparency International - Corruptions Perceptions Index][corruption]
* [Top Level Domain Names][tlds]
* [NUTS administrative boundaries][nuts]

## Data Package libraries

[Data Packages][datapackage] are a simple set of specifications for packaging data. Some great libraries have recently been released (and updated) for working with the Data Package format and related specs such as [JSON Table Schema][jsontableschema].

### dpmr: Data Package management in R

dpmr is for working with Data Packages in R. [Check it out here][dpmr].

### DataPak: Data Package management in Ruby

DataPak is for working with Data Packages in Ruby, and provides some really nice extras like managing your packages locally, SQL integration and more. Read the announcement on the Labs blog [here][datapack-announce], and check out the code [here][datapak].

### Data Package: Data Package management in Python

Data Package, and Budget Data Package, are Python packages for working with Data Packages. These libraries have been around for a while, but recently were updated to add Python 3 support. Check out Data Package [here][dp], and Budget Data Package [here][bdp].

### JTSKit: Working with JSON Table Schema in Python

[JSON Table Schema][jsontableschema] is a specification for declaring schemas for data, and is used within Data Packages. JTSKit is a Python library for working with JSON Table Schema, providing interfaces for validating schemas, inferring schema from data, and a schema model class for easy use in Python code. Check it out [here][jtskit].

## OCR PDF to Text

A new web service is available via Labs for converting documents (eg: PDF) to text using OCR. Read the announcement [here][ocr-announce], and check out the code [here][ocr].

## GoodTables

GoodTables is a web services (and Python Library/CLI) for validating tabular data. Read more about it in the announcement [here][gt-announce], check out the web service [here][gt], and the library [here][gtlib].

## Databaker

ScraperWiki have released a new library for getting data out of spreadsheets. Read the announcement [here][dt-announce], and check out the code [here][databaker].

## Council data visualisations and standards

Steve Bennett of Open Knowledge Australia has been doing some awesome work standardising and visualising council data in Victoria, Australia. He's hoping to gain wider adoption of the standards that are emerging, in Australia and beyond. The standardisation work is happening [here][ocd-repo], on the OKFNAU repository on GitHub. See some of the data visualised on the [Open Bin Map][openbins] and [Open Trees][opentrees].

## New data portal for Washington DC

Washington, DC's [data catalog has a new home][washington-new]. It operates on the ArcGIS Open Data platform and houses data relevant to city services in a variety of formats and with built-in APIs. The service is run out of the DC Office of the Chief Technology Officer, who have been quite responsive to issues and requests. You can give them a shout on Twitter as @opendatadc. Old datasets are still accessible [here][washington-old] as they transition to the new site.

## Remote data access wrapper for the Nomis API

Here's an [interesting blog post][nomis] detailing work in Python/Pandas over the Nomis API, coming out of work Tony Hirst is doing teaching data wrangling for the UK Cabinet Office.

## Get involved

Anyone can join the Labs community and get involved! Read more about how you can [join the community][join] and participate by coding, wrangling data, or doing outreach and engagement. Also check out the [ideas page][ideas] to see what's cooking in the Labs, and the [newsletter page][newsletter] if you have items to submit to the next newsletter.

[join]:	http://okfnlabs.org/join/
[ideas]: http://okfnlabs.org/ideas/
[newsletter]: http://okfnlabs.org/newsletter.html
[labs-discussion]: https://discuss.okfn.org/c/open-knowledge-labs
[discourse]: http://www.discourse.org/
[labs-pad]: https://pad.okfn.org/p/labs-hangouts
[core-datasets]: http://okfnlabs.org/blog/2015/01/03/data-curators-wanted-for-core-datasets.html
[core-issues]: https://github.com/datasets/registry/issues
[core-published]: http://data.okfn.org/data/
[core-one]: http://data.okfn.org/data/core/media-types
[core-two]: http://data.okfn.org/data/core/membership-to-copyright-treaties
[datapackage]: http://data.okfn.org/doc/data-package
[jsontableschema]: http://dataprotocols.org/json-table-schema/
[dpmr]: http://christophergandrud.github.io/dpmr/
[datapak-announce]: http://okfnlabs.org/blog/2015/04/26/datapak.html
[datapak]: https://github.com/textkit/datapak
[dp]: https://github.com/tryggvib/datapackage
[bdp]: https://github.com/tryggvib/budgetdatapackage
[jtskit]: https://github.com/okfn/jtskit-py
[washington-new]: http://opendata.dc.gov/
[washington-old]: http://legacy.data.dc.gov/
[ocr-announce]: http://okfnlabs.org/blog/2015/02/21/documents-to-text.html
[ocr]: https://github.com/mattfullerton/tika-tesseract-docker
[gt-announce]: http://okfnlabs.org/blog/2015/03/06/goodtables-web-service.html
[gt]: http://goodtables.okfnlabs.org/
[gtlib]: https://github.com/okfn/goodtables
[databaker]: https://github.com/scraperwiki/databaker
[dt-announce]: https://blog.scraperwiki.com/2015/03/databaker-making-spreadsheets-usable/
[nomis]: http://blog.ouseful.info/2015/03/09/sketching-out-a-python-pandas-remote-data-access-wrapper-for-the-nomis-api/
[ocd-repo]: https://github.com/OKFNau/open-council-data
[opentrees]: http://opentrees.org/
[openbins]: http://openbinmap.org/
[nuts]: http://data.okfn.org/data/core/geo-nuts-administrative-boundaries
[corruption]: http://data.okfn.org/data/core/corruption-perceptions-index
[tlds]: http://data.okfn.org/data/core/top-level-domain-names
