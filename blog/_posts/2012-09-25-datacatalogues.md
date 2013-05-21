---
layout: post
author: Friedrich Lindenberg
snapshot: datacatalogues
title: Data Catalogues are People!
username: pudo
---

Last week, [Matej Kurian](https://twitter.com/matejkurian) published
a message on the [okfn-labs mailing](http://lists.okfn.org/mailman/listinfo/okfn-labs)
list, [describing](http://lists.okfn.org/pipermail/okfn-labs/2012-September/000376.html) the various sources he had discovered for
machine-readable excerpts of the EU's joint procurement system, TED.
What struck me about this message was that, apparently, this polite
and brilliant policy wonk had turned into something strange: into a
data catalogue.

While not quite a Kafka-grade transformation, it's an odd turn to
take for a researcher. But Matej is not the only one: the team of
[FarmSubsidies.org](http://farmsubsidy.org/) has experienced a similar re-definition, as did
the ERDF researchers at the [Bureau of Investigative Journalists](http://www.thebureauinvestigates.com/).

The best data catalogues today are well-informed people.

When I talk to journalists about data acquisition, they seem to know
this already: its often not just about where to look; it's even more
important to know who to talk to. But why does this observation from a
telephone-and-filofax world hold true even in digital space, where
every bit of knowledge is supposed to be only a click away?

I believe that some blame goes to the simplistic model underlying our
efforts to catalogue data: the question of where to find a dataset is
certainly important, but for those actually working with the data it's
just not enough. Once you dig into data, other questions rise to the
foreground:

* How do the different available datasets interact and integrate? Does
  the data I am looking for even make sense on its own - or do I need
  to combine several sources? Take, for example, the UKs *Whole of
  Government Accounts*: while data.gov.uk [lists](http://data.gov.uk/dataset/coins) a few gigabytes worth of
  downloads for this dataset, it is completely impossible to interpret
  the data without also fetching Excel files (and PDF guidance) off the
  Treasury web site, the Department of Communities and Local Government
  site and - bonus points - emailing the Treasury for their internal
  toolkit.

* How complete and up-to-date is the data? What technical and political
  constraints apply to the publication? Again, FarmSubsidies provide a
  nice example, as a 2010 European Court of Justice verdict has severely
  limited the availablity of the data - leading to an oddly limited
  dataset today.

* Who else is working with this data and what are they doing? Are there
  derivative datasets that I should use instead of the source material?
  It may be worth knowing, for example, that as well as browsing the
  6000-odd departmental spending spreadsheets, journalists can also search
  across a consolidated version of this data on OpenSpending.org

But why are current data portals so bad at capturing such information?
Certainly, adding a few comment boxes and an app gallery can do a good
job glossing over the problem, but the real problems seem to lie deeper in
the technology:

* Datasets are a useless unit. A while ago, [Richard Cyganiak](http://richard.cyganiak.de/) defined a
  dataset as "a set of data" - which I assume is a computer scientists
  way of telling you to get lost. And while I'm not normally a big fan
  of LOD-clouds, they got this right: all the interesting stuff is
  happening in between datasets. Whether it's about reconstructing a
  process across several datasets or finding out about geographical and
  temporal coverage - datasets are at best building blocks, more often
  they are just arbitrary. So maybe its time to think about other
  mechanisms to represent data sources: what about policy maps and
  government wiring plans?

* Even worse, the metadata we keep about datasets is mostly based on a
  bureaucratic mindset: they're library-inspired, static index
  cards that hope to represent datasets, while data are really subject
  to complex processes both within and outside the institutions that
  produce them. For anyone using the data, activity metadata is
  the interesting part. We've already figured this out for software,
  where libraries like FreshMeat and SourceForge have been replaced by
  activity-driven platforms like GitHub. The key aspect here is that
  GitHub doesn't require me to explictly make metadata - the relevant
  narrative is simply summarized from my working pattern.

  Of course, all of this is just a long way of saying that the best
  metadata is in the data itself. So unless you're working on the LHC
  stuff there really isn't much of a reason to separate the two any
  longer: let's make public, audit-trailed databases that report on
  themselves. This, of course, is easier said then done as it implies
  that all data will fit into one storage mechanism. In the real
  world (i.e. outside Linked Data land), this is unlikely to be true
  of structured data any time soon.

Still, even after fixing our model of how we talk about datasets on the
web, I think we would still find that the best way to ensure that people
collaborate around data is community-building: creating networks that
garden the commons. Perhaps we should start cataloguing those.

