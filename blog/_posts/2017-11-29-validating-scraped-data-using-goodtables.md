---
title: Validating scraped data using goodtables
date: 2017-11-29
author: Vitor Baptista
username: vitorbaptista
projects: [frictionless-data,good-tables]
---

We have to deal with many challenges when scraping a page. What's the page's layout? How do I extract the bits of data I want? How do I know when their layout changes and break my code? How can I be sure that my code isn't introducing errors to the data? There are many tools to test that the code works, but not so many to test the actual data. This is especially important when you don't control the source of the data, which is almost always the case when you're scraping (otherwise, you wouldn't be scraping). In this post, I'll show you how I used [goodtables][goodtables] to validate scraped data.

[Goodtables][goodtables] is an open source data validator for tabular data (think spreadsheets and CSVs). It can check both the structure of the file (do all rows have the same number of columns?), and its contents (is this a valid date?). Goodtables gives you a safety net that guarantees that your data files are valid.

We'll work step by step. First, I'll show you what the data looks like, then we'll then check what goodtables can find out of the box, without any information about the data contents. Finally, we'll define the types and constraints of each column, so goodtables can validate that the rows contain what we expect.

By the end of this post, you'll have a better idea on how goodtables can help you be more confident about your data's quality.

## <a name="data"></a>The data

We'll use the remuneration of the civil servants working for São Paulo's City Council as an example. This data was scraped from [their website][cmsp-remunerations]. The first few rows look like:

| name | role | function | remuneration | department | year | month |
| --- | --- | --- | --- | --- | --- | --- |
| MILTON LEITE DA SILVA | VEREADOR | VEREADOR | 11534.82 | PRESIDÊNCIA | 2017 | 9 |
| PAULO CESAR TAGLIAVINI | CHEFE DE GABINETE DA PRESIDÊNCIA | CHEFE DE GABINETE DA PRESIDÊNCIA | 14124.71 | GABINETE DA PRESIDÊNCIA | 2017 | 9 |
| CECILIA DE ARRUDA | CHEFE DE CERIMONIAL | CHEFE DE CERIMONIAL | 22455.9 | GABINETE DA PRESIDÊNCIA | 2017 | 9 |
| ANTONIO JAIR DA ROSA | ASSISTENTE LEGISLATIVO III | | 7383.64 | GABINETE DA PRESIDÊNCIA | 2017 | 9 |
| BRASILINO SILVA BRANDAO | ASSISTENTE LEGISLATIVO III | | 8135.51 | GABINETE DA PRESIDÊNCIA |2017 | 9 |

Some of the columns are strings (name, role, function, and department), one is numeric (remuneration), and two are date parts (year and month). We'll think about the types and constraints on each of these columns in a minute, but first let's see what goodtables tells us out of the box.

## Initial validations

[Goodtables][goodtables] is written in Python, and can be used both as a command-line tool or imported in your Python code. We'll use it in the command-line. Considering that our data lives in `data/remunerations.csv`, we validate it by running `goodtables data/remunerations.csv`. This is the output:

```
DATASET
=======
{'error-count': 0,
 'preset': 'table',
 'table-count': 1,
 'time': 0.025,
 'valid': True}
---------
Warning: Table "data/remunerations.csv" inspection has reached 1000 row(s) limit

TABLE [1]
=========
{'encoding': 'utf-8',
 'error-count': 0,
 'format': 'csv',
 'headers': ['name', 'role', 'function', 'remuneration', 'department', 'year', 'month'],
 'row-count': 1000,
 'schema': None,
 'scheme': 'file',
 'source': 'data/remunerations.csv',
 'time': 0.024,
 'valid': True}
```

It hasn't found any errors, good! However, there's a warning: it just analyzed the first 1,000 rows. Maybe there's an error in the other rows? As our data is very small, with a bit over 2,000 rows, analyzing everything should be quick. Let's try again with a high row limit, using `goodtables --row-limit 999999 data/remunerations.csv`:

```
DATASET
=======
{'error-count': 1,
 'preset': 'table',
 'table-count': 1,
 'time': 0.046,
 'valid': False}

TABLE [1]
=========
{'encoding': 'utf-8',
 'error-count': 1,
 'format': 'csv',
 'headers': ['name', 'role', 'function', 'remuneration', 'department', 'year', 'month'],
 'row-count': 2043,
 'schema': None,
 'scheme': 'file',
 'source': 'data/remunerations.csv',
 'time': 0.045,
 'valid': False}
---------
[1859,-] [duplicate-row] Row 1859 is duplicated to row(s) 1858
```

A-ha! Now it found an error: duplicate rows. Depending on the data, this might or might not be an issue. Goodtables is helpful enough to tell us the row numbers, let's take a look at them:


| name | role | function | remuneration | department | year | month |
| --- | --- | --- | --- | --- | --- | --- |
| | | | | CTI-4 - EQUIPE DE TELECOMUNICAÇÕES E INFRAESTRUTURA | 2017 | 9 | 
| | | | | CTI-4 - EQUIPE DE TELECOMUNICAÇÕES E INFRAESTRUTURA | 2017 | 9 | 

This does look like a valid error (no names?). After investigating for a while, I found the culprit: the source website was modified. There are now a few cases where the civil servant's name was removed by judicial order, and it broke my code. The joys of scraping, right?

After fixing it and running goodtables again, this is what I got:

```
DATASET
=======
{'error-count': 0,
 'preset': 'table',
 'table-count': 1,
 'time': 0.083,
 'valid': True}

TABLE [1]
=========
{'encoding': 'utf-8',
 'error-count': 0,
 'format': 'csv',
 'headers': ['name', 'role', 'function', 'remuneration', 'department', 'year', 'month'],
 'row-count': 4083,
 'schema': None,
 'scheme': 'file',
 'source': 'data/remunerations.csv',
 'time': 0.081,
 'valid': True}
```

Great, no more errors!

Without giving any information about my data, goodtables found out there was a duplicate row. This led me to find out that the website I'm scraping was modified and broke my code. Even if we stopped now, this has already been useful. We won't. There still are some useful tricks up goodtable's sleeve.

## Improving the validations

Although goodtables provides valuable information for an arbitrary CSV, its real power comes when we tell it the data schema. It'll validate that the data is what we expect it to be (numbers are numbers, dates are valid, etc.). The easiest way to define this schema is by creating a [Data Package][datapackage].

The first thing we need is to create a JSON file named `datapackage.json`:

```json
{
  "name": "remunerations-cmsp",
  "title": "Remuneration of the civil servants from the Sao Paulo's City Council",
  "resources": [
    {
      "name": "remunerations",
      "path": "data/remunerations.csv"
    }
  ]
}
```

This is the simplest data package we can create for this data. It just defines a `name` and `title` for the dataset, and a single resource, our CSV file. Goodtables support data packages out of the box, so we can run `goodtables datapackage.json` and it'll give us the same result as running `goodtables data/remunerations.csv` directly. With this in place, we can start writing the schema.

Think of the schema as a data dictionary. It defines what each column means, what data it contains, which format, their description, and so on. Looking at the data, these are the data types of each of our columns:

* String
    * Name
    * Role
    * Function
    * Department
* Currency
    * Remuneration
* Dates
    * Year
    * Month

Schemas in data packages follow the [Table Schema][tableschema] specification which defines how to write the schema, a few basic types, and how to add constraints (e.g. uniqueness, required, valid ranges). It sounds more complicated than it actually is. For instance, this is how we would write the column's types I defined above using the Table Schema:

```json
{
  "name": "remunerations-cmsp",
  "title": "Remuneration of the civil servants from the Sao Paulo's City Council",
  "resources": [
    {
      "name": "remunerations",
      "path": "data/remunerations.csv",
      "schema": {
        "fields": [
          {
            "name": "name",
            "type": "string"
          },
          {
            "name": "role",
            "type": "string"
          },
          {
            "name": "function",
            "type": "string"
          },
          {
            "name": "remuneration",
            "type": "number"
          },
          {
            "name": "department",
            "type": "string"
          },
          {
            "name": "year",
            "type": "year"
          },
          {
            "name": "month",
            "type": "integer"
          }
        ]
      }
    }
  ]
}
```

The only thing we changed was adding the `schema` attribute to our resource, everything else is the same. When we run goodtables again, it still is successful, but now it's not only running the basic validations, but also checking the cells' types.

Can we improve it further? Of course!

Take a look at the `month` column. As Table Schema doesn't have a "month" data type, we had to use the closest to it: integer. A month is an integer, however it's not _any_ integer. It can't be zero, or -1, or 42, it must be from 1 to 12. The Table Schema allows us to define these constraints in our schema, but before I show you how, what about the other columns? Are there other similar constraints, not only about valid ranges, but also if they are required or must be unique.

I went through all columns, looking at the data and understand which constraints they have, and this is what I defined:

* Department
    * Required
* Remuneration
    * Required
* Year
    * Required
    * Greater than 2017 (there's no historical data)
* Month
    * Required
    * Between 1 and 12

There are no constraints for `name`, `role` and `function` other than the type. On the `datapackage.json`, these fields will look like:

```json
{
  "name": "department",
  "type": "string",
  "constraints": {
      "required": "true"
  }
},
{
  "name": "remuneration",
  "type": "number",
  "constraints": {
      "required": true
  }
},
{
  "name": "year",
  "type": "number",
  "constraints": {
    "required": true,
    "minimum": 2017
  }
},
{
  "name": "month",
  "type": "number",
  "constraints": {
    "required": true,
    "minimum": 1,
    "maximum": 12
  }
}
```

Goodtables now raises a few errors on `remuneration`. There are some rows where it's empty. Looking back at the original website, I confirm that I was wrong, there really are some rows without `remuneration` (apparently the councillors' remunerations are somewhere else). After removing this constraint, everything runs successfully.

The final `datapackage.json` looks like:

```json
{
  "name": "remunerations-cmsp",
  "title": "Remuneration of the civil servants from the Sao Paulo's City Council",
  "resources": [
    {
      "name": "remunerations",
      "path": "data/remunerations.csv",
      "schema": {
        "fields": [
          {
            "name": "name",
            "type": "string"
          },
          {
            "name": "role",
            "type": "string"
          },
          {
            "name": "function",
            "type": "string"
          },
          {
            "name": "remuneration",
            "type": "number"
          },
          {
            "name": "department",
            "type": "string",
            "constraints": {
              "required": "true"
            }
          },
          {
            "name": "year",
            "type": "year",
            "constraints": {
              "required": true,
              "minimum": 2017
            }
          },
          {
            "name": "month",
            "type": "integer",
            "constraints": {
              "required": true,
              "minimum": 1,
              "maximum": 12
            }
          }
        ]
      }
    }
  ]
}
```

I could've added constraints in the `role`, `function`, and `department` fields, as they can only have a set of values (i.e. there's no department "Foobar"). I decided it wasn't worth the trouble now, as I don't have a list of possible values at hand. If I want to add these or other constraints in the future, the structure is already in place, so it's straightforward.

## Conclusion

My intent with this post was to show you the value of adding even a little bit of data validation to your toolbox, and how easy it is to do so with goodtables. We started by running it without giving any information about our data. It found duplicate rows that led me to discover that the website I'm scraping has changed, so my scraper was out of date. After I updated the code and ran it again, goodtables was successful.

We then told goodtables more about our data by writing a schema using the [Data Package][datapackage] and [Table Schema][tableschema] specifications. This led me to know the data better, as my initial assumptions that all rows must have a remuneration was wrong.

With all this in place, goodtables is now able to check not only the structure of the data, but that its contents are valid. The next step is how to make sure it stays this way. In a future post, I'll show you how to run goodtables automatically as part of your test suite when your data is on GitHub.

I hope you found this interesting. If you're curious about how this all fit together, check it out on [https://github.com/vitorbaptista/remuneracao_cmsp][repository].

If you have any questions, feedback, or would just like to chat, join our [Frictionless Data Gitter chat][fd-gitter]. We'd love to hear from you, so we can make these tools as useful as they can be.

[goodtables]: https://github.com/frictionlessdata/goodtables-py/ "goodtables"
[datapackage]: http://frictionlessdata.io/data-packages/ "Data Package"
[tableschema]: http://frictionlessdata.io/guides/table-schema/ "Table Schema"
[fd-gitter]: http://gitter.im/frictionlessdata/chat "Frictionless Data Gitter"
[cmsp-remunerations]: http://www.camara.sp.gov.br/transparencia/salarios-abertos/remuneracao-dos-servidores-e-comissionados/ "Remuneration of Sao Paulo City Council's Civil Servants"
[repository]: https://github.com/vitorbaptista/remuneracao_cmsp
