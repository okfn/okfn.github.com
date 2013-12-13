---
layout: post
title: Convert data between formats with Data Converters
author: Neil Ashton
username: nmashton
---

[Data Converters][1] is a command line tool and Python library making routine data conversion tasks easier. It helps data wranglers with everyday tasks like moving between tabular data formats—for example, converting an Excel spreadsheet to a CSV or a CSV to a JSON object.

The current release of Data Converters can convert between Excel spreadsheets, CSV data, and JSON tables, as well as some geodata formats (with additional requirements).

Its smart parser can guess the types of data, correctly recognizing dates, numbers, strings, and so on. It works as easily with URLs as with local files, and it is designed to handle very large files (bigger than memory) as easily as small ones.

![Data Converters homepage](http://i.imgur.com/kDDrgPW.png)

## Converting data

Converting an Excel spreadsheet to a CSV or a [JSON table][2] with the Data Converters command line tool is easy. Data Converters is able to read XLS(X) and CSV files and to write CSV and JSON, and input files can be either local or remote.

	dataconvert simple.xls out.csv
	dataconvert out.csv out.json
	
	# URLs also work
	dataconvert https://github.com/okfn/dataconverters/raw/master/testdata/xls/simple.xls out.csv

Data Converters will try to guess the format of your input data, but you can also specify it manually.

	dataconvert --format=xls input.spreadsheet out.csv

Instead of writing the converted output to a file, you can also send it to *stdout* (and then pipe it to other command-line utilities).

	dataconvert simple.xls _.json  # JSON table to stdout
	dataconvert simple.xls _.csv   # CSV to stdout

Converting data files can also be done within Python using the Data Converters library. The `dataconvert` convenience function shares the `dataconvert` command line utility's file reading and writing functionality.

	from dataconverters import dataconvert
	dataconvert('simple.xls', 'out.csv')
	dataconvert('out.csv', 'out.json')
	dataconvert('input.spreadsheet', 'out.csv', format='xls')

## Parsing data

Data Converters can do more than just convert data files. It can also parse tabular data into Python objects that captures the semantics of the source data.

Data Converters' various `parse` functions each return an iterator over the records of the source data along with a metadata dictionary containing information about the data. The records returned by `parse` are not just (e.g.) split strings: they're hash representations of the contents of the row, with column names and data types auto-detected.

	import dataconverters.xls as xls
	with open('simple.xls') as f:
	    records, metadata = xls.parse(f)
	    print metadata
	    print [r for r in records]
	=> {'fields': [{'type': 'DateTime', 'id': u'date'}, {'type': 'Integer', 'id': u'temperature'}, {'type': 'String', 'id': u'place'}]}
	=> [{u'date': datetime.datetime(2011, 1, 1, 0, 0), u'place': u'Galway', u'temperature': 1.0}, {u'date': datetime.datetime(2011, 1, 2, 0, 0), u'place': u'Galway', u'temperature': -1.0}, {u'date': datetime.datetime(2011, 1, 3, 0, 0), u'place': u'Galway', u'temperature': 0.0}, {u'date': datetime.datetime(2011, 1, 1, 0, 0), u'place': u'Berkeley', u'temperature': 6.0}, {u'date': datetime.datetime(2011, 1, 2, 0, 0), u'place': u'Berkeley', u'temperature': 8.0}, {u'date': datetime.datetime(2011, 1, 3, 0, 0), u'place': u'Berkeley', u'temperature': 5.0}]


## What's next?

Excel spreadsheets and CSVs aren't the only kinds of data that need converting.

Data Converters also supports geodata conversion, including converting between [KML][3] (the format for geographical data used in Google Maps and Google Earth), [GeoJSON][4], and [ESRI Shapefiles][5].

Data Converters' ability to convert between tabular data may also grow, adding JSON support on the input side and XLS(X) support on the output side—as well as new conversions for [XML][6], [SQL dumps][7], and [SPSS][8].

Visit the [Data Converters home page][9] to learn how to install Data Converters and its dependencies, and check out [Data Converters on GitHub][10] to see how you can contribute to the project.

[1]:	http://okfnlabs.org/dataconverters/
[2]:	http://dataprotocols.org/en/latest/json-table-schema.html
[3]:	https://developers.google.com/kml/documentation/
[4]:	http://geojson.org/
[5]:	http://www.esri.com/library/whitepapers/pdfs/shapefile.pdf
[6]:	https://github.com/okfn/dataconverters/issues/15
[7]:	https://github.com/okfn/dataconverters/issues/11
[8]:	https://github.com/okfn/dataconverters/issues/7
[9]:	http://okfnlabs.org/dataconverters/
[10]:	https://github.com/okfn/dataconverters

