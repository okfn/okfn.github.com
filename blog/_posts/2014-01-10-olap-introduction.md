---
layout: post
author: Stefan Urbanek
username: Stiivi
title: Multidimensional Data Processing and OLAP: Introduction
---

What is OLAP?
-------------

*"Online Analytical Processing – OLAP is an approach to answering
multi-dimensional analytical queries swiftly"* says
[Wikipedia](http://en.wikipedia.org/wiki/Online_analytical_processing). What
does that mean? What are multi-dimensional analytical queries? Why this
approach? We will learn all this in a short blog series.

The OLAP term comes from traditional data warehousing. There were times when
"big data" would fit into your laptop and it was time consuming to process
even that little amount compared to today's standards.  Moreover, nowdays the
majority of analytical processing (with yesterda's data amounts) can be
considered online, therefore the term OLAP is becoming a bit less appropriate.
Better would be "multidimensional data processing".

Why OLAP?
---------

There are two sides of data: data to be used by application systems (transactional,
operational) and data to be used by humans for decision making. The two kinds
of data are in many cases very different, as the applications have other needs
than humans do.

Applications require and store more detailed data. They require efficiency on
transaction (operation) level and integrity for example. The data might be
stored in different places, depending on how they are used by the systems. On
the other hand, decision makers want to see the data at one place and in the
form that reflects their view on the world. They don't care how long does it
take to store a million transactions, they want to know when those million
transactions happened and where.

Why OLAP then? Decision makers, analysts or just any other curous people would
like to answer their questions quickly. The data in database systems are not
stored in a way that the questions can be answered easily. OLAP is the
technical and semantic bridge between the two ways of using the data.

From Transactions to Analsis
----------------------------

We can see two kinds of systems: transactional/operational and analytical.
They can be physically separate, but with modern tools the analytical system
might be integrated in a database platform with transactional.

In operational systems update of information is permitted even required.
Keeping change history might be impractial in events with hight fequency. From
analytical point of view this might be undesired, as we would like to know
historical evolution of a state. For example: it is sufficient to know actual
account amount in the bank or available budget of a kind, analysts would like
to see how the amount changed over time, how it migh have been influenced by
other events.

One of the differences that I consider crucial are the system requirements:
for operational systems the requirements for data design are well known up in
front. It is very unlikely that an application will generate an unexpected
query to the system, therefore the system is built around the application's
behavior. On the other hand, requirements of an analysts are ad-hoc. The
analytical system has to be designed in a way that would allow quick answers
to business questions.

To mention few other differences between the systems:

Redundancy: in applications redundancy might introduce quite lot of errors
mostly because of data inconsistency. In the analytical system the
redundancy is even desired. Any information that is readily available close to
the data being queried is making the responses faster. The design of the
analytial systems and presence of historical data allows reconstructability of
the redundant information, therefore any inconsistencies might be corrected.

Last difference I am going to mention here is the amount of data being
processed at a single time. In the operational systems only small amount of data is
required to complete desired operaton. For example: change of client's address
(client's identification and new address), budget expense (budget line and the
expended amount). In the analytical system large amount of data has to be
"touched" to answer analysts question: "what was the spending by country?"

Summary
-------

OLAP is a way of making transactional data useable and understandable for
decision making.

To sum it up, here are the differences between analytical and transactional
data:

* subject oriented vs. application oriented
* summarized vs. detailed
* analysis driven vs. transaction driven
* read-only vs. updateable
* unknown processing requirements vs. well known processing requirements
* redundancy allowed vs. redundancy undesired
* large amount of data per operation vs. tiny amount of data per operation


See also:

* [Bill Inmon](http://en.wikipedia.org/wiki/Bill_Inmon)
* [Ralph Kimball](http://en.wikipedia.org/wiki/Ralph_Kimball)
* [Data Warehousing](http://en.wikipedia.org/wiki/Data_warehousing)
* [Business Intelligence](http://en.wikipedia.org/wiki/Business_intelligence)

Next time we will look at the multi-dimensional modeling – what it is? Why and
when it is appropriate?

