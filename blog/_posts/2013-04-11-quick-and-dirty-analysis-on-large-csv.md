---
layout: post
author: Rufus Pollock
title: Quick and Dirty Analysis on Large CSVs
username: rgrp
---

I'm playing around with some large(ish) CSV files as part of a [OpenSpending](http://openspending.org/) related data investigation to look at UK government spending last year -- example question: which companies were the top 10 recipients of government money? (More details can be
found in [this issue on OpenSpending's things-to-do repo](https://github.com/openspending/thingstodo/issues/5>)).

The dataset I'm working with is the consolidated spending (over £25k) by all UK goverment departments. Thanks to the efforts of of OpenSpending folks (and specifically Friedrich Lindenberg) this data is already nicely ETL'd from thousands of individual CSV (and xls) files into one big 3.7 Gb file (see below for links and details).

My question is what is the best way to do quick and dirty analysis on this?

Examples of the kinds of options I was considering were:

* Simple scripting (python, perl etc)
* Postgresql - load, build indexes and then sum, avg etc
* Elastic MapReduce (AWS Hadoop)
* Google BigQuery

Love to hear what folks think and if there are tools or approaches they would specifically recommend.

### The Data

* Here's the [3.7 Gb CSV](http://data.etl.openspending.org/uk25k/spending-latest.csv)
* A [Data Package file](http://www.dataprotocols.org/en/latest/data-packages.html) for the data describing the fields: <https://raw.github.com/openspending/dpkg-uk25k/master/datapackage.json>

