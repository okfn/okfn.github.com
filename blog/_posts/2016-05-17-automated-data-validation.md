---
title: Automated Data Validation with Data Packages
author: Dan Fowler
username: dfowler
projects: [dpm,frictionless-data,mira,goodtables-web]
---

Much of the open data on the web is published in CSV or Excel format.
Unfortunately, it is often messy and can require significant
manipulation to actually be usable.  In this post, I walk through a
workflow for automating data validation on every update to a shared
repository inspired by existing practices in software development and
enabled by *Frictionless Data* standards and tooling.

Software projects have long benefited from Continuous Integration
services like Travis CI and others for ensuring and maintaining
**code** quality.  Continuous integration is a process where all tests
are automatically run and a report is generated on every update
("commit") to a project's shared repository. This allows developers to
find and resolve errors quickly and reliably.  In addition, by
displaying the "build status" others outside of the project can
clearly see the status of the project test compliance.

![Build Passing](/img/posts/build-passing.png)

As with software, datasets are often collaboratively created, edited,
and updated over time, sometimes introducing subtle (or not so subtle)
structural and schematic errors (see
[Bad Data](http://okfnlabs.org/bad-data/) for examples).  Much of the
"friction" in using the data comes from the time and effort needed to
identify and address these errors before analyzing in a given tool.
Automatically flagging **data** quality issues at upload time in a
repository can go a long way in making data more useful and have
significant follow-on effects in the data ecosystem, both open and
closed.

## Continuous Data Integration

As the [Frictionless Data](http://frictionlessdata.io/) tooling and
standards ecosystem continues to grow, we now have the elements
necessary to provide data managers with the same type of service for
tabular data (e.g. Excel and CSV).  In less than one hour, a few of us
at Open Knowledge booted a small demo to show what *continuous data
integration* could look like.  On each commit to
[our example repository](https://github.com/frictionlessdata/ex-continuous-data-integration),
a set of validation tests are run on the data, raising an exception if
the data is invalid.  If a user adds "bad" data, the "build" fails and
issues a report indicating what went wrong.

[![Data CI](/img/posts/data_ci_travis.png)](https://github.com/frictionlessdata/ex-continuous-data-integration)

As an example, the following CSV has a few issues with its values.  In
the schema we define in the `datapackage.json` file below (i.e. the
object that the `schema` points to), we defined the "Number" column
type to `number` and the Date column type to `date`.  However, the CSV
contains invalid values for those types: "x23.5" and "2015-02"
respectively.

### CSV

    Date,Country,Number
    2015-01-01,3,20.3
    2015-02-01,United States,23.5
    2015-02,United States,x23.5

### datapackage.json

{% highlight json %}
{
  "name": "fd-continuous-data-integration",
  "title": "",
  "resources": [
    {
      "name": "data",
      "path": "data/data.csv",
      "format": "csv",
      "mediatype": "text/csv",
      "schema": {
        "fields": [
          {
            "name": "Date",
            "type": "date",
            "description": ""
          },
          {
            "name": "Country",
            "type": "string",
            "description": ""
          },
          {
            "name": "Number",
            "type": "number",
            "description": ""
          }
        ]
      }
    }
  ]
}
{% endhighlight %}

When we try to add this invalid data to the repository, the following
report is generated:


    +----------------+------------------------------------------------------------+
    | result_name    | result_message                                             |
    +================+============================================================+
    | Incorrect Type | The value "2015-02" in column "Date" is not a valid Date.  |
    +----------------+------------------------------------------------------------+
    | Incorrect Type | The value "x23.5" in column "Number" is not a valid Number.|
    +----------------+------------------------------------------------------------+


## How It Works

The Data Package descriptor file,
[datapackage.json](http://dataprotocols.org/data-packages/), provides
both high-level metadata as well as a
[schema](http://frictionlessdata.io/guides/table-schema/) for
tabular data.  We use the Python library
[datapackage-py](http://github.com/frictionlessdata/datapackage-py) to
create a high-level model of the Data Package that allows us to
inspect and work with the data inside.  The real work is accomplished using
[GoodTables](http://goodtables.okfnlabs.org/).


We
[previously blogged about using Good Tables](http://okfnlabs.org/blog/2015/03/06/goodtables-web-service.html)
to validate our tabular data.  On every update, two small test
functions read the `datapackage.json` to read and validate the tabular
data contained therein according to its structure and adherence to a
[schema](http://frictionlessdata.io/guides/table-schema/).
Here's the first:

{% highlight python %}
def test_schema(self):
    # We heart CSV :)

    data_format = 'csv'

    # Load our Data Package path and schema

    data = dp.metadata['resources'][0]['path']
    schema = dp.metadata['resources'][0]['schema']

    # We use the "schema" processor to test the data against its
    # expected schema.  There is also a "structure" processor.

    processor = processors.SchemaProcessor(schema=schema,
        format=data_format,
        row_limit=row_limit,
        report_limit=report_limit)
    valid, report, data = processor.run(data)

    # Various formatting options for our report follow.  

    output_format = 'txt'
    exclude = ['result_context', 'processor', 'row_name',
               'result_category', 'column_name', 'result_id',
               'result_level']

    # And here's our report!

    out = report.generate(output_format, exclude=exclude)

    self.assertTrue(valid, out)
{% endhighlight %}

For more information, read the guide on
[frictionlessdata.io](http://frictionlessdata.io/) about
[validating data](http://frictionlessdata.io/guides/validating-data/).
Behind the scenes, this is just a normal Travis CI configuration (see
the
[.travis.yml](https://github.com/frictionlessdata/ex-continuous-data-integration/blob/master/.travis.yml)).

## Try It Yourself

Our example relies on
[GitHub as a data storage mechanism](http://blog.okfn.org/2013/07/02/git-and-github-for-data/)
and [Travis CI](http://travis-ci.org/) as a host for the actual
validation.  However, this approach is broadly applicable to any
storage and processing backend with some extra tweaking (e.g. using
AWS [Lambda](https://aws.amazon.com/lambda/) and
[S3](https://aws.amazon.com/s3/)).

Check out the
[ex-continuous-data-integration](https://github.com/frictionlessdata/ex-continuous-data-integration)
repository on our
[frictionlessdata](https://github.com/frictionlessdata) organization
on GitHub to see how you can try this out with your own data!  Let us
know how it works on our [chat channel](/contact/).  
