---
layout: project
title: Good Tables
slug: goodtables
permalink: /projects/goodtables/index.html
type: [library, service]
author: Paul Walsh
maintainers: [pwalsh]
contributors: [pwalsh]
helpwanted: yes
typeofhelp: [coding, testing]
featured: yes
github_user: okfn
github_repo: goodtables-web
imageurl: /img/projects/project-goodtables.png
language: [python, javascript, html, css]
projecturl: http://goodtables.okfnlabs.org/
stage: alpha
tags: [Tabular Data, CSV, JSON Table Schema]
tagline: Validate and process tabular data.
status: [active]
---

The Good Tables web service provides an API and UI for processing and validating tabular data,
providing an http layer around the <a href="https://github.com/okfn/goodtables">Good Tables Python library</a>.

Currently, this means data can be provided in CSV or Excel format, and the file will
be validated for well-formedness (for example, no empty rows or columns, no duplicate
rows, all rows have valid dimensions, and so on), and conformance to a schema
(if a <a href="http://dataprotocols.org/json-table-schema/">JSON Table Schema</a> is supplied).

<a href="http://okfnlabs.org/blog/2015/03/06/goodtables-web-service.html">Read more in the Open Knowledge Labs announcement</a>.
