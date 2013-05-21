---
layout: post
author: Friedrich Lindenberg
title: Nomenklatura - Data Matching and Reconciliation Made Easy
username: pudo
---

[Nomenklatura][] is a simple service that makes it easy to maintain a canonical list of entities such as persons, companies or event streets and to match messy input, such as their names against that canonical list &ndash; for example, matching Acme Widgets, Acme Widgets Inc and Acme Widgets Incorporated to the canonical "Acme Widgets".

[Nomenklatura]: http://nomenklatura.okfnlabs.org/

With Nomenklatura its a matters of minutes to set up your own set of master data to match against and it provides a simple user interface and [API][api] which you can then use do matching (the API is compatible with Open Refine's reconciliation function).

[Nomenklatura][] can not only store the master set of entities you want to match against but also will learn and record the various aliases for a given entity - such as a person, organisation or place - may have in various datasets.

[api]: http://nomenklatura.okfnlabs.org/about

<a href="http://nomenklatura.okfnlabs.org/"><img src="http://i.imgur.com/h9411NU.jpg" /></a>

As such Nomenklatura chooses a design half way between an entity database (such as OpenCorporates, PopIt or similar services) and a automated de-duplication software (such as dedupe or SILK).

Nomenklatura has been battle-tested with real-world usage, for example to de-duplicate the names of [German parliamentarians](http://nomenklatura.okfnlabs.org/offenesparlament), [UK government departments](http://nomenklatura.okfnlabs.org/uk25k-departments) and [spending data schemas and EU lobbyists](http://nomenklatura.okfnlabs.org/openinterests-entities).

Typically, a data extraction process will check all the entity names it discovers in the source data against nomenklaturas API. If Nomenklatura does not recognize a name, a new alias record is stored as a placeholder. This alias can then be matched to an entity by the user through a simple-to-use reconciliation user interface.

To kickstart such a process, data can be uploaded via CSV - but new entities can be created dynamically as well. The advantage of a manual approach is that it minimizes the risk of false matches -- this level of quality assurance can be crucial, if, for example, the output will be displayed in an application that is intended to hold government to account. 

## This Release

This latest release of Nomenklatura includes a number of important changes: 

* The domain model was refactored to use a clearer naming scheme, canonical values are now called "entities", and their alternative spellings are now "aliases".

* CSV upload support allows users to submit a list of entities, aliases or fully executed mappings. 

* Support for the Open Refine API was added, so that each Nomenklatura dataset can be added as a reconciliation service and used to clean data from inside Refine.

* Keyboard shortcuts were added to the reconciliation tool, so that matches can be identified without using a mouse - a fast user can now match a few hundred records an hour.

* The Python client library has been refactored and submitted to PyPi, it can be installed via "pip install pynomenklatura". 

## Credits and Links

Nomenklatura was developed by [Labs Member Friedrich Lindenberg](/members/pudo/) with contributions from other folks including fellow Labs members Michael Bauer.

[Nomenklatura source code on GitHub](https://github.com/pudo/nomenklatura)

