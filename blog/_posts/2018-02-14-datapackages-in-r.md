---
author: Open Knowledge Greece
username: okgreece
title: Creating and Using Data Packages in R
---
[Open Knowledge Greece][okgreece] was one of 2017's [Frictionless Data Tool Fund][toolfund] grantees tasked with extending implementation of core Frictionless Data libraries in R programming language. You can read more about this in [their grantee profile][toolfund-okgreece].

 In this post, [Kleanthis Koupidis](https://twitter.com/Kleanthis_k10), a Data Scientist and Statistician at Open Knowledge Greece, explains how to [create](#creating-data-packages-in-r) and [use](#using-data-packages-in-r) Data Packages in R.

 ----

Creating Data Packages in R
===========================

This section of the tutorial will show you how to install the R library for working with Data Packages and Table Schema, load a CSV file, infer its schema, and write a Tabular Data Package.

Setup
-----

For this tutorial, we will need the Data Package R library ([datapackage.r][dp-r]).

[devtools library][r-devtools] is required to install the `datapackage.r` library from github.

```
    # Install devtools package if not already
    install.packages("devtools")
```

And then install the development version of [datapackage.r][dp-r] from github.

```
    devtools::install_github("frictionlessdata/datapackage.r")
```

Load
----

You can start using the library by loading `datapackage.r`.

{% highlight r %}
    library(datapackage.r)
{% endhighlight %}   

You can add useful metadata by adding keys to metadata dict attribute. Below, we are adding the required `name` key as well as a human-readable `title` key. For the keys supported, please consult the full [Data Package spec][dp]. Note, we will be creating the required `resources` key further down below.

{% highlight r %}
    dataPackage = Package.load()
    dataPackage$descriptor['name'] = 'period-table'
    dataPackage$descriptor['title'] = 'Periodic Table'
    # commit the changes to Package class
    dataPackage$commit()

    ## [1] TRUE
{% endhighlight %}  

Infer a CSV Schema
------------------

We will use periodic-table data from [remote path](<https://raw.githubusercontent.com/okgreece/datapackage-r/master/vignettes/example%20data/data.csv>)

| atomic.number | symbol | name      | atomic.mass | metal.or.nonmetal.   |
|---------------|--------|-----------|-------------|----------------------|
| 1             | H      | Hydrogen  | 1.00794     | nonmetal             |
| 2             | He     | Helium    | 4.002602    | noble gas            |
| 3             | Li     | Lithium   | 6.941       | alkali metal         |
| 4             | Be     | Beryllium | 9.012182    | alkaline earth metal |
| 5             | B      | Boron     | 10.811      | metalloid            |
| 6             | C      | Carbon    | 12.0107     | nonmetal             |
| 7             | N      | Nitrogen  | 14.0067     | nonmetal             |
| 8             | O      | Oxygen    | 15.9994     | nonmetal             |
| 9             | F      | Fluorine  | 18.9984032  | halogen              |
| 10            | Ne     | Neon      | 20.1797     | noble gas            |
{: .table .table-striped .table-bordered style="display: table; overflow:auto"}

We can guess at our CSV's [schema][ts] by using `infer` from the Table Schema library. We pass directly the remote link to the infer function, the result of which is an inferred schema. For example, if the processor detects only integers in a given column, it will assign `integer` as a column type.

{% highlight r %}
    filepath = 'https://raw.githubusercontent.com/okgreece/datapackage-r/master/vignettes/example_data/data.csv'

    schema = tableschema.r::infer(filepath)
{% endhighlight %}

Once we have a schema, we are now ready to add a `resource` key to the Data Package which points to the resource path and its newly created schema. Below we define resources with three ways, using json text format with usual assignment operator in R list objects and directly using `addResource` function of `Package` class:

{% highlight r %}
    # define resources using json text
    resources = helpers.from.json.to.list(
      '[{
        "name": "data",
        "path": "filepath",
        "schema": "schema"
      }]'
    )
    resources[[1]]$schema = schema
    resources[[1]]$path = filepath

    # or define resources using list object
    resources = list(list(
      name = "data",
      path = filepath,
      schema = schema
      ))
{% endhighlight %}     

And now, add resources to the Data Package:

{% highlight r %}
    dataPackage$descriptor[['resources']] = resources
    dataPackage$commit()

    ## [1] TRUE
{% endhighlight %}

Or you can directly add resources using `addResources` function of `Package` class:

{% highlight r %}
    resources = list(list(
      name = "data",
      path = filepath,
      schema = schema
      ))      

    dataPackage$addResource(resources)
{% endhighlight %}

Now we are ready to write our `datapackage.json` file to the current working directory.

{% highlight r %}
    dataPackage$save('example_data')
{% endhighlight %}

The `datapackage.json` ([download](https://raw.githubusercontent.com/okgreece/datapackage-r/master/vignettes/example_data/package.json)) is inlined below. Note that atomic number has been correctly inferred as an `integer` and atomic mass as a `number` (float) while every other column is a `string`.

{% highlight r %}
    jsonlite::prettify(helpers.from.list.to.json(dataPackage$descriptor))

    ## {
    ##     "profile": "data-package",
    ##     "name": "period-table",
    ##     "title": "Periodic Table",
    ##     "resources": [
    ##         {
    ##             "name": "data",
    ##             "path": "https://raw.githubusercontent.com/okgreece/datapackage-r/master/vignettes/example_data/data.csv",
    ##             "schema": {
    ##                 "fields": [
    ##                     {
    ##                         "name": "atomic number",
    ##                         "type": "integer",
    ##                         "format": "default"
    ##                     },
    ##                     {
    ##                         "name": "symbol",
    ##                         "type": "string",
    ##                         "format": "default"
    ##                     },
    ##                     {
    ##                         "name": "name",
    ##                         "type": "string",
    ##                         "format": "default"
    ##                     },
    ##                     {
    ##                         "name": "atomic mass",
    ##                         "type": "number",
    ##                         "format": "default"
    ##                     },
    ##                     {
    ##                         "name": "metal or nonmetal?",
    ##                         "type": "string",
    ##                         "format": "default"
    ##                     }
    ##                 ],
    ##                 "missingValues": [
    ##                     ""
    ##                 ]
    ##             },
    ##             "profile": "data-resource",
    ##             "encoding": "utf-8"
    ##         }
    ##     ]
    ## }
    ##
{% endhighlight %}    

Publishing
----------

Now that you have created your Data Package, you might want to [publish your data online](https://frictionlessdata.io/guides/publish-online/) so that you can share it with others.

----

Using Data Packages in R
========================

This section of the tutorial will show you how to install the R libraries for working with Tabular Data Packages and demonstrate a very simple example of loading a Tabular Data Package from the web and pushing it directly into a local SQL database and send query to retrieve results.

Setup
-----

For this tutorial, we will need the Data Package R library ([datapackage.r][dp-r]). [Devtools library](https://cran.r-project.org/package=devtools) is also required to install the datapackage.r library from github.

    # Install devtools package if not already
    install.packages("devtools")

And then install the development version of [datapackage.r][dp-r] from github.

    devtools::install_github("frictionlessdata/datapackage.r")

Load
----

You can start using the library by loading `datapackage.r`.

{% highlight r %}
    library(datapackage.r)
{% endhighlight %}

Reading Basic Metadata
----------------------

In this case, we are using an example Tabular Data Package containing the periodic table stored on [GitHub](https://github.com/frictionlessdata/example-data-packages/tree/master/periodic-table) ([datapackage.json](https://raw.githubusercontent.com/frictionlessdata/example-data-packages/master/periodic-table/datapackage.json), [data.csv](https://raw.githubusercontent.com/frictionlessdata/example-data-packages/master/periodic-table/data.csv)). This dataset includes the atomic number, symbol, element name, atomic mass, and the metallicity of the element. Here are the first five rows:

{% highlight r %}
    url = 'https://raw.githubusercontent.com/okgreece/datapackage-r/master/vignettes/example_data/data.csv'
    pt_data = read.csv2(url, sep = ',')
    knitr::kable(head(pt_data, 5), align = 'c')
{% endhighlight %}

| atomic.number | symbol | name      | atomic.mass | metal.or.nonmetal.   |
|---------------|--------|-----------|-------------|----------------------|
| 1             | H      | Hydrogen  | 1.00794     | nonmetal             |
| 2             | He     | Helium    | 4.002602    | noble gas            |
| 3             | Li     | Lithium   | 6.941       | alkali metal         |
| 4             | Be     | Beryllium | 9.012182    | alkaline earth metal |
| 5             | B      | Boron     | 10.811      | metalloid            |
{: .table .table-striped .table-bordered style="display: table; overflow:auto"}

Data Packages can be loaded either from a local path or directly from the web.

{% highlight r %}
    url = 'https://raw.githubusercontent.com/okgreece/datapackage-r/master/vignettes/example_data/package.json'
    datapackage = Package.load(url)
    datapackage$resources[[1]]$descriptor$profile = 'tabular-data-resource' # tabular resource descriptor profile
    datapackage$resources[[1]]$commit() # commit changes

    ## [1] TRUE
{% endhighlight %}

At the most basic level, Data Packages provide a standardized format for general metadata (for example, the dataset title, source, author, and/or description) about your dataset. Now that you have loaded this Data Package, you have access to this `metadata` using the metadata dict attribute. Note that these fields are optional and may not be specified for all Data Packages. For more information on which fields are supported, see [the full Data Package standard][dp]].

{% highlight r %}
    datapackage$descriptor$title

    ## [1] "Periodic Table"
{% endhighlight %}

Reading Data
------------

Now that you have loaded your Data Package, you can read its data. A Data Package can contain multiple files which are accessible via the `resources` attribute. The `resources` attribute is an array of objects containing information (e.g. path, schema, description) about each file in the package.

You can access the data in a given resource in the `resources` array by reading the `data` attribute.

{% highlight r %}
    table = datapackage$resources[[1]]$table
    periodic_table_data = table$read()
{% endhighlight %}

You can further manipulate list objects in R by using

{% highlight r %}
 [purrr](https://cran.r-project.org/package=purrr), [rlist](https://cran.r-project.org/package=rlist) packages.
{% endhighlight %}

Loading into an SQL database
----------------------------

[Tabular Data Packages][tdp] contains schema information about its data using [Table Schema][ts]. This means you can easily import your Data Package into the SQL backend of your choice. In this case, we are creating an [SQLite](http://sqlite.org/) database.

To create a new SQLite database and load the data into SQL we will need [DBI](https://cran.r-project.org/package=DBI) package and [RSQLite](https://cran.r-project.org/package=RSQLite) package, which contains [SQLite](https://www.sqlite.org/) (no external software is needed).

You can install and load them by using:

{% highlight r %}
    install.packages(c("DBI","RSQLite"))

    library(DBI)
    library(RSQLite)
{% endhighlight %}   

To create a new SQLite database, you simply supply the filename to `dbConnect()`:

{% highlight r %}
    dp.database = dbConnect(RSQLite::SQLite(), "") # temporary database
{% endhighlight %}

We will use [data.table](https://cran.r-project.org/package=RSQLite) package to convert the list object with the data to a data frame object to copy them to database table.

{% highlight r %}
    # install data.table package if not already
    # install.packages("data.table")

    periodic_table_sql = data.table::rbindlist(periodic_table_data)
    periodic_table_sql = setNames(periodic_table_sql,unlist(datapackage$resources[[1]]$headers))
{% endhighlight %}  

You can easily copy an R data frame into a SQLite database with `dbWriteTable()`:

{% highlight r %}
    dbWriteTable(dp.database, "periodic_table_sql", periodic_table_sql)
    # show remote tables accessible through this connection
    dbListTables(dp.database)

    ## [1] "periodic_table_sql"
{% endhighlight %}

The data are already to the database.

We can further issue queries to hte database and return first 5 elements:

{% highlight r %}

    dbGetQuery(dp.database, 'SELECT * FROM periodic_table_sql LIMIT 5')

    ##   atomic number symbol      name atomic mass   metal or nonmetal?
    ## 1             1      H  Hydrogen    1.007940             nonmetal
    ## 2             2     He    Helium    4.002602            noble gas
    ## 3             3     Li   Lithium    6.941000         alkali metal
    ## 4             4     Be Beryllium    9.012182 alkaline earth metal
    ## 5             5      B     Boron   10.811000            metalloid
{% endhighlight %}

Or return all elements with an atomic number of less than 10:

{% highlight r %}
    dbGetQuery(dp.database, 'SELECT * FROM periodic_table_sql WHERE "atomic number" < 10')

    ##   atomic number symbol      name atomic mass   metal or nonmetal?
    ## 1             1      H  Hydrogen    1.007940             nonmetal
    ## 2             2     He    Helium    4.002602            noble gas
    ## 3             3     Li   Lithium    6.941000         alkali metal
    ## 4             4     Be Beryllium    9.012182 alkaline earth metal
    ## 5             5      B     Boron   10.811000            metalloid
    ## 6             6      C    Carbon   12.010700             nonmetal
    ## 7             7      N  Nitrogen   14.006700             nonmetal
    ## 8             8      O    Oxygen   15.999400             nonmetal
    ## 9             9      F  Fluorine   18.998403              halogen
{% endhighlight %}

More about using databases, SQLite in R you can find in vignettes of [DBI](https://cran.r-project.org/package=DBI) and [RSQLite](https://cran.r-project.org/package=RSQLite) packages.

We welcome your feedback and questions via our [Frictionless Data Gitter chat][fd-gitter] or via [Github issues][dp-r-issues] on the datapackage-r repository.

[dp]: https://frictionlessdata.io/specs/data-package/
[tdp]: https://frictionlessdata.io/specs/tabular-data-package/
[okgreece]: http://okfn.gr/
[toolfund]: https://toolfund.frictionlessdata.io
[toolfund-okgreece]:https://frictionlessdata.io/articles/open-knowledge-greece/
[dp-r]: https://github.com/frictionlessdata/datapackage-r
[ts]:https://frictionlessdata.io/guides/table-schema/
[r-devtools]: https://cran.r-project.org/package=devtools
[fd-gitter]: http://gitter.im/frictionlessdata/chat
[dp-r-issues]: https://github.com/frictionlessdata/datapackage-r/issues
