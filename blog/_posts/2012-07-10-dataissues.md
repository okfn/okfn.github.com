---
layout: post
author: Friedrich Lindenberg
title: dataissues.org - public issue tracking for data defects
username: pudo
---

*On June 21st, the Knight News Challenge Round on Data ended. The day before, 
[Rufus](http://rufuspollock.org/), [Ross](https://twitter.com/rossjones) and
I sat down to write out some ideas that we'd been discussing for a while. While
we submitted proposals for [Grano](/2012/07/09/grano.html) and [DataProtocols](http://newschallenge.tumblr.com/post/25576949597/data-protocols-rough-consensus-running-code-and), we decided to hold back on this idea for another round. Still, sharing is caring.*

**1. What do you propose to do? [20 words]**

We’ll create a web service where data wranglers and consumers can log errors arising from processing, viewing or using data.

**2. How will your project make data more useful? [50 words]**

All data has errors. While data quality is often talked about, the best practice for data apps is often to have half a paragraph on the ‘about’ page. We want to build a service that is useful to data wranglers, but can also serve as documentation for end-users and basis for further discussion.

**3. How is your project different from what already exists? [30 words]**

Error reporting for software is either done as task tickets (e.g. github.com) or by capturing raw application output (e.g. exceptional.io). For data, we want to combine these two approaches to let users group recurring errors into issues that can then be discussed and fixed. 

**4. Why will it work? [100 words]**

While all data processing workflows are different from dataset to dataset, the types of errors that occur are often quite similar and can be stored in a shared service. This is both immediately useful when doing data work - especially scheduled, unsupervised processes - but also as an activity log for other people to see. 

We’ll create both an easy-to-use online validation tool to check spreadsheets against a certain schema and an API with client libraries that can be integrated into existing processing pipelines. The reported issues can be full-out errors, but also probes that highlight implausible values.

**5. Who is working on it? [100 words]**

The Open Knowledge Foundation is... 

**6. What part of the project have you already built? [100 words]**

We’ve got extensive experience working with dataset metadata from DataHub.io and produced a number of complex data processing pipelines (e.g. for UK spending data, that merges over 5000 spreadsheets in different formats). These clearly show the need for better reporting, and we have built several ad-hoc solutions but know that is a major area that is inadequately addressed in our work and those of others. We have already got a basic prototype and can build a first increment quickly.

**7. How would you use News Challenge funds? [50 words]**

We’ll built it! We’ll develop a full version of this service iteratively, test and promote it. We plan to work together with civic data projects as early adopters to get quick feedback and adapt the service to suit their needs. 

**8. How would you sustain the project after the funding expires? [50 words]**

This will be perfectly suited to SaaS freemium model in which heavy and/or professional users who need to report large amounts of errors and generate complex reports pay a subscription fee. In addition as open-source software the project can be re-used and extended by others.

**If you think this is a good idea, [help hacking and contribute patches to the dataissues repository](http://github.com/okfn/dataissues)!**
