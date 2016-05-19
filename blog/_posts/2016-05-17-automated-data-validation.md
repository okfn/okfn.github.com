---
title: Automated Data Validation with Data Packages
author: Dan Fowler
username: dfowler
projects: [dpm,frictionless-data,mira,goodtables-web]
---

Software projects have long benefited from
[Continuous Integration](https://en.wikipedia.org/wiki/Continuous_integration)
services like [Travis CI](http://travis-ci.org/),
[Jenkins](https://jenkins.io), and others for ensuring and maintaining
code quality over time.  On each commit into a project's shared
repository, these services facilitate the automatic execution of tests
and the generation of reports allowing developers to find and resolve
errors quickly and reliably.  These services are especially useful as
the size and complexity of the codebase and development team
increases.  As a side benefit, they often provide a "badge" to show
the current status of the project's most recent build at a glance.

![Build Passing](/img/posts/build-passing.png)

As with software, datasets are often collaboratively created, edited,
and updated over time, sometimes introducing subtle (or not so subtle)
structural and schematic errors (see
[Bad Data](http://okfnlabs.org/bad-data/) for examples).  Much of the
"friction" in working with data comes from the time and effort needed
to identify and address these errors before analyzing in a given tool.
Automatically flagging *data* quality issues at upload time in a
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

As an example, this CSV is "bad".

```
Date,Country,Number
2015-01-01,3,20.3
2015-02-01,United States,23.5
2015-02,United States,x23.5
```

When we packaged it (see its
[datapackage.json](https://github.com/frictionlessdata/ex-continuous-data-integration/blob/master/datapackage.json)),
we gave it the following JSON Table Schema.

{% highlight json %}
{
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
{% endhighlight %}

On commit, this data would result in the following report:

```
+----------------+-------------------------------------------------------------+
| result_name    | result_message                                              |
+================+=============================================================+
| Incorrect Type | The value "2015-02" in column "Date" is not a valid Date.   |
+----------------+-------------------------------------------------------------+
| Incorrect Type | The value "x23.5" in column "Number" is not a valid Number. |
+----------------+-------------------------------------------------------------+
```

## How It Works

The Data Package descriptor file,
[datapackage.json](http://dataprotocols.org/data-packages/), provides
both high-level metadata as well as a
[schema](http://frictionlessdata.io/guides/json-table-schema/) for
tabular data.  The Python libary
[datapackage-py](http://github.com/frictionlessdata/datapackage-py)
provides a high-level model of the Data Package that allows us to
inspect and work with the data inside.  We call out to the
[GoodTables API](http://goodtables.okfnlabs.org/api) service
([previously blogged about on this channel](http://okfnlabs.org/blog/2015/03/06/goodtables-web-service.html))
to validate our tabular data.  Given that our example relies on
[GitHub as a data storage mechanism](http://blog.okfn.org/2013/07/02/git-and-github-for-data/),
[Travis CI](http://travis-ci.org/) served as a convenient host to test
out this idea, but this approach is broadly applicable to any storage
backend with some extra tweaking (e.g. using AWS
[Lambda](https://aws.amazon.com/lambda/) and
[S3](https://aws.amazon.com/s3/)).


On every update, two small test functions read the `datapackage.json`
to read and validate the tabular data contained therein according to
its structure and adherence to a
[schema](http://frictionlessdata.io/guides/json-table-schema/).
Structural errors include whether the CSV is malformed in some way
(e.g. missing headers, blank rows, etc.) while schema errors refer to
data that is invalid with respect to its defined JSON Table Schema
(e.g. a column may be defined to be an `integer` but the validator
found a string).  Behind the scenes, this is just a normal Travis CI
configuration (see the
[.travis.yml](https://github.com/frictionlessdata/ex-continuous-data-integration/blob/master/.travis.yml)).

## Try It Yourself

Check out the
[ex-continuous-data-integration](https://github.com/frictionlessdata/ex-continuous-data-integration)
repository on our
[frictionlessdata](https://github.com/frictionlessdata) organization
on GitHub to see how you can try this out with your own data!  Let us
know how it works on our [chat channel](/contact/).  Happy Data
Validation!
