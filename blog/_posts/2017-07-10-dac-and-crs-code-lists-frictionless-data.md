---
author: Andy Lulham
username: andylolz
projects: [frictionless-data]
title: DAC and CRS code lists – Now available as Frictionless Data!
---

*This blog was originally posted on the [Publish What You Fund](http://www.publishwhatyoufund.org/maintained-machine-readable-dac-crs-code-lists-de-rien/) website.*

Maintained, machine readable versions of [the DAC and CRS code lists are now available as CSV and JSON!](http://data.okfn.org/data/core/dac-and-crs-code-lists) Here’s how [Publish What You Fund](http://www.publishwhatyoufund.org/) and [Open Knowledge](https://okfn.org/) made it happen…

![DAC CRS Bot](https://d26dzxoao6i3hh.cloudfront.net/items/1u361E1a3W1U3H2U3v0A/android.png)

The [OECD](http://www.oecd.org)’s Development Assistance Committee ([DAC](http://www.oecd.org/dac/)) maintains a set of code lists used by donors to report on their aid flows. These are used as part of donors’ DAC reporting, but also in their [IATI publications](https://iatiregistry.org/). Not only that, but since some of the codes e.g. for aid classification, are so widely used, they are also useful to recipient country governments to [map aid activities to their own budgets](http://aidonbudget.org/). So they’re super important!

## Keeping in sync

Now, these code lists are [available on the OECD website](http://www.oecd.org/dac/stats/dacandcrscodelists.htm) as a non-machine-readable XLS file. There’s also an XML version, but it was last updated 18-months ago, and as such it differs significantly from the standard, canonical XLS version on the OECD website.

Because of this lack of a machine-readable version, [IATI maintains its own replicated versions of these code lists](https://github.com/IATI/IATI-Codelists-NonEmbedded/tree/master/xml). These replicated versions are used by [d-portal](http://d-portal.org/), the [IATI Dashboard](http://dashboard.iatistandard.org/) and others. However, due to the overheads involved in maintaining them, these too have fallen out of sync with the source file.

There has been a-rumbling (and some grumbling!) within the IATI community about [getting the DAC to produce a machine-readable version](https://discuss.iatistandard.org/t/planning-for-machine-readable-version-controlled-oecd-dac-codelists/866/8) of these code lists. This idea has long been in the offing, and we at Publish What You Fund would very much welcome such a development.

In the meantime, though, we have taken matters into our own hands. Together with [Open Knowledge](https://okfn.org/), we’ve published [a frictionless data package of the DAC code lists](http://data.okfn.org/data/core/dac-and-crs-code-lists) – with data available in machine-readable CSV and JSON formats. This is published as an [Open Knowledge Core Dataset](http://data.okfn.org/roadmap/core-datasets) – a group of **important** and **commonly-used** datasets in **high quality, easy-to-use and open** form.

## But how does it work? The science bit!

The data is [stored on github](https://github.com/datasets/dac-crs-codes/tree/master/data), and maintained by a scraper that runs nightly on [morph.io](https://morph.io/) (created by the wonderful [Open Australia Foundation](https://www.openaustraliafoundation.org.au/)). When a change to the data is detected, a pull request is sent by [DAC CRS Bot](https://github.com/dac-crs-bot), and reviewed by a (human) maintainer. Via github, [we maintain a version history of changes to the data](https://github.com/datasets/dac-crs-codes/commits/master/data), so it’s possible to tell what changed and when.

The next logical step would be for IATI to [use this data to maintain their replicated lists](https://github.com/IATI/IATI-Codelists-NonEmbedded/pull/51) as a routine maintenance task. We’ve already tested this as a proof of concept one-off task, to [bring all the relevant replicated IATI code lists up-to-date](https://github.com/IATI/IATI-Codelists-NonEmbedded/pull/153), including adding all French translations. De rien!
