---
author: Adam Kariv
title: Interactive Data wrangling using Data Package Pipelines new UI
username: akariv
---

*[datapackage-pipelines][dpp] is a framework for defining data processing steps to generate self-describing Data Packages, built on the concepts and tooling of the [Frictionless Data][fd] project. You can read more about datapackage-pipelines in this [introductory post][dpp-intro].*

---

Data wrangling can be quite a tedious task -
- We download a few files from a data portal or some other source.
- We use Excel or other applications to view the data.
- We select columns from all these files and copy-paste data to construct the data-set that we need.
- We filter the data so that it contains only the rows that are required.
- We use formulas to compute data for new columns, to un-pivot the data or to verify that the data 'makes sense'.

Finally, we have the wrangled data, ready to be analysed, used in our application or published in an article.

The big problem with this process is that it's not repeatable or verifiable. In many cases, the ability to show the various transformations and processes that the data underwent is crucial to establish the data's authenticity and correctness.

The common solution for this is to ditch the spreadsheet programs and bring out the power tools - the programming languages. By writing a data processing program, we are able to repeatedly run the same processing sequence on the source data and consistently receive the same results. This processing code can also be presented and reviewed as a proof of the validity of the resulting data.

However, as anyone that tinkered with programming knows - writing code is hard. Things that are simple to do using spreadsheet programs often require a complex mental effort to accomplish using custom code. Making sure that the code you've written is correct and actually produces the intended result is another major obstacle (not to mention the time it takes to learn how to program in the first place). Furthermore, even with the most readable code, it's still hard for a 3rd party reviewer to verify the validity of the process - unless they're familiar with the exact toolset and method you've used (which is often not the case).

At Open Knowledge International, we've tried to tackle this problem by finding a middle way. The `datapackage-pipelines` framework allows users to build processing pipelines - essentially, sequences of processing steps. Each of these steps is a reusable and flexible building-block which performs a single action. For example, you might use a 'Load data from source' block, a 'Select columns' block or 'Sort data' block. By combining these blocks together in a chain, one could construct powerful and simple to understand data processors.

While providing a good solution to issues like repeatability and difficult-to-understand processes, pipelines were still difficult to develop and test. Most users building the pipelines were already proficient programmers and getting the right result turned to be a tricky business.

So, we've decided to tackle this problem by creating an interactive user interface for building pipelines.

Our approach is based on a few principles:
- Modularity: each step in the pipeline should be as small and simple as possible. In case of a failure, users can tell exactly which step caused the problem. Since each step is very simple, debugging also becomes a non-issue.
- Interactivity: each decision or change the user makes is immediately reflected in the UI. If there was an error, the user can change their mind or try something else. The effects of the change are instantly visible and no long build/run/test cycles are needed.
- Server side processing: by leveraging smart caching heuristics, the server can optimize on the required processing and further improve speed and snappiness of the user interface.

In our proof-of-concept implementation, users are prompted to select a source file - either a URL for a datafile hosted anywhere, or choose a dataset from [datahub.io][datahub]. Once selected, users can choose to remove columns or rows (to position the data table and remove filler columns), add a schema (to validate data) or filter some of the rows with specific constraints.

As this is a demonstration only, the list of building blocks is still lacking - however we're planning on adding more so that this product becomes more powerful and useful.

Check out our proof-of-concept here at [http://dppui.openknowledge.io][dpp-ui]!

Feel free to ask any questions / start a discussion about this in our [Frictionless Data Gitter chat](http://gitter.im/frictionlessdata/chat). You can also find the code repositories for this work [here][dpp-ui-client] and [here][dpp-ui-server].

[fd]: http://frictionlessdata.io/
[dpp]: https://github.com/frictionlessdata/datapackage-pipelines
[dpp-intro]: http://okfnlabs.org/blog/2017/02/27/datapackage-pipelines.html
[datahub]: http://datahub.io
[dpp-ui]:http://dppui.openknowledge.io
[dpp-ui-client]: https://github.com/frictionlessdata/datapackage-pipelines-ui-client
[dpp-ui-server]: https://github.com/frictionlessdata/datapackage-pipelines-ui-server
