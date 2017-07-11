---
author: Dan Fowler
title: Measure for Measure
username: dfowler
---

*In his Open Knowledge International Tech Talk, Developer Brook Elgie
describes how we are using Data Package Pipelines and Redash to gain
insight into our organization in a declarative, reproducible, and easy
to modify way.*

This post briefly introduces a newly launched internal project at
[Open Knowledge International][oki] called
[Measure][measure], its history, motivation, and the tech that drives
it.  To learn more, watch the embedded video demonstration by
developer Brook Elgie and check out the [code][measure].

## What is Measure?

[Measure][measure] is a system that allows us to collect and analyze metrics
from the various internal sources and external platforms we use to do
our work, and surface them in a user-friendly, queryable interface.
These include the number of views on our main website, downloads of
our libraries from [PyPI][pypi], retweets on Twitter, and form-based
records of recent talks we’ve given.  Like many organizations, we rely
heavily on hosted platforms to execute on our mission, each of which
has its own interface to useful data.  This can make it harder to
correlate events (e.g. how many downloads did this software package
have after this blog post?) and yield insight across platforms.  It’s
critical to harmonize access to this data not only for us to learn how
to be more effective, but also to demonstrate to external funders the
impact of our work advancing the cause of openness.  It's also
important for this data to be accessible to everyone at the
organization, regardless of their technical skill.

<iframe width="560" height="315" src="https://www.youtube.com/embed/NVuJq_WseJQ?list=PLOGV29UsPM6hTC5Nvd2ySyI_5q-C1_i1S" frameborder="0" allowfullscreen></iframe>

### How Does it Work?

Measure relies on several technologies we are developing here at Open
Knowledge International around our Frictionless Data project.  Each of
our projects has a [source specification file][measure-source] defined
in YAML and split into themes. For example, `social-media` is a theme
for data sources such as Twitter and Facebook, while `code-packaging`
is used for NPM and PyPI. Each theme has a [pipeline][dpp-pipeline]
which is composed of [processors][dpp-processor] which do the actual
work of fetching data and transforming the [Data Package][dp] (a
collection of data and descriptive metadata) and its resources.  Data
is moved through the thematic pipeline using
[Data Package Pipelines][dpp] and a handful of other tools in the
Frictionless Data project.  The final processor writes the processed
resources to the Measure database, which is used as the data source
for our visualisation tool, [Redash][redash]. Each pipeline is
configured to run once a day.  You can read more about Data Package
Pipelines and how it enables this process in its
[introductory blog post][dpp-intro].

By consolidating our metrics into a single database and surfacing
through Redash, it’s easy to create and share visualisations across
one or more data sources, create dashboards of project and
organization health, and make truly data-driven decisions with minimal
friction.

## Tech Talks

If you enjoyed this, you can see similar content on our
[Open Knowledge International Tech Talks YouTube Playlist][techtalks].

[measure]: https://github.com/okfn/measure
[dpp-intro]: /blog/2017/02/27/datapackage-pipelines.html
[dpp]: https://github.com/frictionlessdata/datapackage-pipelines
[techtalks]: https://www.youtube.com/playlist?list=PLOGV29UsPM6hTC5Nvd2ySyI_5q-C1_i1S
[oki]: https://okfn.org/
[measure-source]: https://github.com/okfn/measure#project-configuration
[dpp-pipeline]: https://github.com/frictionlessdata/datapackage-pipelines#pipelines
[dpp-processor]: https://github.com/frictionlessdata/datapackage-pipelines#custom-processors
[pypi]: https://pypi.python.org/pypi
[dp]: http://specs.frictionlessdata.io/data-package/
[redash]: https://redash.io/
