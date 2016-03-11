---
layout: post
author: Dan Fowler
title: Frictionless Data Transport in Python
username: dfowler
projects: [dpm,frictionless-data,mira]
---

Tool and platform integrations for “Data Packages” are key elements of
our [Frictionless Data Initiative](http://datapackages.org/) at
[Open Knowledge International](https://okfn.org/). We recently posted
on the [main blog](http://blog.okfn.org) about some
[integration work](http://blog.okfn.org/2016/02/01/google-funds-frictionless-data-initiative-at-open-knowledge/)
funded by our friends at Google. We’ve built useful Python libraries
for working with Tabular Data Packages in some of the most popular
tools in use today by data wranglers and developers. These
integrations allow for easily getting data into and out of your tool
of choice for further manipulation while reducing the tedious
*wrangling* sometimes needed. In this post, I will give some more
details of the work done on adding support for these open standards
within [CKAN](http://ckan.org/), Google’s
[BigQuery](http://bigquery.cloud.google.com/), and common SQL database
software.  But first, here is an introduction to the format for those
who are unfamiliar.

Tabular Data Package
--------------------

![](/img/posts/tabular-data-package.png)

Tabular Data Package is a simple structure for publishing and sharing
tabular data in
[CSV](http://datapackages.org/doc/tabular-data-package#csv) format.
You can find more information about the standards
[here](http://datapackages.org/standards), but here are the key
features:

- Your dataset is stored as a collection of flat files.
    
- Useful information about this dataset is stored in a specially
  formatted JSON file, `datapackage.json` stored with your
  data. For tabular data, this information is a combination of
  *general metadata* and *schema* information.

    - General metadata (e.g. name, title, sources) are stored as
      top-level attributes of the file

    - The exact schema (e.g. type, constraint information per
      column, and relations between resources) for the tabular
      data is stored in a resources attribute. For each resource,
      a schema is specified using the
      [JSON Table Schema](http://dataprotocols.org/json-table-schema/)
      standard.

As an example, for the following `data.csv` file...

| date | price |
|------|-------|
| 2014-01-01 | 1243.068 |
| 2014-02-01 | 1298.713 |
| 2014-03-01 | 1336.560 |
| 2014-04-01 | 1299.175 |


...we can define the associated `datapackage.json` file describing it:


    {
      "name": "gold-prices",
      "title": "Gold Prices (Monthly in USD)",
      "resources": [
        {
          "path": "data.csv",
          "format": "csv",
          "schema": {
            "fields": [
              {
                "name":"date",
                "type":"date"
              },
              {
                "name":"price", 
                "type":"number", 
                "constraints": {
                  "minimum": 0.0
                }
              }
            ]
          }
        }
      ]
    }


By providing a simple, easy-to-use standard for packaging data and
building a suite of integrations to easily and losslessly import and
export packaged data using existing software, we foresee a radical
improvement in the quality and speed of data-driven analysis.

So, without further ado, let’s look at some of the actual tooling built :).

![CKAN Logo](/img/posts/ckan-logo-s.png)
----

[CKAN](http://ckan.org/), originally developed by Open Knowledge, is
the leading open-source data management system used by governments and
civic organizations around the world.  It allows organizations and
ordinary users to streamline the publishing, sharing, and use of open
data.  In the US and the UK, [data.gov](http://www.data.gov/) and
[data.gov.uk](https://data.gov.uk/) run on CKAN, and there are many
more [instances around the world](http://ckan.org/instances/#).

Given its ubiquity, CKAN was a natural target for supporting Data
Packages, so we built a
[CKAN extension](http://docs.ckan.org/en/latest/extensions/index.html)
for importing and exporting Data Packages both via the UI and the API:
[ckanext-datapackager](https://github.com/ckan/ckanext-datapackager).
This work
[replaces](https://github.com/ckan/ckanext-datapackager#where-is-the-old-open-knowledges-data-packager)
a previous implementation for an earlier version of CKAN.

### CKAN Data Packager Extension

- Source and usage information: [https://github.com/ckan/ckanext-datapackager](https://github.com/ckan/ckanext-datapackager)
- Screencast (UI): [https://youtu.be/qEaAJB\_GYmQ](https://youtu.be/qEaAJB_GYmQ)
- Screencast (API): [https://asciinema.org/a/8jrpft2etpubte8jupfko8ci5](https://asciinema.org/a/8jrpft2etpubte8jupfko8ci5)

BigQuery and SQL Integration
----------------------------

[BigQuery](https://developers.google.com/apps-script/advanced/bigquery)
is Google’s web service for querying massive datasets.  By providing a
Python library, we can allow data wranglers to easily import and
export "big" Data Packages for analysis in the cloud.  Likewise, by
supporting general SQL import and export for Data Packages, a wide
variety of software that depend on typical SQL databases can support
Data Packages natively.  The library powering both implementations is
[datapackage-storage-py](https://github.com/okfn/datapackage-storage-py),
which provides a high level interface for importing and exporting
tabular data to and from
[Tabular Storage](https://github.com/okfn/datapackage-storage-py#tabular-storage)
objects based on
[JSON Table Schema](http://dataprotocols.org/json-table-schema/)
descriptors.

### BigQuery 

- Source: [jsontableschema-bigquery-py](https://github.com/okfn/jsontableschema-bigquery-py).
- Screencast: [https://www.youtube.com/watch?v=i\_YHSwl-7VU](https://www.youtube.com/watch?v=i_YHSwl-7VU&feature=youtu.be)
- Walkthrough: [https://gist.github.com/vitorbaptista/998aed29097945aaccff](https://gist.github.com/vitorbaptista/998aed29097945aaccff)

### SQL 

- Source and usage information: [jsontableschema-sql-py](https://github.com/okfn/jsontableschema-sql-py).
- Screencast: [https://asciinema.org/a/cyzd0lz0kqvcqmg4zneifohov](https://asciinema.org/a/cyzd0lz0kqvcqmg4zneifohov)
- Walkthrough: [https://gist.github.com/vitorbaptista/19d476d99595584e9ad5](https://gist.github.com/vitorbaptista/19d476d99595584e9ad5)

### Beyond

This modular approach allows us to easily build support across many
more tools and databases.  We already have plans to support
[MongoDB](https://www.mongodb.org/) and
[DAT](https://github.com/maxogden/dat).  Of course, we need feedback
from **you** to pick the next libraries to focus on.  What tool do you
think could benefit from Data Package integration?  Tell us in the
[forum](https://discuss.okfn.org/c/open-knowledge-labs/data-packages).

![](/img/posts/tabular-storage-diagram.png)

For more information on Data Packages and our Frictionless Data
approach, please visit
[http://datapackages.org/](http://datapackages.org/).
