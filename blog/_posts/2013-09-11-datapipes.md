---
layout: post
author: Rufus Pollock
title: Data Pipes - streaming online data transformations
username: rgrp
---

Data found in the wild is rarely useful in its natural form. It must be processed, refined, and filtered to separate the wheat from the chaff. It must undergo a series of transformations.

[Data Pipes](http://datapipes.okfnlabs.org/) provides online access to simple data transformations – like deleting rows, find and replace, and filtering – and, more excitingly, allows you to connect these transformations together ala *Unix pipes* to make more complex transformations. Because Data Pipes is a web API, data transformation with Data Pipes takes place entirely online – transforming and sharing a dataset is as simple as copying a URL.

A Data Pipes API call that takes a set of [Greater London Authority financial data](http://static.london.gov.uk/gla/expenditure/docs/2012-13-P12-250.csv), slices out 50 rows, cuts the 0th column, deletes rows 1 through 7, filters for rows containing “LONDON”, and finally renders the result as HTML looks like this:

    /csv/head -n 50/cut 0/delete 1:7/grep LONDON/html?url=https://raw.github.com/okfn/datapipes/master/test/data/gla.csv

## Pipes, NodeJS and the Unix Philosophy

Much of the inspiration for Data Pipes comes from using Unix command lines tools like `grep`, `sed`, and `head` to work with files and data. These tools a powerful way to operate on *streams* of text (or more precisely streams of lines of text, since Unix tools process text files line by line). By using streams, they can scale to large files easily (they don’t load the whole file but process it bit by bit) and, more importantly, allow “piping” – that is, direct connection of the output of one command with the input of another.

This already provides quite a powerful way to do data wrangling (see [here](https://github.com/rgrp/command-line-data-wrangling) for more). But there are limits: data isn’t always line-oriented, plus command line tools aren’t online, so it’s difficult to share and repeat what you are doing. Inspired by a combination of Unix pipes and the possibilities of NodeJS’s great streaming capabilities, we wanted to take the pipes online for data processing – and so Data Pipes was born.

This also connects neatly with the [Unix philosophy](http://www.faqs.org/docs/artu/ch01s06.html), an approach to software design that says: write programs that do one thing, do it well, and interact via text streams. It teaches us to solve problems with cascades of simple, composable operations that manipulate text, an approach which has proven almost *universally* effective.

Data Pipes brings the Unix philosophy and the Unix pipes style to online data. Any [CSV](http://data.okfn.org/standards/csv) dataset with a URL can be piped through a cascade of transformations to produce a modified dataset, without ever downloading the data and with no need for your own backend. Being online means that the operations are immediately shareable and linkable.

## Examples

Take, for example, this copy of a set of [Greater London Authority financial data](https://raw.github.com/okfn/datapipes/master/test/data/gla.csv). It's unusable for most purposes, simply because it doesn't abide by the CSV convention that the first line should contain the headers of the table. The header is preceded by six lines of useless commentary. Another problem is that the first column is totally empty.

<img src="http://farm4.staticflickr.com/3824/9726020908_bb2d26b694.jpg" width="500" height="363" alt="Data pipes: Greater London Authority financial data, in the raw">

First of all, let's use the Data Pipes `html` operation to get a nicer-looking view of the table.

	GET /csv/html/?url=http://static.london.gov.uk/gla/expenditure/docs/2012-13-P12-250.csv

<img src="http://farm3.staticflickr.com/2827/9726020844_0301af2ded.jpg" width="500" height="213" alt="Data pipes: GLA data, HTML view">

Now let's get rid of those first six lines and the empty column. We can do this by chaining together the `delete` operation and the `cut` operation:

	GET /csv/delete 0:6/cut 0/html/?url=http://static.london.gov.uk/gla/expenditure/docs/2012-13-P12-250.csv

And just like that, we've got a well-formed CSV!

<img src="http://farm4.staticflickr.com/3728/9726020800_ff01da582e.jpg" width="500" height="177" alt="Data pipes: GLA data, trimmed">

But why stop there? Why not take the output of that transformation and, say, search it for the string "LONDON" with the `grep` transform, then take just the first 20 entries with `head`?

	GET /csv/delete 0:6/cut 0/grep LONDON/head -n 20/html/?url=http://static.london.gov.uk/gla/expenditure/docs/2012-13-P12-250.csv

<img src="http://farm6.staticflickr.com/5505/9726020732_c5ca38c10a.jpg" width="500" height="370" alt="Data pipes: GLA data, final view">

Awesome!

## What's next?

Data Pipes already supports a useful collection of operations, but it's still in development, and more are yet to come, including the find-and-replace operation `sed`. You can see the full list [on the Data Pipes site](http://datapipes.okfnlabs.org/), and you can suggest more transforms to implement by [raising an issue](https://github.com/okfn/datapipes/issues/new) at the Data Pipes repo.

Data Pipes needs more operations for its toolkit. That means its developers need to know what you do with data – and to think about how it can be broken down in the grand old Unix fashion. To join in, check out [Data Pipes on GitHub](https://github.com/okfn/datapipes) and let us know what you think.