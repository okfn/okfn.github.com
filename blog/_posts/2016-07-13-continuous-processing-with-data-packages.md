---
username: lexman
author: Alexandre Bonnasseau
title: "'Continuous Processing' with Data Packages"
---

When storing your data in Data Packages, it is considered good
practice to store scripts for updating, processing, or analyzing your
data in a directory called `scripts/` placed at the root of your Data
Package.  I've written a tutorial to show how to achieve __continuous
processing__: *that is, the delivery of updated data every time
something changes, either in the source data or the processing code*.

Depending on the timeliness of your dataset, you'll want to
periodically run update scripts stored in your `scripts/` directory,
but what if you don't want to run the update script of your Data
Package by yourself?  Instead, why not let
[Travis CI](https://travis-ci.org) do it for you?

If your Data Package already...

1. has scripts that download the source data, cleans it or reformats it into a nice interoperable format
1. [relies on ``make``](http://okfnlabs.org/blog/2016/03/25/make-vs-tuttle.html) to run the scripts
1. [has tests](http://okfnlabs.org/blog/2016/05/17/automated-data-validation.html) to validate the data

...then you're ready to go to the next level of automation! Here's a
[tutorial](https://github.com/lexman/ex-continuous-processing) to
enable regular updates of the data with Travis CI.

It's very well suited for small data (less then 300 MB) and when the
processing step is short (i.e. less than 10 minutes).  This makes this
workflow perfect for Data Packages!

Read the
[tutorial](https://github.com/lexman/ex-continuous-processing) to find
out more!
