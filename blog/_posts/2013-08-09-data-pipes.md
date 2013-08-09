---
layout: post
author: Neil Ashton
title: Data Pipes: streaming online data transformation
username: nmashton
---

[Data Pipes][1] is a web service for streaming online data transformations inspired by [Unix pipes][2]. It provides an API for a collection of simple and interoperable transformations on tabular data, on the model of Unix commands like `head`, `cut`, and `grep`.

Data Pipes is currently in alpha release. Contributions are welcome via its [GitHub repository][3].

## What it does

The Data Pipes API streams a CSV file (and currently *only* a CSV file) given by a URL, applies a transform, and returns the result.

The following transforms are currently implemented:

- [`none`][4]: returns file parsed and unchanged (for CORS support: access CSVs from inside JS!)
- [`html`][5]: renders CSV as readable HTML table
- [`delete`][6]: deletes rows
- [`head`][7]: returns first *n* rows

Check out the Pipes in action as they take the [GDP dataset][8] and [drop rows 2-45][9] or return only the [first 10 rows][10], or as they take the [S&P 500 dataset][11] and render it as an [HTML table][12].

Many more transforms are planned for future releases, including Unix favourites like `cut`, `grep`, and `sed`.

## The Way of the Pipe

If you have ever wanted to share a dataset in a mildly cleaned form without having to download it, load it into Refine, and repost it, or if you have ever wanted to load a cleaned CSV file into a JavaScript app without having to maintain your own backend, Data Pipes is for you.

Data Pipes is fundamentally a web API for a collection of simple utilities that can help automate common transformations of data and perform them in bulk. It is not a new spreadsheet webapp, and it is not something that needs (or has) a graphical interface.

Data Pipes is an open-source Node.js application, freely deployable and hackable. [Node.js is "the Unix of the web"][13], they say—so it's only natural that we're using Node.js to enable simple Unix-like functionality on the web.

## How to contribute

Data Pipes is experimental software. Much remains to be implemented, including the actual "piping" of the output of one transform into the input of another.

We need suggestions for new transforms to implement and a sense for how data hackers want to use Data Pipes. Please submit your ideas and opinions as [issues][14] at the repo and make a contribution to the project!

[1]:	http://datapipes.okfnlabs.org/
[2]:	http://www.linfo.org/pipe.html
[3]:	https://github.com/okfn/datapipes
[4]:	http://datapipes.okfnlabs.org/csv/none/
[5]:	http://datapipes.okfnlabs.org/csv/html/
[6]:	http://datapipes.okfnlabs.org/csv/delete/
[7]:	http://datapipes.okfnlabs.org/csv/head/
[8]:	https://github.com/datasets/gdp
[9]:	http://datapipes.okfnlabs.org/csv/delete?range=1:45&url=https://github.com/datasets/gdp/raw/master/data/gdp.csv
[10]:	http://datapipes.okfnlabs.org/csv/head/?url=https://github.com/datasets/gdp/raw/master/data/gdp.csv
[11]:	https://github.com/datasets/s-and-p-500-companies
[12]:	http://datapipes.okfnlabs.org/csv/html/?url=https://raw.github.com/datasets/s-and-p-500-companies/master/data/constituents-financials.csv
[13]:	http://blog.izs.me/post/48281998870/unix-philosophy-and-node-js
[14]:	https://github.com/okfn/datapipes/issues