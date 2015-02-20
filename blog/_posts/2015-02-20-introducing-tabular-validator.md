---
layout: post
author: Paul Walsh
username: pwalsh
title: Introducing Tabular Validator
---

## What is it?

[Tabular Validator](https://github.com/okfn/tabular-validator) is a Python package for validating tabular data through a processing pipeline.

It is built by [Open Knowledge](https://okfn.org), with funding from the [Open Data User Group](https://www.gov.uk/government/groups/open-data-user-group). Tabular Validator is currently an *alpha release*.

Applications range from simple validation checks on CSV files, to integration with a larger ETL pipeline.

The codebase currently ships with two validators that can be used in a pipeline:

The [StructureValidator](https://github.com/okfn/tabular-validator/blob/master/tabular_validator/validators/structure.py) checks for common structural errors
The [SchemaValidator](https://github.com/okfn/tabular-validator/blob/master/tabular_validator/validators/schema.py) checks for conformance to a JSON Table Schema

There is a hook to add custom validators, and there are plans to include more validators in the core library.

Tabular Validator ships with [some documentation](http://tabular-validator.readthedocs.org/en/latest/), but it is not yet complete. You are welcome to [check out the code](https://github.com/okfn/tabular-validator), [run the tests](https://github.com/okfn/tabular-validator/blob/master/test.sh) (or [check them on Travis](https://travis-ci.org/okfn/tabular-validator)), [open an issue](https://github.com/okfn/tabular-validator/issues), or make a pull request to help us iterate to a version one release ([here is the backlog](https://github.com/okfn/tabular-validator/milestones/Backlog)).

We are also released some packages that are used in Tabular Validator: [TVWeb](https://github.com/okfn/tabular-validator-web), [JTSKit](https://github.com/okfn/jtskit-py), and [TellMe](https://github.com/okfn/tellme). You can read more about each of these below.

## Why?

The development of Tabular Validator has been driven by a real-world pain point: monitoring and validating government spending data in the United Kingdom (the dashboard for this project is under development [here](https://github.com/okfn/spend-publishing-dashboard)). A brief overview of this use case can demonstrate the value proposition of Tabular Validator.

### The Problem

In the UK, various government departments publish spend data. This data is required to be accessible: that is, machine-readable and publicly available. Additionally, the data must conform to schema.

Monitoring the publication of such data, and validating its well-formedness, is a difficult task. The data is produced in a variety of circumstances (e.g.: available resources), and the producers of this data have no tools at hand to confirm that their work is correct.

Considering that spend data is produced at regular periodic intervals, and departments are expected to publish in a timely manner, the problem of producing well-formed data is compounded.

### The Solution

Tabular Validator provides part of the solution with tooling to ensure data is machine readable and well formed. All spend data across the various government departments is collected and run through a Tabular Validator pipeline at regular intervals.

The validation pipeline for this data is something like as follows:

* Is the file readable as CSV?
* Are there headers from the first line of the file?
* Are there any empty headers, empty rows, or ragged rows?
* Do all the values in the file conform with the expected schema (columns of numbers, dates, etc.)?

Any errors detected while the pipeline is running are written in to a report. When the pipeline finishes running, a user-facing report is generated, providing actionable data on what exactly is wrong with the file (so the data producers can take steps to fix such errors).

## How can I use it now?

If you are running Python 2.7, 3.3 or 3.4, you can start using Tabular Validator today.

As mentioned above, this is an *alpha release*. Still, we have decent test coverage, and we are hoping to uncover bugs and weirdness through wider usage.

Here’s how you can use Tabular Validator right now:

### In existing code bases
See some examples in the [test suite](https://github.com/okfn/tabular-validator/tree/master/tests) to get a working idea of the API and how you could integrate a Tabular Validator pipeline, or stand-alone validator, into your existing workflow with tabular data.

### As a CLI
If you are doing data wrangling in the terminal, Tabular Validator comes with a CLI called “tv”. See [here](https://github.com/okfn/tabular-validator/blob/master/tabular_validator/cli/main.py) for the CLI interface,. This is still very much a work in progress, and currently exposes a subset of the Tabular Validator pipeline interface.

### Via the web
The [tvweb](https://github.com/okfn/tabular-validator-web) package provides both a Web API and a simple form UI over Tabular Validator. Read about the current API [here](https://github.com/okfn/tabular-validator-web/blob/master/README.md).

## Extra goodies

Tabular Validator has been developed as part of a larger project, and we are pulling out functionality out into standalone packages as possible/practical.

Like the Tabular Validator package, these are all *alpha releases*, but each has a passing test suite on Python 2.7, 3.3, and 3.4.

### TellMe

[TellMe](https://github.com/okfn/tellme) is a Python package for creating user-facing reports from things happening in code. It is a simple library that provides a logger-like interface to build reports, and then generate them in several output formats.

### JTSKit

[JTSKit](https://github.com/okfn/jtskit-py) is a Python package providing a set of utilities for working with JSON Table Schema.

## TVWeb

[TVWeb](https://github.com/okfn/tabular-validator-web) is a flask application that provides a Web API over Tabular Validator, as well as a simple form UI.
