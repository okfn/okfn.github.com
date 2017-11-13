---
author: Dan Fowler
title: Comma Chameleon at csv,conf,v2
username: dfowler
---

Having co-organized csv,conf,v2 this past May, a few of us from Open
Knowledge International had the awesome opportunity to travel to
Berlin and sit in on a range of fascinating talks on the current
state-of-the-art on wrangling messy data.  One such talk was given by
Stuart Harrison of the **Open Data Institute** (ODI) who presented on
tool he is developing called Comma Chameleon.  Comma Chameleon is a
desktop CSV editor with *validation magic* &#127775;.

![Stuart Harrison](/img/posts/comma-chameleon-small.jpg)

## Comma Chameleon

CSV is a great, simple format that is easy to publish and use by
technical and non-technical users alike.  But CSV can also be *abused*
(see [Bad Data][bad-data] for examples), leading Stuart and his team
at ODI Labs---the R&D team at ODI---to develop [Comma Chameleon][cc].
Comma Chameleon is a desktop tool that uses [CSVLint][csvlint] under
the hood to validate CSVs for their structural integrity as well as
their adherence to a schema specified in [JSON Table Schema][jts]
([CSV on the Web][csvw] support in progress).

![Comma Chameleon](/img/posts/comma-chameleon-period-table.png)

The point of Comma Chameleon is to give non-technical users the
ability to create and edit CSV files in a more appropriate tool than
Excel, software designed for manipulating spreadsheets first and
foremost.  The app allows users to fix errors in their data in place
*before* publishing using the handy validation functions described
above.  Comma Chameleon also allows users to add useful metadata---for
instance, a title, description, and a license---and export it all as a
zipped [Data Package][dp].

## Frictionless Data

Comma Chameleon---built with [Electron][electron]---is an excellent
example of the kind of tool that can provide the foundation for real
advances in data quality thanks to adherence to a few simple, open
standards.  At Open Knowledge International, we are currently working
hard on [Frictionless Data][fd], an initiative to define and promote
just such tools and standards.  We are *delighted* to be partnering
with the ODI in the coming months on this and other initiatives around
Frictionless Data.

* Download Comma Chameleon: <https://github.com/theodi/comma-chameleon>
* Follow ODILabs on Twitter: <https://twitter.com/odilabs>
* Follow Stuart Harrison on Twitter: <https://twitter.com/pezholio>
* Follow Open Knowledge Labs on Twitter: <https://twitter.com/okfnlabs>
* See the full range of speakers from csv,conf,v2: <http://csvconf.com>

See Stuart's full talk:

<iframe width="576px" height="360px"
src="https://www.youtube.com/embed/wIIw0cTeUG0" frameborder="0"
allowfullscreen></iframe>

[fd]: http://frictionlessdata.io/
[csvlint]: http://csvlint.io
[csvw]: http://w3c.github.io/csvw/
[jts]: http://frictionlessdata.io/guides/table-schema/
[dp]: http://frictionlessdata.io/guides/data-package/
[cc]: https://github.com/theodi/comma-chameleon
[bad-data]: http://okfnlabs.org/bad-data/
[odilabs]: https://twitter.com/ODILabs
[csvconf]: http://csvconf.com/
[electron]: http://electron.atom.io/
[pezholio]: https://twitter.com/pezholio
