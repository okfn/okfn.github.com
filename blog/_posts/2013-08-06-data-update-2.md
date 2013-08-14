---
layout: post
author: Neil Ashton
title: data.okfn.org - update no. 2
username: nmashton
---

[data.okfn.org][1] is the Labs' repository of high-quality, easy-to-use [open data][]. This update summarizes some of the improvements to data.okfn.org that have taken place over the past two months.

[open data]: http://opendefinition.org/

## New tools

Several tools which make it easier to use the [Data Package standard][2] are now operational. These include a [Data Package creator][3], a [Data Package viewer][4], and there's progress on a [validator for Data Packages][validator].

[validator]: https://github.com/okfn/data.okfn.org/issues/27

### Data Package Creator

Turning a CSV into a Data Package means creating a file, `datapackage.json`, which houses the metadata associated with the CSV. The [Data Package Creator][3] simplifies this process.

Provide the Creator with the URL of a CSV and it will return a well-formed JSON object with the required fields, as well as a raw JSON URL (the JSON URL serves as a basic machine accessible API).

![Data Package Creator in action][image-1]

### Data Package Viewer

The metadata included with Data Packages makes it possible to construct a simple view of the data. We now provide an online [Data Package Viewer][4] to do this for you.

Just provide the link to your Data Package and Viewer generates a user-friendly description, a graph of the data, and a summary of the data fields. Here, for example, is the Viewer's display of [US wheat production data][5].

![Data Package Viewer in action][image-2]

## New datasets

The biggest data news was having our first 'out-of-the-blue' contribution of an 'official' dataset! [Evan Wheeler][6] pinged us to offer a comprehensive collection of [country codes][7] for the world's countries in [Simple Data Format][18]. Here is the:

* [Comprehensive Country Codes dataset on data.okfn.org][7] 
* [Associated GitHub repo][8] for the dataset

![Country codes data, table view][image-3]

Also new: 

- [Standard and Poor's 500 Index Data including Dividend, Earnings, and P/E Ratio][9]  ([GitHub][10])
- [US Consumer Price Index and Inflation monthly time series from January 1913][11] ([GitHub][12]) 

If you want to contribute a new dataset, check out the [instructions][13] and the [outstanding requests][14].

## New standards pages

Among data.okfn.org's chief purpose is promoting simple [standards for data transport][15] in the form of Data Package and Simple Data Format - helping to create a world of [frictionless data][16].

Key here is providing simple, easy-to-understand, information and so we've [revamped the standards page][15] and created two new pages dedicated to providing simple introduction and overview for Data Package and Simple Data Format:

* [Data Package Overview and Introduction][17]
* [Simple Data Format Overview and Introduction][18]

## Get involved

Anyone can contribute, and it's easy – if you can use a spreadsheet, you can help!

Instructions for [getting involved can be found here][19].

[1]:	http://data.okfn.org
[2]:	http://data.okfn.org/standards/data-package
[3]:	http://data.okfn.org/tools/create
[4]:	http://data.okfn.org/tools/view
[5]:	http://data.okfn.org/tools/view?url=https://raw.github.com/rgrp/wheat-us/master/datapackage.json
[6]:	https://github.com/ewheeler
[7]:	http://data.okfn.org/data/country-codes-comprehensive
[8]:	https://github.com/datasets/country-codes-comprehensive
[9]:	http://data.okfn.org/data/s-and-p-500
[10]:	https://github.com/datasets/s-and-p-500
[11]:	http://data.okfn.org/data/cpi-us
[12]:	https://github.com/datasets/cpi-us
[13]:	http://data.okfn.org/about/contribute#data
[14]:	https://github.com/datasets/registry/issues
[15]:	http://data.okfn.org/standards
[16]:	http://blog.okfn.org/2013/04/24/frictionless-data-making-it-radically-easier-to-get-stuff-done-with-data/
[17]:	http://data.okfn.org/standards/data-package
[18]:	http://data.okfn.org/standards/simple-data-format
[19]:	http://data.okfn.org/about/contribute

[image-1]:	http://farm8.staticflickr.com/7362/9449152387_962624e792.jpg
[image-2]:	http://farm6.staticflickr.com/5340/9449152367_13b33222df.jpg
[image-3]:	http://farm8.staticflickr.com/7324/9451935968_32719167a7.jpg
