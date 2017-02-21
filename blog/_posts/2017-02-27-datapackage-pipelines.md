---
author: Adam Kariv
title: Data Package Pipelines
username: akariv
---

*[datapackage-pipelines][dpp] is the newest part of the Frictionless
 Data toolchain.  It is a framework for defining data processing steps
 declaratively to generate self-describing Data Packages.*

[OpenSpending][os] is an open database for
uploading fiscal data for countries or municipalities to better
understand how governments spend public money.  In this project, we're
often presented with requests to upload large amounts of potentially
budget messy data---often a CSV or Excel files---to the platform.

![OpenSpending image](/img/posts/dpp-openspending.png)

We looked for existing ETL (extract, transform, load) solutions for
extracting data from these different sources, transforming them into a
format that OpenSpending supports (the
[Open Fiscal Data Package][fdp])
and loading them into the platform. A few existing and powerful
solutions exist, but none suited our needs. Most were optimised for a
use case in which you have a few different data sources, on which a
large dependency graph can be built out of complex processing nodes.
The OpenSpending use case is radically different.  Not only do we have
*many* data sources, but our processing flows are *independent*
(i.e. not an intricate dependency graph) and mostly quite *similar*
(i.e. built from the same building blocks).

We also found that typical ETL solutions were intended to be used by
data scientists and developers with processing pipelines defined in
code. While this is very convenient for coders, it is less so for the
kind of non-techies (e.g. government officials) we want to use the
platform.  Writing processing nodes in code gives developers a lot of
flexibility but also provides very few assurances about the
computational resources the code will use. This creates problems when
having to make decisions regarding deployment or concurrency.

## Pipelines for Data Packages

Based on these observations, we implemented a new ETL library,
[datapackage-pipelines][dpp] with a different set of assumptions and
use cases:

![Pipelines for something other than data](/img/posts/dpp-pipelines.jpg)

*[Pipelines](https://www.flickr.com/photos/loopkid/359144645) for
 something other than data -
 [Stefan Schmidt](https://www.flickr.com/photos/loopkid/) -
 [CC BY-NC 2.0](https://creativecommons.org/licenses/by-nc/2.0/)*

1. **Processing flows (or 'pipelines') are defined in a configuration
   file and not code.**

    This allows non-techies to write pipeline definitions, and enables
other possibilities, such as strict validation of definition files.

    Writing custom processing code is possible, but the framework
    encourages small, simple processing nodes and not processing
    behemoths. This creates better design and easier-to-understand
    pipelines.

2. **Input and output works through streaming data.**

    While this means processing nodes have limited flexibility, it
    also means they must adhere to strict use of computing
    resources. This constraint allows us to deploy processing flows
    more easily, without having to worry about a processing node
    taking too much memory or disk space.

3. **Like OpenSpending, we are based on the Data Package.**

    All pipelines process and produce valid
    [Data Packages][dp]. This
    means that metadata (both descriptive and structural) and data
    validation are built into the framework. The resulting files can
    then be seamlessly used with any [compliant tool or library][tools], which
    makes the produced data extremely portable and
    machine-processable.

## Quick Start

To start using [datapackage-pipelines][dpp], you must first create a
`pipeline-spec.yaml` file in your current directory. Here’s an
example:

```
worldbank-co2-emissions:
  pipeline:
    -
      run: add_metadata
      parameters:
        name: 'co2-emissions'
        title: 'CO2 emissions (metric tons per capita)'
        homepage: 'http://worldbank.org/'
    -
      run: add_resource
      parameters:
        name: 'global-data'
        url: "http://api.worldbank.org/v2/en/indicator/EN.ATM.CO2E.PC?downloadformat=excel"
        format: xls
        headers: 4
    -
      run: stream_remote_resources
      cache: True
    -
      run: set_types
      parameters:
         resources: global-data
         types:
           "[12][0-9]{3}":
              type: number
    -
      run: dump.to_path
      parameters:
          out-path: co2-emissions
```

Running a pipeline from the command line is done using the `dpp`
tool. Install the latest version of [datapackage-pipelines][dpp] from
PyPI (Requirements: Python 3.5 or higher):

```
$ pip install datapackage-pipelines
```

At this point, running `dpp` will show the list of available pipelines
by scanning the current directory and its subdirectories, searching
for `pipeline-spec.yaml` files.  (You can ignore the ":Skipping redis
connection, host:None, port:6379" warning for now.)

```
$ dpp
Available Pipelines:
- ./worldbank-co2-emissions (*)

```

Each pipeline has an identifier, composed of the path to the
`pipeline-spec.yaml` file and the name of the pipeline, as defined
within that description file.  In this case,the identifier is
`./worldbank-co2-emissions`.

In order to run a pipeline, you use `dpp run <pipeline-id>`.  You can
also use `dpp run all` for running all pipelines and dpp run dirty to
run the just the dirty pipelines (more on that in the
[README][readme].

```
$ dpp run ./worldbank-co2-emissions
INFO :Main:RUNNING ./worldbank-co2-emissions
INFO :Main:- lib/add_metadata.py
INFO :Main:- lib/add_resource.py
INFO :Main:- lib/stream_remote_resources.py
INFO :Main:- lib/dump/to_zip.py
INFO :Main:DONE lib/add_metadata.py
INFO :Main:DONE lib/add_resource.py
INFO :Main:stream_remote_resources: OPENING http://api.worldbank.org/v2/en/indicator/EN.ATM.CO2E.PC?downloadformat=excel
INFO :Main:stream_remote_resources: TOTAL 264 rows
INFO :Main:stream_remote_resources: Processed 264 rows
INFO :Main:DONE lib/stream_remote_resources.py
INFO :Main:dump.to_zip: INFO :Main:Processed 264 rows
INFO :Main:DONE lib/dump/to_zip.py
INFO :Main:RESULTS:
INFO :Main:SUCCESS: ./worldbank-co2-emissions
                    {'dataset-name': 'co2-emissions', 'total_row_count': 264}
```

At the end of this, you should have a new directory co2-emisonss-wb
with a `/data` directory and a `datapackage.json` file.  This is a
[Data Package][dp].

```
$ tree
.
├── co2-emissions
│   ├── data
│   │   └── EN.ATM.CO2E.csv
│   └── datapackage.json
└── pipeline-spec.yaml

2 directories, 3 files
```

So what exactly happened?  Let’s explore what a pipeline actually is,
and what it does.

## The Pipeline

The basic concept in this framework is the pipeline.  A pipeline has a
list of processing steps, and it generates a single Data Package as
its output. Each step is executed in a processor and consists of the
following stages:

- **Modify the Data Package descriptor file** (`datapackage.json`) - For
  example: add metadata, add or remove resources, change resources'
  data schema etc. For valid elements, see the
  [spec][dp].
- **Process resources** - Each row of each resource is processed
  sequentially. The processor can drop rows, add new ones, or modify
  their contents.
- **Return stats** - If necessary, the processor can report a
  dictionary of data which will be returned to the user when the
  pipeline execution terminates. This can be used, for example, for
  calculating quality measures for the processed data.

Not every processor needs to do all of these. In fact, you would often
find each processing step doing only one of these.


### pipeline-spec.yaml file

Pipelines are defined in a declarative way, and not in code. One or
more pipelines can be defined in a `pipeline-spec.yaml` file. This
file specifies the list of processors (referenced by name) and the
execution parameters for each of the processors.

In the above example we see one pipeline called
`worldbank-co2-emissions`. Its pipeline consists of 4 steps:

- `metadata`: This processor (see the [repo][stdlib] for more), which
  modifies the Data Package's descriptor (in our case: the initial,
  empty descriptor) - adding name, title, and other properties to the
  `datapackage.json`.
- `add_resource`: This processor adds a single resource to the Data
  Package. This resource has a `name` and a `url`, pointing to the
  remote location of the data.
- `stream_remote_resources`: This processor converts remote resources
  (like the one we defined in the 1st step) to local resources,
  streaming the data to processors further down the pipeline (see
  "Mechanics" below).
- `set_types`: This processor assigns data types to fields in the
  data. In this example, field headers looking like years will be
  assigned the number type.
- `dump.to_path`: Create a validated Data Package in the provided path
  `co2-emissions-wb`

### Mechanics

An important aspect of how the pipelines are run is the fact that data
is passed in streams from one processor to another. Each processor is
run in its own dedicated process, where the Data Package is read from
its STDIN and output to its STDOUT. No processor holds the entire data
set at any point.

## Dirty tasks and keeping state

As you modify and re-run your pipeline, you can also avoid
unnecessarily repeating steps.  By setting the `cached:` property on a
specific pipeline step to `True`, this step's output will be stored on
disk (in the `.cache` directory, in the same location as the
`pipeline-spec.yaml` file).  Re-running the pipeline will make use of
that cache, thus avoiding the execution of the cached step and its
precursors.

The cache hash is also used for seeing if a pipeline is "dirty". When
a pipeline completes executing successfully, `dpp` stores the cache
hash along with the pipeline id. If the stored hash is different than
the currently calculated hash, it means that either the code or the
execution parameters were modified, and that the pipeline needs to be
re-run.

## Validating

- The Data Package metadata is always validated before being passed to
  a processor, so there's no possibility for a processor to modify a
  Data Package in a way that renders it invalid.
- The data itself is not validated against its respective Table
  Schema, unless explicitly requested by setting the `validate` flag
  to `True` in the step's properties. This is done for two main
  reasons:
    - Performance: validating the data in every step is very CPU-intensive
    - In some cases, you modify the schema in one step and the data in
      another, so you would only like to validate the data once all
      the changes were made
- In any case, all the `dump.to_*` (`dump.to_path`, `dump.to_sql`,
  `dump.to_zip`) standard processors validate their input data
  regardless of the `validate` flag - so in case you're using them,
  your data validity is covered 👍🏽.

## Try it out

This all adds up to highly modular, configurable, and
resource-considerate framework for processing and packaging tabular
data.  Once you have created a Data Package, you can publish it
anywhere on the web, comfortable in the knowledge that its embedded
metadata will make it much easier to document and use. Developers can
process Data Packages using our [Python][guide-py] and
[JavaScript][repo-js] libraries.  Data analysts can use the
[R library for Data Packages][blog-r] or our
[Python Pandas][blog-pandas] library to load the data.

For more information about [datapackage-pipelines][dpp], included
running pipelines on a schedule, using the dashboard, configuring the
standard processors, and information on how to write your own
processor, visit the [GitHub repo][dpp].

[dpp]: https://github.com/frictionlessdata/datapackage-pipelines
[fdp]: http://specs.frictionlessdata.io/fiscal-data-package
[os]: http://next.openspending.org/
[tools]: http://frictionlessdata.io/tools/
[stdlib]: https://github.com/frictionlessdata/datapackage-pipelines#the-standard-processor-library
[dp]: http://specs.frictionlessdata.io/data-package
[readme]: https://github.com/frictionlessdata/datapackage-pipelines/blob/master/README.md
[blog-r]: http://okfnlabs.org/blog/2016/07/14/using-data-packages-with-r.html
[blog-pandas]: http://okfnlabs.org/blog/2016/08/01/using-data-packages-with-pandas.html
[guide-py]: http://frictionlessdata.io/guides/using-data-packages-in-python/
[repo-js]: https://github.com/frictionlessdata/datapackage-js
