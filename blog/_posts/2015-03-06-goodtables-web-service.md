---
author: Paul Walsh
username: pwalsh
title: The Good Tables web service
projects: [good-tables]
---

# Introducing the Good Tables web service

Good Tables is a free online service that helps you find out if your tabular data is actually good to use - it can check for structural problems (blank rows and columns) as well as ensure that data fits a specific schema.

Tabular data in CSV and Excel formats is one the most common forms of data available on the web - especially if looking at [open data](http://okfn.org/opendata/). Unfortunately, much of that data is messy with blank and incorrect rows, and unexpected values for some fields. (For example, date columns that do not feature well-formed dates. <a href="http://okfnlabs.org/bad-data/">See here for more examples of "bad data"</a>.)

That’s where Good Tables comes in: it checks your data for you, giving you quick and simple feedback on where your tabular data may not yet be quite perfect.

Good Tables uses the [previously announced](http://okfnlabs.org/blog/2015/02/20/introducing-tabular-validator.html) [Good Tables Python library](https://github.com/okfn/goodtables), and is developed by [Open Knowledge](https://okfn.org) with funding from the [Open Data User Group](https://www.gov.uk/government/groups/open-data-user-group).

Good Tables is currently an alpha release; we invite the community to start using and contributing to it to help us move towards v1.0.

<iframe width="560" height="315" src="https://www.youtube.com/embed/f1bTx6Zaotk" frameborder="0" allowfullscreen></iframe>

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
