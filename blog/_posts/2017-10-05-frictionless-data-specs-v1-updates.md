---
author: Serah Rono
username: callmealien
projects: [frictionless-data,dpm,goodtables-web]
title: Frictionless Data Specs v1 Updates
---
The Frictionless Data team released v1 specifications in the first week of September 2017 and Paul Walsh, Chief Product Officer at Open Knowledge International,  [wrote a detailed blogpost about it](https://blog.okfn.org/2017/09/05/frictionless-data-v1-0/). With this milestone, in addition to modifications on pre-existing specifications like Table Schema[^tableschema] and CSV Dialect[^csvdialect] in line with our design philosophy[^philosophy], the team created two new specifications- Data Resource[^dr] and Tabular Data Resource[^tdr]- which employ explicit pattern rules to help describe data resources unambiguously.

Following the September release, the team has  now updated our range of frictionless data implementations to work with v1 specs - from `tableschema` and `datapackage` libraries to `tableschema` plugins and the `goodtables.io` service.

Some of the highlights from this update include:

- SQL/BigQuery/Pandas plugins now work with all 15 Table Schema types[^types] with no data loss,
- use Frictionless Data tools [^tools] to infer, package and use data from different online sources  
- Create datapackages from a select few tables in your database

## Table Schema Plugins update

The [Pandas](https://github.com/frictionlessdata/tableschema-pandas-py), [SQL](https://github.com/frictionlessdata/tableschema-sql-py) and [BigQuery](https://github.com/frictionlessdata/tableschema-bigquery-py) plugins have now been updated to work with v1 specifications.

Here's how you can infer arbitrary CSV files from an online source, create a data package with the data and analyze it in a widely used data analysis tool like Pandas or an SQL database:

```python
#pip install datapackage tableschema tableschema_sql tableschema_pandas
from pprint import pprint
from tableschema import Storage
from datapackage import Package
from sqlalchemy import create_engine

# Infer data package from some CSVs in the internet
package = Package()
package.add_resource({'name': 'teams', 'path': 'https://raw.githubusercontent.com/danielfrg/espn-nba-scrapy/master/data/teams.csv'})
package.add_resource({'name': 'games', 'path': 'https://raw.githubusercontent.com/danielfrg/espn-nba-scrapy/master/data/games.csv'})
package.infer()
pprint(package.descriptor)

# Check data package integrity
package.descriptor['resources'][1]['schema']['foreignKeys'] = [
    {'fields': 'home_team', 'reference': {'resource': 'teams', 'fields': 'name'}},
    {'fields': 'visit_team', 'reference': {'resource': 'teams', 'fields': 'name'}},
]
package.commit()
package.get_resource('games').check_relations()
pprint('Integrity is checked')

# Analyze data package in SQL
engine = create_engine('sqlite:///')
package.save(storage='sql', engine=engine)
pprint(list(engine.execute("""
    SELECT home_team, round(avg(home_team_score), 1) as score
    FROM games GROUP BY home_team ORDER BY score DESC
""")))

# Analyze data package in Pandas
storage = Storage.connect('pandas')
package.save(storage=storage)
pprint(storage['games'].loc[storage['games']['home_team_score'].idxmax()])
```

## Data Package Storage API update
We are working to make the Data Package specification[^datapackage] the go-to metadata format to move datasets from one persistent storage to another. The Storage API (example below) now allows you to move data between Pandas, SQL and Big Query.

```python
# pip install datapackage tableschema tableschema_sql tableschema_pandas tableschema_bigquery
import io
import os
import json
from pprint import pprint
from tableschema import Storage
from datapackage import Package
from sqlalchemy import create_engine
from apiclient.discovery import build
from oauth2client.client import GoogleCredentials
engine = create_engine('sqlite:///') # use your persistent database

# From BigQuery to SQL
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = '.credentials.json'
credentials = GoogleCredentials.get_application_default()
service = build('bigquery', 'v2', credentials=credentials)
package = Package(storage='bigquery', service=service, project='bigquery-public-data', dataset='usa_names')
package.save(storage='sql', engine=engine)

# From SQL to Pandas
storage = Storage.connect('pandas')
package = Package(storage='sql', engine=engine)
package.save(storage=storage)
pprint(storage['usa_1910_current'].head())
```

For more examples and ideas on how to use Storage API in your data wrangling and publishing workflow, take a look at `datapackage-py` documentation[^datapackagepy].
We welcome community contributions to allow for more integrations. Interested in contributing? [Start here](https://github.com/frictionlessdata/tableschema-py/blob/master/README.md#storage).

## Use Table Schema's Data Types with no data loss
With the new update, it is now possible to store and retain all your data even where your storage backend provides a limited subset of all supported data types. For example, SQLite doesn't support a JSON data type:

```python
from datapackage import Package
from tableschema import Table, Storage
from sqlalchemy import create_engine
engine=create_engine('sqlite:///')

# Resource
data = [[{'key': 'value'}]]
schema = {'fields': [{'name': 'object', 'type': 'object'}]}

# Save
storage = Storage.connect('sql', engine=engine)
table = Table(data, schema=schema)
table.save('objects', storage=storage)

# Load
table = Table('objects', schema=schema, storage=storage)
table.read()
# [[{'key': 'value'}]] - objects inside as we'd like
```

## Create datapackages from a few tables in your DB
You can now create new data packages with a select few SQL, BigQuery or Panda tables from your database  when loading it as a data package.
Example:

```python
package = Package({'resources': [{'path': 'table1'}, {'path': 'table3'}]}, storage='sql', engine=engine)
package.resource_names # ['table1', 'table3']
package.infer()
print(package.descriptor)
```

## Goodtables web service works with v1 specs
Our  goodtables.io web service is now updated to work with v1 specifications[^specs]. This tool allows you to setup your continous data validation workflow to ensure that published data is always valid. [try.goodtables.io](https://try.goodtables.io) allows a one-time validation for arbitrary tabular files against structure and schema checks and is perfect for demo or trial purposes.

## Next steps
- We are looking to write more in-depth documentation and guides for the Frictionless Data specs and tools as we update our codebase[^github].
- We are looking forward to extend the number of our storage API implementations. In addition to the SQL/BigQuery/Pandas implementations, we are working on SPSS[^spss] and Elasticsearch[^elasticsearch] plugins. Contributors play a very important role in this work. Feel free to write your own `tableschema` plugin - it's fun and a relatively simple task!

We welcome community contributions to our codebase, and are keen to interact with you on [Frictionless Data Gitter chat](http://gitter.im/frictionlessdata/chat).


[^specs]: Frictionless Data Specifications: <http://specs.frictionlessdata.io/>
[^tableschema]: Table Schema: <http://specs.frictionlessdata.io/table-schema/>
[^csvdialect]: CSV Dialect: <http://specs.frictionlessdata.io/csv-dialect/>
[^philosophy]: Frictionless Data Design Philosophy: <http://specs.frictionlessdata.io/#design-philosophy>
[^dr]:Data Resource: <http://specs.frictionlessdata.io/data-resource/>
[^tdr]: Tabular Data Resource: <http://specs.frictionlessdata.io/tabular-data-resource/>
[^types]: Table Schema Types: <http://specs.frictionlessdata.io/table-schema/#types-and-formats>
[^datapackage]: Data Package <http://specs.frictionlessdata.io/data-package/>
[^tools]: Frictionless Data Tools <http://frictionlessdata.io/tools/>
[^datapackagepy]: Data Package Python Library: <https://github.com/frictionlessdata/datapackage-py>
[^github]: Frictionless Data on Github: <http://github.com/frictionlessdata>
[^spss]: Frictionless Data SPSS Plugin: <https://github.com/frictionlessdata/tableschema-spss-py>
[^elasticsearch]: Frictionless Data ElasticSearch Plugin: <https://github.com/frictionlessdata/tableschema-elasticsearch-py>
