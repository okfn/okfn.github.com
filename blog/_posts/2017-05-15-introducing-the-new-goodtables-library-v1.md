---
author: Serah Rono
username: callmealien
projects: [routetopa,frictionless-data,opendataday]
title: Introducing the New goodtables Library
published: false
---

Information is everywhere. This means that there is so much we need to know at any given time, but such limited capacity and time to internalize it all. True art, therefore, lies in the ability to draw summaries adequate enough to save time and impart knowledge. From the 1880s, tabulation has been man’s go to method for compacting information, not only to preserve it, but also to make analyses and draw meaningful conclusions out of it.

Tables, comprised of rows and columns of related data, are not always as easy to analyze, and especially not when there’s thousands of rows of data. Mixed data types, missing data, ill-suited data in tables are but a few reasons why tabular data is often a nightmare to work with in its raw state, often referred to as ‘dirty’ data.

Enter **goodtables**.

goodtables is a python library that allows users to inspect tabular data, checking it for both structural and schematic errors, and giving pointers on plausible error fixes, before users draw analyses on the data using other tools. At its most basic level, goodtables highlights general errors in tabular files i.e. data that won’t load or cannot be parsed.

Since [the release of goodtables v0.7 in early 2015](http://okfnlabs.org/blog/2015/02/20/introducing-goodtables.html), the code base has evolved, allowing for additional use cases while working with tabular data.  Without cutting back on functionality, goodtables v1 has been simplified and focus is now on data validation.

Installation of goodtables v1 is as easy as  
**`pip install goodtables --pre`**

goodtables v1  supports the **_table_**, **_tables_** and **_datapackage_** presets by default. For the Examples below, we will use datasets [from this folder](https://github.com/frictionlessdata/goodtables-py/tree/master/data).  
The **_table_** preset allows you to inspect a single tabular file. Programmatically, you can also inspect multiple tabular files in parallel using the tables preset.  
  _Example:_  
  **`goodtables --json table valid.csv`** 
  returns the JSON Table Schema (JTS) for the specified file, specifies error count and states source and validity of the data file among other things.

Data Packages are a format for coalescing data in one ‘container’ before shipping it for use by different people and with different tools. In goodtables, the datapackage preset allows you to run checks on datasets aggregated in one container. Working with data package Examples [from this repository](https://github.com/frictionlessdata/goodtables-py/tree/master/data/datapackages):  
  _Example:_  
  **`goodtables datapackage datapackage.json`**  
  allows a user to check a data package’s schema, table by table, and gives a detailed report on errors, row count, headers, and validity or lack thereof of a data package.

In addition to general structure and schema checks on tabular files available in v0.7, the goodtables library now allows users to define custom data presets and run custom checks on tabular files. So what is the difference?

While basic schema checks inspect data against this data quality spec , **_custom data checks_** give users leeway to specify acceptable values against data fields so that any values outside of the defined rules are flagged as errors.

**_Custom data presets_** allow users to define APIs whose tools contain data files that validation checks need to be run on. They answer the question - where is your dataset held? This could be CKAN, Dropbox, or, in the near future, Google Docs.

Any presets outside of the built-in ones above are made possible and registered through a provisional API. Any presets outside of the built in ones above are made possible and registered through a provisional API. If used with other programs, it is important to specify the goodtables version in your requirements file.

_Examples:_  
+ **_CKAN custom preset_**  
[CKAN](http://ckan.org) is the world’s leading open data platform developed by Open Knowledge International to help streamline the publishing, sharing, finding and using of data.
[Here’s a custom preset](https://github.com/frictionlessdata/goodtables-py/blob/master/Examples/ckan.py) that helps the user run inspection on datasets from http://data.surrey.ca which utilizes CKAN.

+ **_DropBox custom preset_**  
Dropbox is one of the most popular file storage and collaboration cloud service in use. It ships with an API that makes it possible for third party apps to read files stored on Dropbox as long as a user’s access token is specified. Here’s our [goodtables custom preset for DropBox](https://github.com/frictionlessdata/goodtables-py/blob/master/examples/dropbox.py). Remember to generate an access token by first [creating a dropbox app with full permissions](https://www.dropbox.com/developers/apps).

+ **_Google Sheets custom preset_**  
The Google Sheets parser to enable custom preset definition for g|Docs is currently under construction. You can [follow progress here](https://github.com/frictionlessdata/tabulator-py/issues/117). At present, for any data file stored in Google Drive and published on the web so it is publicly available, the command  
**`goodtables table google_drive_file_url`**  
inspects your dataset and checks for validity, or lack thereof.

goodtables also allows users to carry out parallel computation for multi-table datasets. This means that users can run checks on datasets they obtain, as is, without having to first split and save data in workbooks into separate data files. The **_tables_** and **_datapackage_** presets make this possible.  
_Example:_  
[Frictionless Data](http://frictionlessdata.io) is a core Open Knowledge International project and all goodtables work falls under its umbrella. One of the pilots working with Frictionless Data is [DM4T](https://github.com/frictionlessdata/pilot-dm4t), with an aim to understand the extent to which Data Package concepts can be applied in the energy sector. DM4T pilot’s issue tracker [lives here](https://github.com/frictionlessdata/pilot-dm4t) and its [Data Package](https://s3-eu-west-1.amazonaws.com/frictionlessdata.io/pilots/pilot-dm4t/datapackage.json) comprises of [20 CSV files](http://data.okfn.org/tools/view?url=https%3A%2F%2Fs3-eu-west-1.amazonaws.com%2Ffrictionlessdata.io%2Fpilots%2Fpilot-dm4t%2Fdatapackage.json) and is approximately 6.7 GB in size.   
With good internet connection, goodtables v1 makes it possible to run checks on large datasets in a few seconds, 15 for me,  without having to download these large files. To inspect DM4T’s energy consumption data collected from 20 households in the US, run:  
**`goodtables --table-limit 20 datapackage https://s3-eu-west-1.amazonaws.com/frictionlessdata.io/pilots/pilot-dm4t/datapackage.json`**  
In the command above, the --table-limit option allows you to check all 20 tables, since   
**`goodtables datapackage  https://s3-eu-west-1.amazonaws.com/frictionlessdata.io/pilots/pilot-dm4t/datapackage.json`**  
only runs checks on the first ten tables by default.

Unlike DM4T’s data package which is too big (Github has a 100MB limit on files and a 1 GB limit on repositories in general), lots of smaller Data Packages are stored on Github. You can find plenty of sample Data Packages for use with goodtables [in this repository](https://github.com/datasets/) as well [as this one](https://github.com/frictionlessdata/example-data-packages).

So why use Github for storage of data files?  At Open Knowledge International, we [highly recommend](http://blog.okfn.org/2013/07/02/git-and-github-for-data/) and [actively work to](http://blog.okfn.org/2016/11/29/git-for-data-analysis-why-version-control-is-essential-collaboration-public-trust/) use Github repositories for dataset storage.

**PRO TIP:**   
In working with datasets hosted on Github, say [the countries and currencies data package](https://github.com/frictionlessdata/example-data-packages/tree/master/countries-and-currencies), users should use the raw file URL with goodtables, since support for Github URL resolution is still in development.

For the dataset above:  
**`goodtables datapackage https://raw.githubusercontent.com/frictionlessdata/example-data-packages/master/countries-and-currencies/datapackage.json`**    
returns an error but  
**`goodtables datapackage https://raw.githubusercontent.com/frictionlessdata/example-data-packages/master/countries-and-currencies/datapackage.json`**  
runs just fine.

goodtables v1 also works with [data quality specification standard](https://github.com/frictionlessdata/data-quality-spec), which has [an extensive list](https://github.com/frictionlessdata/goodtables-py/blob/master/goodtables/spec.json) of standard tabular data errors. goodtables Schema is linked to it and reads from it every time predefined presets are run on goodtables CLI.

Other enhancements from goodtables v0.7 include:  
1. breaking out tabulator into a library that is useful on its own.
As part of the Frictionless Data framework, **_tabulator_** is a python library that has been developed to provide a consistent interface for stream reading and writing tabular data that is in whatever format, be it csv, xml, et al. The library ships with a simple CLI to read tabular data and installing it is as easy as:  
**`pip install tabulator`**  
to read tabular data, run:  
**`tabulator nameoffile.csv`**  
The command above displays your tabular data in the command line.

2. close to 100% [JSON Table Schema](http://specs.frictionlessdata.io/json-table-schema/) support due to lots of work on [jsontableschema python library](https://github.com/frictionlessdata/jsontableschema-py), which allows users to validate dataset schema and, given headers and data, one can infer a JSON table as a python dictionary  based on its values.

3. better csv parsing, better html detection, less false positives

![goodtablesio](https://github.com/okfn/okfn.github.com/blob/master/img/posts/goodtablesio.jpg)

Moving forward, we want to streamline the process of data validation and ensure seamless integration is possible on different publishing workflows. To do so, [we are launching a continuous data validation hosted service](http://goodtables.io) that builds on top of [all these great Frictionless Data](https://github.com/frictionlessdata/tabulator-py) libraries.goodtables.io will provide support for different backends. At this time, users can use it to check any datasets hosted on GitHub and Amazon S3 buckets, automatically running validation against data files every time they are updated, and providing a user friendly report of any issues found. 
This kind of continuous feedback allows data publishers to release better, higher quality data and helps ensure that this quality is maintained over time, even if different people publish the data. 

Using [this dataset on Github](http://goodtables.io/github/frictionlessdata/example-goodtables.io), here’s sample output from data validation run on goodtables.io:
![illustrating data validation on goodtables.io](https://github.com/okfn/okfn.github.com/blob/master/img/posts/gtio%20data%20validation%20.png)



Any updates on the valid and invalid csv files will reflect in real time on goodtables.io. As with other projects at Open Knowledge International, [goodtables.io code is open source](https://github.com/frictionlessdata/goodtables.io) and contributions are welcome. We hope to build functionality to support additional data storage platforms in the coming months, please let us know which ones to consider in our [Gitter chat](https://gitter.im/frictionlessdata/chat) or on [Frictionless Data Discuss](https://discuss.okfn.org/c/frictionless-data).  

Open Knowledge International’s work on data packages and Frictionless Data has been as a result of learnings from building and deploying [CKAN](http://ckan.org) which involved a lot of collaborations with data publishers. goodtables seeks to identify errors that users regularly encounter in working with open data,  and returns helpful information so the user can find and resolve these errors promptly, thus serving as a useful tool for data source inspection and validation as part of the data publication flow.
