---
layout: post
author: Friedrich Lindenberg
title: Wrangling dirty data with messytables.
snapshot: messytables
username: pudo
---

One of the largest data collection projects we have done so far
has been the [consolidation of the UK's departmental expenditure](http://openspending.org/resources/gb-spending/).
Over 370 different government entities have published a total
of more than 7000 spreadsheets. Many of those have obviously
been hand-crafted or at least manually processed. Our goal was to 
consolidate the contained information into a single 
spreadsheet, discarding all the eccentricities included by the individual
publishers.

[messytables](https://github.com/okfn/messytables) is a simple
Python library that tries to extract tabular contents from
spreadsheet documents created by human editors. Often, even files
released as CSV or Excel are still not easy to parse
programmatically. Some people like to start off spreadsheets with
a title column or some metadata, while others use inapproriate
formats to represent numbers or dates.

The tool offers a set of functions that help to make parsing data
easier:

* A **headers detector** tries to determine which row in a spreadsheet
  contains the actual header definitions (as opposed to any trailing
  content).

* **type detection** attempts to guess the data type for each column,
  including a wide range of commonly used date formats.

* support for **streaming data**, so that extremely large tables can
  be processed without loading the entire data into memory.

* and, of course, it supports a **range of spreadsheet types** - from
  trusty CSV to Excel and even OpenOffice formats.

We've since also started using messytables to load data into the
[data API of CKAN](http://ckan.org/2012/10/22/ckan-1-8-released/),
where it serves as the ETL for the datastore and related
[ReclineJS](http://reclinejs.com/) previews.

If you're interested, check out the [messytables documentation](http://messytables.readthedocs.org/en/latest/index.html)
and the [uk25k scripts](https://github.com/openspending/dpkg-uk25k/blob/master/extract.py)
which use it to gather UK government finance. 

Of course, messytables is not a cure-all and only useful for reading
data.

* [tablib](http://docs.python-tablib.org/en/latest/), for example, has
a fantastic API that makes writing, analyzing and converting data a
breeze.
* [csvkit](http://csvkit.readthedocs.org/en/latest/index.html) has a
set of command line utilities that should be pre-installed on any
computer.

But when it comes to tables that are a complete mess: give it a try!


