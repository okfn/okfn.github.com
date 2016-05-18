---
title: Automated Data Validation with Data Packages
author: Dan Fowler
username: dfowler
projects: [dpm,frictionless-data,mira,goodtables-web]
---

Software projects have long benefited from [Continuous Integration]()
services like [Travis CI](http://travis-ci.org/) and
[Jenkins](https://jenkins.io) for automatically executing unit tests
and generating reports on each commit into a shared repository.  These
services allow developers to find and solve errors more quickly,
generally improving software quality as the size of the codebase and
development team increases.  As a side benefit, these services often
provide a "badge" to show the current status of the most recent build
at a glance.

![Build Passing](/img/posts/build-passing.png)

As with software, datasets are often collaboratively created, edited,
and updated over time, sometimes introducing subtle (or not so subtle)
structural and schematic errors (see
[Bad Data](http://okfnlabs.org/bad-data/) for examples).  Much of the
"friction" in working with data comes from the time and effort needed
to identify and address these errors before analyzing in a given tool.
Automatically flagging *data* quality issues can go a long way in
making data more useful and have significant follow-on effects in the
data ecosystem, both open and closed.  

## Continuous Data Integration

As the [Frictionless Data](http://frictionlessdata.io/) tooling and
standards ecosystem continues to grow, we now have the elements
necessary to provide data managers with the same type of service for
tabular data (e.g. Excel and CSV).  In less than one hour, we booted a
small demo in preparation for [csv,conf,v2](http://csvconf.com/) to
show what *continuous data integration* could look like:

![Data CI](/img/posts/data_ci_travis.png)

<https://github.com/frictionlessdata/ex-continuous-data-integration>

The Data Package descriptor file,
[datapackage.json](http://dataprotocols.org/data-packages/), provides
both high-level metadata as well as a
[schema](http://frictionlessdata.io/guides/json-table-schema/) for
tabular data.  The Python libary
[datapackage-py](http://github.com/frictionlessdata/datapackage-py)
allows us to inspect and work with the data inside the Data Package.
We call out to the
[GoodTables API](http://goodtables.okfnlabs.org/api) service to
validate our tabular data.  Given that our example relies
[GitHub as a data storage mechanism](http://blog.okfn.org/2013/07/02/git-and-github-for-data/),
[Travis CI](http://travis-ci.org/) served as a convenient host to test
out this idea, but this approach is broadly applicable to any storage
backend with some extra tweaking (e.g. using AWS
[Lambda](https://aws.amazon.com/lambda/) and
[S3](https://aws.amazon.com/s3/)).

## How It Works

On every update, two small test functions read the `datapackage.json`
to read and validate the tabular data contained therein.  Validation
according to its structure and adherence to a
[schema](http://frictionlessdata.io/guides/json-table-schema/).
Structural errors include whether the CSV is malformed in some way
(e.g. missing headers, blank rows, etc.).  Schema errors refer to data
that is invalid with respect to a defined using JSON Table
Schema(e.g. a column should be `int` but is string).  Behind the
scenes, this is just a normal Travis CI configuration.

On every update, a report is generated that shows what is wrong with
your data and how to fix it in user-friendly language.
