---
layout: post
author: Rufus Pollock
title: Cleaning up Greater London Authority Spending (for OpenSpending)
username: rgrp
tags:
  - OpenSpending
  - Data Wrangling
---

I've been working to get Greater London Authority spending data cleaned up and
into [OpenSpending][]. Primary motivation comes from this question:

[OpenSpending]: http://openspending.org/

> **Which companies got paid the most (and for doing what)?** (see this [issue for
more](https://github.com/openspending/thingstodo/issues/5>))

I wanted to share where I'm up to and some of the experience so far as I think
these can inform our wider efforts - and illustrate the challenges just getting
and cleaning up data. I note that the [code and README][readme] for this
ongoing work is in a repo on github: <https://github.com/rgrp/dataset-gla>

[readme]: https://github.com/rgrp/dataset-gla#readme

<a href="http://openspending.org/gb-local-gla"><img src="http://awesomeness.openphoto.me/custom/201307/gla-spend-function-476af3_870x870.jpg" alt="" /></a>

## Data Quality Issues

There are 61 CSV files as of March 2013 (a list can be found in [scrape.json][]).

[scrape.json]: https://github.com/rgrp/dataset-gla/blob/master/scrape.json>

Unfortunately the "format" varies substantially across files (even though they
are all CSV!) which makes using this data real pain. Some examples:

* no of fields and there names vary across files (e.g. SAP Document no vs
  Document no)
* number of blank columns or blank lines (some files have no blank lines
  (good!), many have blank lines plus some metadata etc etc)
* There is also at least one "bad" file which looks to be an excel file saved
  as CSV
* Amounts are frequently formatted with "," making them appear as strings to
  computers.
* Dates vary substantially in format e.g. "16 Mar 2011", "21.01.2011" etc
* No unique transaction number (possibly document number)

They also switched from monthly reporting to period reporting (where there are 13 periods of approx 28d each).

## Progress so far

I do have one month loaded (Jan 2013) with a nice breakdown by "Expenditure
Account":

<http://openspending.org/gb-local-gla>

Interestingly after some fairly standard grants to other bodies, ["Claim Settlements"][claims]
comes in as the biggest item at £2.3m

[claims]: http://openspending.org/gb-local-gla/expenditure-account/542420

- Data getting archived at <http://data.openspending.org/datasets/gb-local-gla/>
- Clean up script: <https://github.com/rgrp/dataset-gla/blob/master/scripts/process.js>

