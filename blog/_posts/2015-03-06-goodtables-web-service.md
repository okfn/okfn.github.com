---
layout: post
author: Paul Walsh
username: pwalsh
title: The Good Tables web service

---

# Introducing the Good Tables web service

The Good Tables web service is an API and UI for processing tabular data, being an HTTP wrapper around [Good Tables](https://github.com/okfn/goodtables), which was [previously announced on OKFN Labs](http://okfnlabs.org/blog/2015/02/20/introducing-tabular-validator.html).

It is built by [Open Knowledge](https://okfn.org), with funding from the [Open Data User Group](https://www.gov.uk/government/groups/open-data-user-group).

The Good Tables web service is currently an alpha release; we invite the community to start using and contributing to it to help us move towards a v1.0 release.

In the current release, the Good Tables web service will validate CSV and Excel files (the first sheet therein) for well-formedness, and, if a JSON Table Schema is supplied, for conformity to the given schema.

## API

The documentation for the API can be found [here](http://goodtables.okfnlabs.org/api).

Let’s see it in action:

![CURL Data](https://dl.dropboxusercontent.com/u/13029373/okfn/curl_data.gif)

![CURL Data and Schema](https://dl.dropboxusercontent.com/u/13029373/okfn/curl_data_schema.gif)

## UI

Data can be validated via a simple form:

![Good Tables Form](https://dl.dropboxusercontent.com/u/13029373/okfn/ui.png)

Let’s see it in action:

![Form flow](https://dl.dropboxusercontent.com/u/13029373/okfn/ui.gif)

## Contributions

We invite all contributions. Feel free to [open an issue](https://github.com/okfn/goodtables-web/issues) if you encounter any problems, or just start hacking and send a pull request.
