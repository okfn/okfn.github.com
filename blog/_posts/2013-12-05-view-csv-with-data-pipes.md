---
title: View a CSV with Data Pipes
author: Neil Ashton
username: nmashton
layout: post
---

One handy thing about [Data Pipes](http://datapipes.okfnlabs.org/), the web API for streaming and composable data transformations, is that you can use it to simply get a nice view of a CSV.

Looking at a CSV file [in the raw](https://raw.github.com/okfn/datapipes/master/test/data/gla.csv) is not very pleasant:

![Raw CSV](http://i.imgur.com/zVGW1zD.png)

The basic Data Pipes parse of the data, which you get with the following API call, doesn't look any different:

    http://datapipes.okfnlabs.org/csv/?url=https://raw.github.com/okfn/datapipes/master/test/data/gla.csv

But getting a nice HTML table view of the data is as simple as this:

    http://datapipes.okfnlabs.org/csv/html/?url=https://raw.github.com/okfn/datapipes/master/test/data/gla.csv

![CSV, HTML view](http://i.imgur.com/fbR8DvX.png)

This is almost as nice as what you get with the [Recline CSV Viewer plugin](https://chrome.google.com/webstore/detail/recline-csv-viewer/ibfcfelnbfhlbpelldnngdcklnndhael), and it doesn't require you to install anything.
