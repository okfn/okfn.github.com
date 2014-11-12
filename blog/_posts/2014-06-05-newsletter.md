---
title: "Labs newsletter: 5 June, 2014"
author: Neil Ashton
username: nmashton
layout: post
projects: [textus,annotator]
---

Welcome back to the OKFN Labs! Members of the Labs have been building tools, visualizations, and even new data protocols—as well as setting up conferences and events. Read on to learn more.

If you'd like to suggest a piece of news for next month's newsletter, leave a comment on its [GitHub issue](https://github.com/okfn/okfn.github.com/issues/215).

## commasearch

[Thomas Levine](http://okfnlabs.org/members/tlevine/) has been working on an innovative new approach to searching tabular data, [commasearch](https://github.com/tlevine/commasearch).

Unlike a normal search engine, where you submit words and get pages of words back, with commasearch, you submit spreadsheets and get spreadsheets in return.

What does that mean, and how does it work? Check out Thomas's excellent blog post "[Pagerank for Spreadsheets](http://dada.pink/dada/pagerank-for-spreadsheets/)" to learn more.

## GitHub diffs for CSV files

*Submitted by [Paul Fitzpatrick](http://okfnlabs.org/members/paulfitz/).*

GitHub has added CSV viewing support in their web interface, which is fantastic, but it still doesn’t handle changes well. If you use Chrome, and want lovely diffs, check out James Smith's [CSVHub](https://github.com/theodi/csvhub) extension ([blogpost and screenshot](http://theodi.org/blog/csvhub-github-diffs-for-csv-files)). The diffs are produced using the [daff](http://paulfitz.github.io/daff/) library, available in javascript, ruby, php, and python3.

## Textus Wordpress plugin

*Update from Iain Emsley.*

The Open Literature project to provide a [Wordpress plugin back-end for the Textus viewer](https://github.com/okfn/textus-wordpress) has made new progress.

This project's goal was to keep the existing Textus frontend—which has been [split off as its own project](https://github.com/okfn/textus-viewer) by Rufus Pollock—and replace the backend with a Wordpress plugin, to make it easier to deploy. A version of this plugin backend is now available.

The new plugin acts as a stand-alone module that can be enabled and disabled as required by the administrative user. It creates a new Wordpress post type called “Textus” which is available as part of the menu, giving the user a place to upload text and annotation files using the Media uploader.

If you are interested in the project, check out its [issues](https://github.com/okfn/textus-wordpress/issues) and discussion on the [Open Humanities list](https://lists.okfn.org/mailman/listinfo/open-humanities).

## Data protocols: updates

[Data Protocols](http://dataprotocols.org/), the Labs's set of lightweight standards and patterns for open data, has had a couple of interesting developments.

The [JSON Table Schema](http://dataprotocols.org/json-table-schema/) protocol has just added support for constraints (i.e. validation), thanks to [Leigh Dodds](http://www.ldodds.com/). This adds a `constraints` attribute containing requirements on the content of fields. See the full [list of valid constraints](http://dataprotocols.org/json-table-schema/#field-constraints) on the JSON Table Schema site.

The [Data Package Manager](https://github.com/okfn/dpm/) tool for Data Packages is shaping up nicely: the `install` and `init` commands have now been implemented. You can see an [animated GIF](https://github.com/okfn/dpm/issues/3#issuecomment-43440812) of the former in the issue thread.

## AnnotatorJS: new home

Annotator is "an open-source JavaScript library to easily add annotation functionality to any webpage".

The project now lives on its own domain at [annotatorjs.org](http://annotatorjs.org/). Check it out and see how easy it is to add comments and notes to your pages!

## csv,conf

Data makers everywhere will want to check out [csv,conf](http://csvconf.com/), a fringe event of [Open Knowledge Festival 2014](http://2014.okfestival.org/) taking place in Berlin on 15 July.

csv,conf is a non-profit community conference that will "bring together data makers/doers/hackers from backgrounds like science, journalism, open government and the wider software industry to share tools and stories".

[Tickets are $75, $50 with an OKFest ticket](http://register.csvconf.com/). If you can make it to Berlin in July and you're into "advancing the art of data collaboration", come join in!