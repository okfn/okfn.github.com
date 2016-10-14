---
title: Frictionless Data Specs Working Group
author: Dan Fowler
username: dfowler
projects: [dpm,frictionless-data,mira,goodtables-web]
---

Last month, we had the first call of the **Frictionless Data
Specifications Working Group**, starting a new chapter in the project.
The call covered the status of the specifications to date, current
adoption, upcoming technical pilots and partnerships, and how work
will be organized going forward.  In this post, I will lay out the
purpose for this initiative, who is participating, and how you can get
involved.

[![Frictionless Data Logo](/img/posts/frictionlessdata-logo.png)](http://frictionlessdata.io/)

## Overview 

[Frictionless Data](http://frictionlessdata.io/) is a project
encompassing a set of tooling and specifications to ease the transport
and reuse of data. The specifications have grown out of a long
engagement with issues around data interoperability, publication
workflows, and analysis.  For most of the history of this project, the
specifications were curated by Rufus Pollock as one of several "Data
Protocols" with input and assistance from individuals from Open
Knowledge International and other organizations.  As a result, the
specifications have steadily gained traction across various projects
and software developed by, among others, the
[Open Data Institute (ODI)](http://theodi.org/),
[Tesera Systems, Inc.](http://tesera.com/),
[Dataship](https://dataship.io/), and
[Open Power System Data](http://open-power-system-data.org/).

This adoption validates the approach we've taken: creating a minimum
viable set of specifications to significantly improve transport of
data.  In reaching out to *new* users, we would like to make sure that
we have resolved some of the outstanding edge cases to ensure that
Data Packages can serve a solid foundation for many more types of
data-intensive applications.  This work is all the more important as
"core" libraries in
[Python](https://github.com/frictionlessdata/datapackage-py),
[Javascript](https://github.com/frictionlessdata/datapackage-js), and
[Ruby](https://github.com/theodi/datapackage.rb) are currently being
refined, and newer libraries, like
[R](https://github.com/frictionlessdata/datapackage-r), are being
developed.  With that in mind, we have organized a working group with
a specific goal: to deliver a first, complete version of the
specifications by end of this year.

## Working Group

Members of the working group currently include:

- [Paul Walsh](https://twitter.com/_pwalsh) (Open Knowledge International)
- [Rufus Pollock](https://twitter.com/rufuspollock) (Open Knowledge International)
- [Dan Fowler](https://twitter.com/danfowler) (Open Knowledge International)
- [Dominik Moritz](https://twitter.com/domoritz) ([University of Washington](http://www.cs.washington.edu/)) 
- [Steven De Costa](https://twitter.com/starl3n) ([Link Digital](http://linkdigital.com.au/))
- [James McKinney](https://twitter.com/mckinneyjames) ([Open North](http://www.opennorth.ca/))
- [Karissa McKelvey](https://twitter.com/okdistribute) ([Dat Data](http://dat-data.com/)
- [Spencer Cox](https://twitter.com/TheSpencerCox) ([Tesera Systems, Inc.](http://tesera.com/))

Work will happen continue to happen asynchronously, in the open,
without excessive rules around voting.  Rather, we will listen to
feedback and act in favor of consensus, without requiring it.  Rufus
Pollock, having led this work for many years with a strong focus on
keeping it simple, will remain the curator; decisions of what stays or
goes from the specs will rest with him.  Having more eyes the specs
with a variety of different perspectives will allow us to solidify and
remove ambiguous statements, eliminate unnecessary repetition or
logical errors, and, hopefully, achieve a minimal 1.0 by end of 2016.
Beyond the core Data Package specifications, open topics might include
defining further custom "profiles"
(e.g. [Fiscal Data Package](http://specs.frictionlessdata.io/fiscal-data-package/)),
as well as potential extensions, including specifications for
[visualizations](https://discuss.okfn.org/t/data-packages-views-graphs-maps-tables-etc/2667),
statistics, and quality metrics for data.

## Feedback Needed

Are you currently using or considering using the Frictionless Data
specifications for your data or application?  If so, please let us
know!

Work is managed via an
[issue tracker](https://github.com/frictionlessdata/specs/issues) on
GitHub, which is the best way to raise specific questions.  If you
would like to specifically flag an issue for the Working Group,
mention **@frictionlessdata/specs-working-group** in the comment.  For
general commentary on the specs, or any aspect of Frictionless Data,
you can leave a comment on the
[forum](https://discuss.okfn.org/c/frictionless-data).

- Current Specifications: <http://specs.frictionlessdata.io/>
  - JSON Schema (for validation): <https://github.com/frictionlessdata/schemas>
- Specs Issue Tracker: <https://github.com/frictionlessdata/specs/issues>
  - Current Milestone: <https://github.com/frictionlessdata/specs/milestone/1>
- Forum: <https://discuss.okfn.org/c/frictionless-data>

---

*Thanks to Paul Walsh who provided the motivating text that served as
 the basis for this post and Jo Barratt who did much of organizing
 necessary to make it happen.*
