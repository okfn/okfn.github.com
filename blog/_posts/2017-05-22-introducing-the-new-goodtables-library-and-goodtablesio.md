---
author: Serah Rono
username: callmealien
projects: [frictionless-data,good-tables]
title: Introducing the new goodtables library and goodtables.io
---

Information is everywhere. This means that there is so much we need to know at any given time, but such limited capacity and time to internalize it all. True art, therefore, lies in the ability to draw summaries adequate enough to save time and impart knowledge. From the 1880s, tabulation has been our go-to method for compacting information, not only to preserve it, but also to make analyses and draw meaningful conclusions out of it.

Tables, comprised of rows and columns of related data, are not always as easy to analyze, and especially not when there are thousands of rows of data. Mixed data types, missing data, or ill-suited data in tables are but a few reasons why tabular data is often a nightmare to work with in its raw state, often referred to as "dirty" data.

Enter **goodtables**.

[![goodtables python library](/img/posts/goodtables-python-library.png)](https://github.com/frictionlessdata/goodtables.io)


## The goodtables library

[goodtables](https://github.com/frictionlessdata/goodtables-py/) is a Python library that allows users to inspect tabular data, checking it for both structural and schematic errors, and giving pointers on plausible error fixes, before users draw analyses on the data using other tools. At its most basic level, goodtables highlights general errors in tabular files that would otherwise prevent loading or parsing.

Since [the release of goodtables v0.7 in early 2015](/blog/2015/02/20/introducing-goodtables.html), the codebase has evolved, allowing for additional use cases while working with tabular data.  Without cutting back on functionality, goodtables v1 has been simplified, and the focus is now on extensible data validation.

## Using goodtables

goodtables is still in alpha, so we need to pass the pre-release flag (`--pre`) to `pip` to install.  With that, installation of goodtables v1 is as easy as `pip install goodtables --pre`.

The goodtables v1 CLI supports two presets by default: **_table_**  and **_datapackage_**.  The `table` preset allows you to inspect a single tabular file.

_Example:_

`goodtables --json table valid.csv` returns a JSON report for the file specifying the error count, source, and validity of the data file among other things.

The `datapackage` preset allows you to run checks on datasets aggregated in one container.  [Data Packages](http://specs.frictionlessdata.io/data-package/) are a format for coalescing data in one 'container' before shipping it for use by different people and with different tools.

_Example:_

`goodtables datapackage datapackage.json` allows a user to check a data package’s schema, table by table, and gives a detailed report on errors, row count, headers, and validity or lack thereof of a data package.

You can try out these commands on your own data or you can use datasets [from this folder](https://github.com/frictionlessdata/goodtables-py/tree/master/data).

## Customization

In addition to general structure and schema checks on tabular files available in v0.7, the goodtables library now allows users to define custom (data source) presets and run custom checks on tabular files. So what is the difference?

While basic schema checks inspect data against [the data quality spec](https://github.com/frictionlessdata/data-quality-spec), `custom_check` gives developers leeway to specify acceptable values against data fields so that any values outside of the defined rules are flagged as errors.

`custom_preset` allows users to define custom interfaces to your data storage platform of choice. They allow you to tell goodtables where your dataset is held, whether it is hosted on CKAN, Dropbox, or Google Drive.

Any presets outside of the built-in ones above are made possible and registered through a provisional API.

_Examples:_

+ **_CKAN custom preset_**:
[CKAN](http://ckan.org) is the world’s leading open data platform developed by Open Knowledge International to help streamline the publishing, sharing, finding and using of data.
[Here’s a custom preset](https://github.com/frictionlessdata/goodtables-py/blob/master/examples/ckan.py) that, for example, could help the user run an inspection on datasets from [Surrey's Data Portal](http://data.surrey.ca) which utilizes CKAN.

+ **_Dropbox custom preset_**:
Dropbox is one of the most popular file storage and collaboration cloud service in use. It ships with an API that makes it possible for third party apps to read files stored on Dropbox as long as a user’s access token is specified. Here’s our [goodtables custom preset for Dropbox](https://github.com/frictionlessdata/goodtables-py/blob/master/examples/dropbox.py). Remember to generate an access token by first [creating a Dropbox app with full permissions](https://www.dropbox.com/developers/apps).

+ **_Google Sheets custom preset_**:
The Google Sheets parser to enable custom preset definition is currently in development. At present, for any data file stored in Google Drive and published on the web, the command `goodtables table google_drive_file_url` inspects your dataset and checks for validity, or lack thereof.

## Validating multiple tables

goodtables also allows users to carry out parallel validation for multi-table datasets. The **_datapackage_** preset make this possible.

_Example:_

[Frictionless Data](http://frictionlessdata.io) is a core Open Knowledge International project and all goodtables work falls under its umbrella. One of the pilots working with Frictionless Data is [DM4T](https://github.com/frictionlessdata/pilot-dm4t), with an aim to understand the extent to which Data Package concepts can be applied in the energy sector. DM4T pilot’s issue tracker [lives here](https://github.com/frictionlessdata/pilot-dm4t) and its [Data Package](https://s3-eu-west-1.amazonaws.com/frictionlessdata.io/pilots/pilot-dm4t/datapackage.json) comprises of [20 CSV files](http://data.okfn.org/tools/view?url=https%3A%2F%2Fs3-eu-west-1.amazonaws.com%2Ffrictionlessdata.io%2Fpilots%2Fpilot-dm4t%2Fdatapackage.json) and is approximately 6.7 GB in size.

To inspect DM4T’s energy consumption data collected from 20 households in the UK, run:

```
goodtables --table-limit 20 datapackage https://s3-eu-west-1.amazonaws.com/frictionlessdata.io/pilots/pilot-dm4t/datapackage.json
```

In the command above, the `--table-limit` option allows you to check all 20 tables, since by default goodtables only runs checks on the first ten tables by default.  You can find plenty of sample Data Packages for use with goodtables [in this repository](https://github.com/datasets/).

So why use GitHub for storage of data files?  At Open Knowledge International, we [highly recommend](http://blog.okfn.org/2013/07/02/git-and-github-for-data/) and [work with others to](http://blog.okfn.org/2016/11/29/git-for-data-analysis-why-version-control-is-essential-collaboration-public-trust/) use GitHub repositories for dataset storage.

**PRO TIP:**
In working with datasets hosted on GitHub, say [the countries codes Data Package](https://github.com/datasets/country-codes), users should use the raw file URL with goodtables, since support for GitHub URL resolution is still in development.

## Standards and other enhancements

goodtables v1 also works with our proposed [data quality specification standard](https://github.com/frictionlessdata/data-quality-spec), which defines [an extensive list](https://github.com/frictionlessdata/goodtables-py/blob/master/goodtables/spec.json) of standard tabular data errors.  Other enhancements from goodtables v0.7 include:

1. Breaking out [tabulator](http://github.com/frictionlessdata/tabulator) into its own library.  As part of the Frictionless Data framework, **_tabulator_** is a Python library that has been developed to provide a consistent interface for stream reading and writing tabular data that is in whatever format, be it CSV, XML, etc. The library is installable via pip: `pip install tabulator`.
2. Close to 100% support for  [Table Schema](http://specs.frictionlessdata.io/table-schema/) due to lots of work on the underlying [Python library](https://github.com/frictionlessdata/jsontableschema-py).  The Table Schema Python library allows users to validate dataset schema and, given headers and data, infer a schema as a python dictionary based on its initial values.
3. Better CSV parsing, better HTML detection, and less false positives.

## goodtables.io

[![goodtablesio](/img/posts/goodtablesio.jpg)](https://github.com/frictionlessdata/goodtables.io)

Moving forward, at Open Knowledge International we want to streamline the process of data validation and ensure seamless integration is possible in different publishing workflows. To do so, [we are launching a continuous data validation hosted service](https://discuss.okfn.org/t/launching-goodtables-io-tell-us-what-you-think/5165) that builds on top of this suite of Frictionless Data libraries.  [goodtables.io](http://goodtables.io) will provide support for different backends. At this time, users can use it to check any datasets hosted on GitHub and Amazon S3 buckets, automatically running validation against data files every time they are updated, and providing a user friendly report of any issues found.

Try it here: [goodtables.io](http://goodtables.io)

This kind of continuous feedback allows data publishers to release better, higher quality data and helps ensure that this quality is maintained over time, even if different people publish the data.

Using [this dataset on Github](http://goodtables.io/github/frictionlessdata/example-goodtables.io), here’s sample output from data validation run on goodtables.io:

[![illustrating data validation on goodtables.io](/img/posts/goodtablesio-validation.png)](http://goodtables.io/github/amercader/car-fuel-and-emissions)

Updates on the files in the dataset will trigger a validation check on goodtables.io. As with other projects at Open Knowledge International, [goodtables.io code is open source](https://github.com/frictionlessdata/goodtables.io) and contributions are welcome. We hope to build functionality to support additional data storage platforms in the coming months, please let us know which ones to consider in our [Gitter chat](https://gitter.im/frictionlessdata/chat) or on the [Frictionless Data forum](https://discuss.okfn.org/c/frictionless-data).
