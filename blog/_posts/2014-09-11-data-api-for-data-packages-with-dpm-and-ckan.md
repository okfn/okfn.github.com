---
title: A Data API for Data Packages in Seconds Using CKAN and its DataStore
author: Rufus Pollock
username: rgrp
layout: post
projects: [frictionless-data]
---

`dpm` the command-line 'data package manager' now supports pushing [(Tabular)
Data Packages][dp-overview] straight into a [CKAN instance][ckan] (including
pushing all the data into the [CKAN DataStore][datastore]):

    dpm ckan {ckan-instance-url}

This allows you, in seconds, to get a fully-featured web data API &ndash; including [JSON][ds-json] and
[SQL-based][ds-sql] query APIs:

<img src="http://assets.okfnlabs.org/p/dpm/img/dpm-ckan.gif" alt="dpm ckan demo" />

<p style="text-align: center; font-size: x-small"><a href="http://assets.okfnlabs.org/p/dpm/img/dpm-ckan.gif">View fullsize</a></p>

Once you have a nice web data API like this we can very easily create data-driven applications and visualizations. As a simple demonstration, there's the [CKAN Data Explorer][explorer] ([example with IMF data][explorer-imf] - see below).

[explorer]: http://dev.rufuspollock.org/ckan-explorer/
[explorer-imf]: http://dev.rufuspollock.org/ckan-explorer/?endpoint=http://datahub.io&resource=ea3926e3-43a8-46d0-832a-e53efd61ebb0

## Where Can I Find a CKAN instance to Upload to?

If you're looking for a CKAN site to upload your Data Packages to we recommend
the [DataHub][] which is community-run and free. To upload to the DataHub
you'll want to.

1. Configure the DataHub CKAN instance in your `.dpmrc`

       [ckan.datahub]
       url = http://datahub.io/
       apikey = your-api-key

2. Upload your Data Package

       dpm ckan datahub --owner_org=your-organization

   You have to set the owner organization as all datasts on the DataHub need an
   owner organization.

## One I Did Earlier

Here's a live example of one "I did earlier":

* Here's the source Data Package: [IMF World Economic Outlook in data.okfn.org
  registry][imf-weo] ([Data Package on github
  (source)](https://github.com/datasets/imf-weo))
* Get this on your local machine (`dpm install` or just clone the github repo)
* Then I uploaded it: `dpm ckan http://datahub.io/ --owner_org=rufuspollock`
* Now it's live on the DataHub: <http://datahub.io/dataset/imf-weo>
  * Indicators: <http://datahub.io/dataset/imf-weo/resource/ea3926e3-43a8-46d0-832a-e53efd61ebb0>
  * Values: <http://datahub.io/dataset/imf-weo/resource/24cd8ebe-fa3f-4353-9ad9-d53bd88751a6>
  * Note this is a normalized dataset in which there are 2 tables (the
    DataStore supports JOINS if we want to put them back together)
* Here's a sample API query to get all indicators related to GDP: <http://datahub.io/api/action/datastore_search?resource_id=ea3926e3-43a8-46d0-832a-e53efd61ebb0&limit=5&q=GDP>
* Now the data has a nice web Data API you can easily build data-driven apps or
  visualizations. For example, the [CKAN Explorer][explorer] is a simple JS +
  HTML app which allows you to explore CKAN DataStore data. Here's the app
  pre-loaded with the [DataStore indicator data][explorer-imf]

[imf-weo]: http://data.okfn.org/data/core/imf-weo

Context: a big motivation (personally) for doing this is that I'd like to see a
nice web data API available for the ["Core" Data Packages][core] we're creating
as part of the [Frictionless Data effort][frictionless]. If you're interested
in helping, [get in touch][discuss-dp].

[dp-overview]: http://data.okfn.org/standards
[ckan]: http://ckan.org/
[datastore]: http://docs.ckan.org/en/latest/maintaining/datastore.html
[ds-json]: http://docs.ckan.org/en/latest/maintaining/datastore.html#ckanext.datastore.logic.action.datastore_search
[ds-sql]: http://docs.ckan.org/en/latest/maintaining/datastore.html#ckanext.datastore.logic.action.datastore_search_sql
[DataHub]: http://datahub.io/
[frictionless]: http://data.okfn.org/
[core]: http://data.okfn.org/data/
[discuss-dp]: http://discuss.okfn.org/t/data-packages-creating-finding-and-tooling/48

## Links

* [dpm Homepage](http://data.okfn.org/tools/)
* [dpm on Github](https://github.com/okfn/dpm)
* [data package to ckan (node) library](https://github.com/okfn/datapackage-ckan)
* IRC: freenode.net Channel: #okfn

