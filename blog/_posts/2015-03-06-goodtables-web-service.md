---
layout: post
author: Paul Walsh
username: pwalsh
title: The Good Tables web service
projects: [goodtables, goodtables-web]
---

# Introducing the Good Tables web service

<iframe width="560" height="315" src="https://www.youtube.com/embed/f1bTx6Zaotk" frameborder="0" allowfullscreen></iframe>

The Good Tables web service is an API and UI for processing tabular data, being an HTTP wrapper around [Good Tables](https://github.com/okfn/goodtables), which was [previously announced on OKFN Labs](http://okfnlabs.org/blog/2015/02/20/introducing-tabular-validator.html).

It is built by [Open Knowledge](https://okfn.org), with funding from the [Open Data User Group](https://www.gov.uk/government/groups/open-data-user-group).

The Good Tables web service is currently an alpha release; we invite the community to start using and contributing to it to help us move towards a v1.0 release.

In the current release, the Good Tables web service will validate CSV and Excel files (the first sheet therein) for well-formedness, and, if a JSON Table Schema is supplied, for conformity to the given schema.

## API

The documentation for the API can be found [here](http://goodtables.okfnlabs.org/api).

Using the API is easy: POST or GET your data, and get back a JSON object containing the report.

For example:

<pre><code>
# make a request
curl http://goodtables.okfnlabs.org/api/run --data "data=https://raw.githubusercontent.com/okfn/goodtables/master/examples/row_limit_structure.csv&schema=https://raw.githubusercontent.com/okfn/goodtables/master/examples/test_schema.json"

# the response will be like
{
    "report": {
        "summary": {
            "bad_row_count": 1,
            "total_row_count": 10,
            ...
        },
        "results": [
            {
            "result_id": "structure_001", # the ID of this result type
            "result_level": "error", # the severity of this result type (info/warning/error)
            "result_message": "Row 1 is defective: there are more cells than headers", # a message that describes the result
            "result_name": "Defective Row", # a human-readable title for this result
            "result_context": ['38', 'John', '', ''], # the row values from which this result triggered
            "row_index": 1, # the idnex of the row
            "row_name": "", # If the row has an id field, this is displayed, otherwise empty
            "column_index": 4, # the index of the column
            "column_name": "" # the name of the column (the header), if applicable
            },
            ...
        ]
    }
}
</code></pre>

For more details on the report response, see the <a href="http://goodtables.readthedocs.org/en/latest/reports.html">report section</a> of the <a href="http://goodtables.readthedocs.org/en/latest/index.html">Good Tables documentation</a>.

## UI

The web service also features a form for manual validation of data via a UI.

Let’s see it in action:

<iframe width="560" height="315" src="https://www.youtube.com/embed/f1bTx6Zaotk" frameborder="0" allowfullscreen></iframe>

<iframe width="560" height="315" src="https://www.youtube.com/embed/hblUuIjobrc" frameborder="0" allowfullscreen></iframe>

## Contributions

We invite all contributions. Feel free to [open an issue](https://github.com/okfn/goodtables-web/issues) if you encounter any problems, or just start hacking and send a pull request.
