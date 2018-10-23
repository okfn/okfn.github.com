---
author: Adam Kariv
title: Announcing datapackage-pipelines version 2.0
username: akariv
---
Today we’re releasing a major version for [datapackage-pipelines][dpp], version 2.0.0.

This new version marks a big step forward in realizing the Data Factory concept and framework. We integrated *datapackage-pipelines* with its younger sister *[dataflows][df-git]*, and created a set of common building blocks you can now use interchangeably between the the two frameworks.

![diagram showing the relationship between dataflows and datapackage-pipelines](/img/posts/dataflows-and-dpp.png)
<br/>
*figure 1: diagram showing the relationship between dataflows and datapackage-pipelines*

It’s now possible to bootstrap and develop flows using *dataflows*, and then run these flows as-is on a *datapackage-pipelines* server - or effortlessly convert them to the declarative yaml syntax.

Install datapackage-pipelines using `pip`:

```
pip install datapackage-pipelines
```

## What Changed?

### New Low-level API and stdout Redirect

One big change (and a long time request) is that processors are now allowed to print from inside their processing code, without interfering with the correct operation of the pipeline. All prints are automatically converted to logging.info(...) calls.This behaviour is enabled when using the new low-level API. The main change we've introduced is that ingest() is now a context manager. This means that you now should run:

```
# New style for ingest and spew
with ingest() as ctx:
 # Do stuff with datapackage and resource_iterator
 spew(ctx.datapackage,
 ctx.resource_iterator,
 ctx.stats)
 ```

Backward compatibility is maintained for the old way of using ingest(), so you don’t have to update all your code immediately.

```
# This still works, but won’t handle print()s
parameters, datapackage, resource_iterator = ingest()
spew(datapackage, resource_iterator)
```

### Dataflows integration

There’s a new integration with dataflows which allows running Flows directly from the `pipeline-spec.yaml` file.
You can integrate dataflows within pipeline specs using the `flow` attribute instead of `run`. For example, given the following flow file, saved under `my-flow.py`:
```
from dataflows import Flow, dump_to_path, load, update_package
​
def flow(parameters, datapackage, resources, stats):
  stats[‘multiplied_fields’] = 0
 ​
  def multiply(field, n):
    def step(row):
      row[field] = row[field] * n
      stats[‘multiplied_fields’] += 1
      return step
​
    return Flow(update_package(name=’my-datapackage’),
                load((datapackage, resources),
                multiply(‘my-field’, 2))
```

And a `pipeline-spec.yaml` in the same directory:
```
my-flow:
 pipeline:
   — run: load_resource
 parameters:
   url: http://example.com/my-datapackage/datapackage.json
   resource: my-resource
     — flow: my-flow
     — run: dump.to_path
```

You can run the pipeline using `dpp run my-flow`.

If you want to wrap a flow inside a processor, you can use the `spew_flow` helper function:

```
from dataflows import Flow
from datapackage_pipelines.wrapper import ingest
from datapackage_pipelines.utilities.flow_utils import spew_flow
​
def flow(parameters):
 return Flow(
 # Flow processing comes here
 )
​
​
if __name__ == ‘__main__’:
 with ingest() as ctx:
 spew_flow(flow(ctx.parameters), ctx)
 ```

### Standard Processor Refactoring
We refactored all standard processors to use their counterparts from dataflows, thus removing code duplication and allowing us to move forward quicker. As a result, we’re also introducing a couple of **new** processors:

- `load` - Loads and streams a new resource (or resources) into the data package. It's based on the dataflows processor with the same name, so it supports loading from local files, remote URL, data packages, locations in environment variables etc. For more information, consult the [dataflows documentation][df-doc].

- `printer` - Smart printing processor for displaying the contents of the stream - comes in handy for development or monitoring a pipeline.It will not print all rows, but an logarithmically sparse sample - in other words, it will print rows 1-20, 100-110, 1000-1010 etc. It also prints the last 10 rows of the dataset.

## Deprecations

We are **deprecating** a few processors — you can still use them as usual but they will be removed in the next major version (3.0):

- `add_metadata` - was renamed to `update_package` for consistency
- `add_resource` and `stream_remote_resources` - are being replaced by the `load`
- `dump.to_path`, `dump.to_zip`, `dump.to_sql` - are being deprecated - you should use `dump_to_path`, `dump_to_zip` and `dump_to_sql` instead.
Note that `dump_to_path` and `dump_to_zip` lack some features that exist in the current processors — for example, custom file formatters and non-tabular file support. We might introduce some of that functionality into the new processors as well in the next versions - *in the meantime, please let us know what you think about these features and how badly you need them*.

## The Road Ahead

In the next versions we’re planning to further the integration of dataflows and datapackage-pipelines. We’re going to work on streamlining development and deployment as well as taking care of naming and documentation to harmonize all aspects of the dataflows ecosystem.
We’re also working on de-composing datapackage-pipelines into smaller, self contained components. In this version we took apart the standard processor code and some supporting libraries (e.g. `kvstore`) and delegated it to external libraries.

## Links and References

- Read more on datapackage-pipelines here: [https://github.com/frictionlessdata/datapackage-pipelines][dpp-git]
- Read more on dataflows here: [https://github.com/datahq/dataflows][df-git]
- Read more on Data Factory here: [http://okfnlabs.org/blog/2018/08/29/data-factory-data-flows-introduction.html][df-intro]

## Contributors

Thanks to [Ori Hoch][ori-git] for contributing code and other invaluable assistance with this release.


[dpp]: https://github.com/frictionlessdata/datapackage-pipelines
[dpp-git]: https://github.com/frictionlessdata/datapackage-pipelines
[df-intro]: /blog/2018/08/29/data-factory-data-flows-introduction.html
[df-git]: https://github.com/datahq/dataflows
[df-doc]: https://github.com/datahq/dataflows/blob/master/PROCESSORS.md#load
[ori-git]: https://github.com/OriHoch
