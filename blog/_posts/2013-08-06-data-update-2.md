---
layout: post
author: Neil Ashton
title: data.okfn.org - update no. 2
username: nmashton
---

[data.okfn.org][1] is the Labs' repository of high-quality, easy-to-use open data. This update summarizes some of the improvements to data.okfn.org that have taken place over the past two months.

## New tools

Several tools which make it easier to use the [Data Package standard][2] are now operational. These include a creator, a  viewer, and a validator for Data Packages.

### Data Package Creator

Turning a CSV into a Data Package means creating a file, `datapackage.json`, which houses the metadata associated with the CSV. The [Data Package Creator][3] simplifies this process. Provide the Creator with the URL of a CSV and it will return a well-formed JSON object with the required fields, as well as a raw JSON URL.

![Data Package Creator in action][image-1]

### Data Package Viewer

The metadata included with Data Packages makes it possible to construct insightful displays of their data without further ado. The [Data Package Viewer][4] is a simple proof of this concept. Given the URL of a Data Package metadata file, the DP Viewer generates a user-friendly description, a graph of the data, and a summary of the data's fields. Here, for example, is the Viewer's display of [US wheat production][5] data.

![Data Package Viewer in action][image-2]

## New datasets

The biggest dataset news is a data.okfn.org first: a contribution of a dataset *out of the blue* by a new user. [Evan Wheeler][6] has contributed a comprehensive collection of [country codes][7] for the world's countries in Simple Data Format. Here is the [GitHub repo][8] for the dataset.

![Country codes data, table view][image-3]

Also new: 

- [Standard and Poor's 500 Index Data][9], including Dividend, Earnings, and P/E Ratio ([GitHub][10])
- [US Consumer Price Index and Inflation][11], monthly time series from January 1913 ([GitHub][12]) 

If you want to contribute a new dataset, check out the [instructions][13] and the [outstanding requests][14].

## New standards pages

Among data.okfn.org's chief contributions are its [standards][15] for data transport, a step towards a world of [frictionless data][16].

New pages have been added for each of the two major standards, [Data Package][17] and [Simple Data Format][18].

## Get involved

Anyone can contribute, and it's easy – if you can use a spreadsheet, you can help!

Instructions for getting involved can be found [here][19].

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
[13]:	http://data.okfn.org/about/contribute%23data
[14]:	https://github.com/datasets/registry/issues
[15]:	http://data.okfn.org/standards
[16]:	http://blog.okfn.org/2013/04/24/frictionless-data-making-it-radically-easier-to-get-stuff-done-with-data/
[17]:	http://data.okfn.org/standards/data-package
[18]:	http://data.okfn.org/standards/simple-data-format
[19]:	http://data.okfn.org/about/contribute

[image-1]:	http://farm8.staticflickr.com/7362/9449152387_962624e792.jpg
[image-2]:	http://farm6.staticflickr.com/5340/9449152367_13b33222df.jpg
[image-3]:	http://farm8.staticflickr.com/7324/9451935968_32719167a7.jpg