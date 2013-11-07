---
layout: post
author: Rufus Pollock
username: rgrp
title: Tracking Issues with Data the Simple Way
---

[Data Issues][issues] is a prototype initiative to track “issues” with data using a simple bug tracker—in this case, GitHub Issues.

We've all come across “issues” with data, whether it’s “data” that turns out to be provided as a PDF, the many ways to badly format tabular data ([empty rows, empty columns][empty], inlined metadata …), “[ASCII spreadsheets][ascii]”, or simply erroneous data.

[ascii]: http://okfnlabs.org/bad-data/ex/bls-us-employment/
[empty]: http://okfnlabs.org/bad-data/ex/tfl-passenger-numbers/

Key to starting to improve data quality is a way to report and record these issues.

We've thought about ways to address this for [quite some time][7] and, led by [Labs member Friedrich Lindenberg][pudo], even experimented with building our [own service][service]. But recently, thanks to a comment from [Labs member David Miller][miller], we were hit with a blinding insight: why not do the simplest thing possible and just use an **existing bug tracker tool**? And so was born the current version of [Data Issues based on a github issue tracker][issues]!

![Data Issues](http://i.imgur.com/lyIJYGo.png)

*Aside: Before you decide we were completely crazy not to see this in the first place, it should be said that doing data issues “properly” (in the medium term) probably does require something a bit more than a normal bug tracker. For example, it would be nice to be able to both pinpoint an issue precisely (e.g. the date in column 5 on line 3751 is invalid) and group similar issues (e.g. all amounts in column 7 have a commas in them). Doing this would require a tracker that was customized for data. The solution described in this post, however, seems like a great way to get started.*

[issues]: https://github.com/datasets/issues
[service]: http://okfnlabs.org/blog/2012/07/10/dataissues.html
[miller]: http://okfnlabs.org/members/david/
[pudo]: http://okfnlabs.org/members/pudo/

## Introducing Data Issues

Given the existence of so many excellent issue-tracking systems, we thought the best way to start is to reuse one—in the simplest possible way.

With [Data Issues][1], we’re using GitHub Issues to track issues with datasets. Data Issues is essentially just a GitHub repository whose Issues are used to report problems on open datasets. Any problem with any dataset can be reported on Data Issues.

To report an issue with some data, just [open an issue in the tracker][5], add relevant info on the data (its URL, who's responsible for it, the line number of the bug, etc.), and explain the problem. You can add labels to group related issues—for example, if multiple datasets from the same site have problems, you can add a label that identifies the dataset's site of origin.

Straightaway, the issue you raise becomes a *public notice* of the problem with the dataset. Everyone interested in the dataset has access to the issue. The issue is also *actionable*: each issue contains a thread of comments that can be used to track the issue's status, and the issue can be *closed* when it has been fixed. All issues submitted to Data Issues are visible in a central list, which can be filtered by keyword or label to zoom in on relevant issues. All of these great features come *for free* because we’re using GitHub Issues.

## Get Involved

For Data Issues to work, people need to use it. If civic hackers, journalists, and other data wranglers learn about Data Issues and start using it to track their work on datasets, we might find that the problem of tracking issues with datasets has already been solved.

You can also contribute by helping develop the project into something richer than a simple Issues page. One limitation of Data Issues is that raising an issue does not actually contact the parties responsible for the data. Our next goal is to automate sending along feedback from Data Issues, making it a more effective bug tracker.

If you want to discuss new directions for Data Issues or point out something you’ve built that contributes to the project, get in touch via the [Labs mailing list](http://lists.okfn.org/mailman/listinfo/okfn-labs).

[1]:	https://github.com/datasets/issues
[5]:	https://github.com/datasets/issues/issues/new
[6]:	http://blog.okfn.org/2013/07/02/git-and-github-for-data/
[7]:	http://blog.okfn.org/2011/03/31/building-the-open-data-ecosystem/

