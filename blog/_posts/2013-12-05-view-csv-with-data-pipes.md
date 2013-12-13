---
title: View a CSV (Comma Separated Values) in Your Browser
author: Neil Ashton
username: nmashton
project: datapipes
layout: post
---

This post introduces one of the handiest features of [Data Pipes][]: **[fast (pre) viewing of CSV files in your browser][pretty]** (and you can share the result by just copying a URL).

[Data Pipes]: http://datapipes.okfnlabs.org/
[pretty]: http://datapipes.okfnlabs.org/html/

<a href="http://datapipes.okfnlabs.org/html/"><img src="http://i.imgur.com/LKjphLo.png" alt="" /></a>

## The Raw CSV

[CSV files are frequently used for storing tabular data][csv] and are widely supported by spreadsheets and databases. However, you can't usually look at a CSV file in your browser - usually your browser will automatically download a CSV file. And even if you *could* look at a CSV file, it is [not very pleasant to look at][raw]:

[csv]: http://data.okfn.org/standards/csv/

<a href="http://datapipes.okfnlabs.org/csv/?url=https://raw.github.com/okfn/datapipes/master/test/data/gla.csv">
![Raw CSV](http://i.imgur.com/zVGW1zD.png)
</a>

[raw]: http://datapipes.okfnlabs.org/csv/?url=https://raw.github.com/okfn/datapipes/master/test/data/gla.csv

## The Result

But using the [Data Pipes `html` feature][pretty], you can turn an online CSV into a pretty HTML table in a few seconds. For example, the CSV you've just seen would become [this pretty table][table]:

<a href="http://datapipes.okfnlabs.org/csv/html/?url=https://raw.github.com/okfn/datapipes/master/test/data/gla.csv">![CSV, HTML view](http://i.imgur.com/fbR8DvX.png)</a>

[table]: http://datapipes.okfnlabs.org/csv/html/?url=https://raw.github.com/okfn/datapipes/master/test/data/gla.csv

## Using it

To use this service, just visit [http://datapipes.okfnlabs.org/html/][pretty] and paste your CSV's URL into the form.

For power users (or for use from the command line or API), you can just append your CSV url to:

    http://datapipes.okfnlabs.org/csv/html/?url=

### Previewing Just the First Part of a CSV File

You can also extend this basic previewing using other datapipes features. For example, suppose you have a big CSV file (say with more than a few thousand rows). If you tried to turn this into an HTML table and then view in your browser, it would probably crash it.

So what if you could just see a part of the file? After all, you may well only be interested in seeing what that CSV file looks like, not every row. Fortunately, **Data Pipes supports only showing the first 10 lines of a CSV file** using a [`head` operation][head]. To demonstrate, let's just extend our example above to use `head`. This gives us the following URL (click to see the live result):

[head]: http://datapipes.okfnlabs.org/head

<code><a href="http://datapipes.okfnlabs.org/csv/head/html/?url=https://raw.github.com/okfn/datapipes/master/test/data/gla.csv">http://datapipes.okfnlabs.org/csv/<strong>head</strong>/html/?url=https://raw.github.com/okfn/datapipes/master/test/data/gla.csv</a></code>

## Colophon

Data Pipes is a free and open service run by [Open Knowledge Foundation Labs][labs]. You can find the source code on GitHub at: <https://github.com/okfn/datapipes>. It also available as a [Node](http://nodejs.org/) library and command line tool.

[labs]: http://okfnlabs.org/

If you like previewing CSV files in your browser, you might also be interested in the [Recline CSV Viewer](https://chrome.google.com/webstore/detail/recline-csv-viewer/ibfcfelnbfhlbpelldnngdcklnndhael), a Chrome plugin that automatically turns CSVs into searchable HTML tables in your browser.
