---
author: Paul Walsh, Adrià Mercader
username: pwalsh, amercader
projects: [frictionless-data]
title: Bootstrapping data standards with Frictionless Data
---

When it comes to tabular data, the [Frictionless Data][fd] specifications provide users with strong conventions for declaring both the shape of data (via schemas) and information about the data (as metadata on package and resource descriptors).

Within the Frictionless Data world, we purposefully refer to specification work as *specifications*, and not *standards*. The specifications therein provide clear conventions for working with data, and declare fundamental interfaces on which a modular software system that works with these specifications can be built. It is very meta. However, the specifications and software foundation *do* make the Frictionless Data ecosystem a powerful and compelling technical foundation on which to build data standards. 

Some reasons for why:

- data serialised in a format that can be read by software developers use to build tools such as APIs, and also by many consumer programs that are used by consumers of data with little to no technical know how.
- built in progressive enhancement, where metadata, as well as structural and schematic information about the data, can be incorporated over time without modifying the original data source.
- A large and growing collection of tools, in many programming languages, for working with the Frictionless Data specifications.
- The specifications and the software are platform agnostic. A major example of this is being web-friendly without being dependent on the web (as with many linked data approaches). Linkable data, not Linked Data.

We'll demonstrate this with some examples below, which are a proof of concept for the idea of using Frictionless Data as a technical foundation for data standards. This is an ongoing work that we intend to iterate on in response to feedback to this initial take.

Of course, we do not in any way think that the technical implementation of a data standard is what "data standards" is about. Data standards are about communities of practice, stakeholder engagement, and increasingly, a vehicle of change at the level of policy and governance. Technical implementation, in this wider context, is but a small, yet crucial, component. Indeed, this is a critical part of the promise we are pointing to here - that by building on a common foundation, communities building data standards can focus a little less on the technical implementation details and a little more on the change they want to see by creating them.

## Grant funding

[360Giving](http://www.threesixtygiving.org/) is an organization that helps funders to be transparent about the grants they award. It provides a [standard](http://standard.threesixtygiving.org/en/latest/) for publishing grants data in a common format, and a [Registry](http://www.threesixtygiving.org/data/data-registry/) to host the data. Publishers can upload a spreadsheet that contains various fields describing the different activities they funded. We will demonstrate how a custom Data Package profile could describe one of these spreadsheets, ensuring that the required metadata fields are present and that the contents of the file conform to the [schema](http://standard.threesixtygiving.org/en/latest/reference/#grants-sheet).

We will use this [sample dataset](http://www.blagravetrust.org/wp-content/uploads/2017/01/360G-blagravetrust-2016.xlsx), taken directly from the Registry without any changes:

| Identifier | Title | Description | Currency | Amount Awarded | Amount Disbursed | Award Date
| --- | --- | --- | --- | --- | --- | --- |
| 360G-blagravetrust-00658000009YZRq | Achieving Further | Work with 22 FE colleges to improve attainment; attendance and participation | GBP | 300000 | 300000 | 2014-07-08
| 360G-blagravetrust-00658000007A1UQ | Training on feedback for Portsmouth VCS | Improving feedback skills for Portsmouth VCS - Feedback Fund 2016 | GBP | 3933 | 3933 | 2016-08-09
| 360G-blagravetrust-00658000008vdAl | Creative learning programme | Portsmouth young people leaving care | GBP | 75000 | 25000 | 2016-11-08
| 360G-blagravetrust-00658000007lweS | Feedback Fund | Feedback Fund 2016 | GBP | 2094 | 2094 | 2016-08-09

Our first step was to create a Table Schema describing the expected contents of the fields, which was then [embedded](https://github.com/frictionlessdata/profiles/blob/c3423d1266439ffebfdac2b681d3dd0bffd81964/assets/grants/datapackage.json#L39) in the Data Package descriptor. This was easy as like we mentioned before, there already is a well defined [schema](http://standard.threesixtygiving.org/en/latest/reference/#grants-sheet) for how the fields should be. For the purposes of this example we just focused on a subset of all available fields. Here are some example fields:

 Name / Title | Type | Constraints |
| --- | --- | --- |
| Identifier | string |  |
| Title | string | **maxLength**: 140 |
| Description | string |  |
| Currency | string | **enum**: ['AED', 'AFN', 'ALL', 'AMD', ...] |
| Amount Awarded | number |  |
| Amount Disbursed | number |  |
| Award Date | date |  |
| URL | string |  |
| ... | ... | ... |
| Funding Org:Name | string |  |
| Funding Org:Department | string |  |
| Grant Programme:Code | string |  |
| Grant Programme:Title | string |  |
| Grant Programme:URL | string |  |
| From an open call? | string |  |
| Related Activity | string |  |
| Last modified | datetime |  |
| Data Source | string |  |

Our custom [Grants Data Package](https://github.com/frictionlessdata/profiles/blob/master/assets/grants/datapackage.json) extends the [Data Package][dp] specification by adding the following fields:

| Name               | Description                                                                                     | Type    |
| ---                | ---                                                                                             | ---     |
| funder        | A JSON object describing the funding organization. It can include the following properties: `id`, `name`, `email`, `url` | object  |
| year | The year that the grants data in this file covers | integer |
| modified | The timestap of when this dataset was last modifed | datetime |

This follows closely the [JSON specification](https://threesixtygiving.github.io/getdata/) that 360Giving has, with the rest of the fields covered by the standard Data Package specification.

Once we have our data packaged in this way, we can leverage all the ecosystem of tools built around Data Packages to work with it. For instance, using the [`datapackage`](https://github.com/frictionlessdata/datapackage-py) library we can iterate over the contents of the file:

```python
import datapackage

datapackage_url = 'https://raw.githubusercontent.com/frictionlessdata/profiles/master/assets/grants/datapackage.json'
dp = datapackage.Package(datapackage_url)

for row in dp.resources[0].iter(keyed=True):
    print(row)
    # {'Funding Org:Identifier': 'GB-CHC-1164021', 'Beneficiary Location:Geographic Code Type': 'UA', 'From an open call?': None, 'Beneficiary Location:Name': 'Reading', 'Grant Programme:Code': None, 'Beneficiary Location:Geographic Code': 'E06000038', 'Amount Disbursed': Decimal('300000'), 'Recipient Org:City': 'Newbury', 'Award Date': datetime.datetime(2014, 7, 8, 0, 0), 'Beneficiary Location:Longitude': Decimal('-0.95543100000000003024780426130746491253376007080078125'), 'Recipient Org:Web Address': 'http://www.afaeducation.org', 'Recipient Org:Charity Number': '1142154', 'Grant Programme:Title': None, 'Related Activity': None, 'Grant Programme:URL': None, 'Recipient Org:Country': 'UK', 'Funding Org:Name': 'The Blagrave Trust', 'Title': 'Achieving Further', 'Planned Dates:End Date': datetime.datetime(2017, 6, 30, 0, 0), 'Recipient Org:Postal Code': 'RG14 1JQ', 'Identifier': '360G-blagravetrust-00658000009YZRq', 'Data Source': None, 'Planned Dates:Start Date': None, 'Currency': 'GBP', 'Description': 'Work with 22 FE colleges to improve attainment; attendance and participation', 'Recipient Org:Identifier': 'GB-CHC-1142154', 'Recipient Org:Description': 'Charity working with nurseries schools and colleges to raise attainment and achivement of children particularly those with barriers to learning', 'Funding Org:Department': None, 'Beneficiary Location:Country Code': None, 'Last modified': None, 'URL': None, 'Amount Awarded': Decimal('300000'), 'Beneficiary Location:Latitude': Decimal('51.4541449999999969122654874809086322784423828125'), 'Recipient Org:County': 'Berkshire', 'Recipient Org:Name': 'Achievement for All', 'Recipient Org:Street Address': 'Oxford House, Oxford Street', 'Planned Dates:Duration (months)': None, 'Recipient Org:Company Number': None}
 
```

Also, as we define the Table Schema, we can use [goodtables](https://github.com/frictionlessdata/goodtables-py) to perform data validation and get a report of issues found:

```python
from goodtables import validate

datapackage_url = 'https://raw.githubusercontent.com/frictionlessdata/profiles/master/assets/grants/datapackage.json'
validate(datapackage_url)
	'''
	{'error-count': 0,
	 'preset': 'datapackage',
	 'table-count': 1,
	 'tables': [{'datapackage': 'https://raw.githubusercontent.com/frictionlessdata/profiles/c3423d1266439ffebfdac2b681d3dd0bffd81964/assets/grants/datapackage.json',
	   'encoding': None,
	   'error-count': 0,
	   'errors': [],
	   'format': 'inline',
	   'headers': ['Identifier',
		'Title',
		'Description',
		'Currency',
		'Amount Awarded',
		'Amount Disbursed',
		'Award Date',
		'URL',
		'Planned Dates:Start Date',

		...		

		'Grant Programme:URL',
		'From an open call?',
		'Related Activity',
		'Last modified',
		'Data Source'],
	   'row-count': 70,
	   'schema': 'table-schema',
	   'scheme': None,
	   'source': 'https://raw.githubusercontent.com/frictionlessdata/profiles/c3423d1266439ffebfdac2b681d3dd0bffd81964/assets/grants/360G-blagravetrust-2016.xlsx',
	   'time': 0.53,
	   'valid': True}],
	 'time': 1.386,
	 'valid': True,
	 'warnings': []}
	'''

```

## IATI Registry

The [IATI Standard][iati-standard] is a technical framework to publish aid, development, and humanitarian data in a standard way. Data published in the IATI standard is indexed on the [IATI Registry][iati-registry]. Here we will demonstrate the creation of a custom Data Package profile to package data meant to be published in the registry, ensuring that it has the required metadata.

Here are the fields available when publishing a new IATI file on the registry:

| Name | Data Package field | Description | Type |
| --- | --- | --- | --- |
| `registry-file-id` | `name ` | A unique identifier for the activity record | string
| `registry-publisher-id` | - | Publisher identificator on the IATI Registry | string
| `title` | `title ` | The title of the dataset | string
| `description` | `description` | Some useful notes about the data | string
| `source-url` | `resources[0]['path']` | URL to a publicly accessible IATI file | string
| `contact-email` | - | Contact email for publisher | string
| `file-type` | - | Must be either 'Activity' or 'Organization' | string
| `recipient-country` | - | Recipient country | string
| `last-updated-datetime` | - | Timestamp of the last modification | date-time
| `activity-count` | - | Number of activities described in the data | integer
| `default-language` | - | Language of the data | string
| `secondary-publisher` | - | The publisher this dataset is published on behalf of | string

To create the new profile, we will add those fields that do not map directly to the [Data Package specification](https://frictionlessdata.io/specs/data-package/) to a standard Data Package descriptor and create a custom JSON Schema to validate it. Here is the [resulting Data Package descriptor](https://github.com/frictionlessdata/profiles/blob/master/assets/iatiregistry/datapackage.json).





[iati-standard]: http://iatistandard.org/
[iati-registry]: https://iatiregistry.org/


### Trees

The [Open Council Data][opencouncildata] defined the standard [Trees 1.3][trees-spec] for describing the trees in a geographical region (e.g. a council). This standard includes information about the location, type, and other characteristics of individual trees, which is useful for planning future growth, maintenance of canopy cover, managing risk of falling branches, etc.

We are using the from [Colac Otway Shire Trees][trees-datasource] as an example.

| lat | lon | genus | species | dbh | dbh_min | dbh_max | year_min | year_max | crown | crown_min | crown_max | height | height_min | height_max | common | location | ref | maintenance | maturity | planted | updated | health | variety | description | family | ule_min | ule_max | address |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| -38.344595 | 143.592171 | Melaleuca | Stypheliodes | 1 |  |  |  |  |  |  |  | 5 |  |  | Prickly Paperback | street | 10001 |  | mature | 1975-01-01 |  |  |  |  |  |  |  | 106 Queen ST COLAC VIC 3250 |
| -38.346198 | 143.591812 | Melaleuca | Stypheliodes | 1 |  |  |  |  |  |  |  | 4 |  |  | Prickly Paperback | street | 10004 |  | mature | 1975-01-01 |  |  |  |  |  |  |  | 122 Queen ST COLAC VIC 3250 |
| -38.342097 | 143.588944 | Fraxinus | Excelsior | 1.2 |  |  |  |  |  |  |  | 12 |  |  | Golden Ash | street | 10007 |  | mature | 1980-01-01 |  |  |  |  |  |  |  | 40 Rae ST COLAC VIC 3250 |
| -38.341927 | 143.588715 | Agonis | Flexuosa | 0.4 |  |  |  |  |  |  |  | 5 |  |  | Weeping Willow Myrtle | street | 10018 |  | semi-mature | 1980-01-01 |  |  |  |  |  |  |  | 47 Rae ST COLAC VIC 3250//next to coles coaches |
| -38.342044 | 143.591182 | Eucalyptus | Nichollii | 0.3 |  |  |  |  |  |  |  | 6 |  |  | Willow Peppermint | street | 10021 |  | mature | 1980-01-01 |  |  |  |  |  |  |  | 56 Rae ST COLAC VIC 3250//Between Queen St & CCDA |

This data was modified from the source to conform to the [Trees 1.3][trees-spec] specification. All the data is available [here][trees-data].

The [Trees Data Package][trees-schema] extends the [Data Package][dp] specification by adding the following fields:

| Name               | Description                                                                                     | Type    |
| ---                | ---                                                                                             | ---     |
| countryCode        | A single or an array of 2-letter ISO country code defining the country(ies) present in the data | string  |
| geospatialCoverage | Geospatial area contained in the dataset                                                        | geojson |

| Name | Title | Type | Constraints |
| --- | --- | --- | --- |
| lat | Latitude in decimal degrees (EPSG:4326) | number | **required**: True |
| lon | Longitude in decimal degrees (EPSG:4326) | number | **required**: True |
| genus | Botanical genus, in title case (e.g. Eucalyptus) | string |  |
| species | Botanical species, in title case (e.g. Regnans) | string |  |
| dbh | Diameter at breast height (130cm above ground), in centimeters. If this information is available only as a range, this contains the middle of the range. | number | **minimum**: 0 |
| dbh_min | Minimum diameter at breast height (130cm above ground) | number | **minimum**: 0 |
| dbh_max | Maximum diameter at breast height (130cm above ground) | number | **minimum**: 0 |
| year_min | Lower bound on year that tree is expected to live to (e.g. A tree surveyed in 2008 with useful life expectancy range of 10-15 years would be 2018). | year |  |
| year_max | Upper bound on year that tree is expected to live to (e.g. A tree surveyed in 2008 with useful life expectancy range of 10-15 years would be 2023). | year |  |
| crown | Width in metres of the tree’s foliage (also known as crown spread). If this information is available only as a range, this contains the middle of the range. | number | **minimum**: 0 |
| crown_min | Minimum width in meters of the tree's foliage | number | **minimum**: 0 |
| crown_max | Maximum width in meters of the tree's foliage | number | **minimum**: 0 |
| height | Height in meters. If this information is available only as a range, this contains the middle of the range. | number | **minimum**: 0 |
| height_min | Minimum height in meters | number | **minimum**: 0 |
| height_max | Maximum height in meters | number | **minimum**: 0 |
| common | Common name for species (non-standardised) | string |  |
| location | Where the tree is located | string | **enum**: ['park', 'street', 'council'] |
| ref | Council-specific identifier, enabling joining to other datasets | number |  |
| maintenance | How often the tree is inspected (in months) | number | **minimum**: 0 |
| maturity |  | string | **enum**: ['young', 'semi-mature', 'mature', 'over-mature'] |
| planted | Date of planting | date |  |
| updated | Date of addition to database or most recent revision | date |  |
| health | Health of tree growth | string | **enum**: ['stump', 'dead', 'poor', 'fair', 'good'] |
| variety | Any part of the scientific name below species level, including subspecies or variety | string |  |
| description | Other information about the tree that is not in its scientific name or species | string |  |
| family | Botanical family | string |  |
| ule_min | Lower bound on useful life expectancy when surveyed | number | **minimum**: 0 |
| ule_max | Upper bound on useful life expectancy when surveyed | number | **minimum**: 0 |
| address | Street address | string |  |

```python
import datapackage

datapackage_url = 'https://raw.githubusercontent.com/frictionlessdata/profiles/master/assets/trees/datapackage.json'
dp = datapackage.Package(datapackage_url)

for row in dp.resources[0].iter(keyed=True):
    print(row)
    # {'lat': Decimal('-38.347497'), 'lon': Decimal('143.595686'), 'genus': 'Melaleuca', 'species': 'Nesophila', 'dbh': Decimal('0.25'), 'dbh_min': None, 'dbh_max': None, 'year_min': None, 'year_max': None, 'crown': None, 'crown_min': None, 'crown_max': None, 'height': Decimal('2'), 'height_min': None, 'height_max': None, 'common': 'Snowy Honey Myrtle', 'location': 'street', 'ref': Decimal('10379'), 'maintenance': None, 'maturity': 'semi-mature', 'planted': datetime.date(1980, 1, 1), 'updated': None, 'health': None, 'variety': None, 'description': None, 'family': None, 'ule_min': None, 'ule_max': None, 'address': '18 Thomas ST COLAC VIC 3250'}
```

### Conculsion

This has been a high-level exploration of using [Tabular Data Package][tdp] and [Table Schema][ts] as a "specification framework", allowing one to bootstrap a proof of concept data standard. Taking this approach, one gains access to a collection of modular software libraries that provide powerful APIs for working with this data according to the rules and condition of the standard that is declared. Data validation, processing, transport, and consumption do not require custom tool chains once the data standard is declared as a [Tabular Data Package Profile][profile].

The approach described here is a first step in the direction of domain-specific tabular data profiles. A future iteration would likely integrate work we are currently undertaking in the [Fiscal Data Package][fdp] which enables the simple declaration of *domain concepts* via `columnType` annotations on Table Schemas. This enables data standard authors to work at a level of abstraction of domain concepts, rather than the "primitive types" we work with here via Table Schema. We plan to revisit this work once the `columnType` work from Fiscal Data Package is stable for general use.

For now, all the schemas above work as described, and open up all the software in the Frictionless Data ecosystem to those following this approach.

You can check the source code for all the examples listed in the following GitHub repository:

https://github.com/frictionlessdata/profiles


[fd]: https://frictionlessdata.io
[tdp]: https://frictionlessdata.io/specs/tabular-data-package/
[dp]: https://frictionlessdata.io/specs/data-package/
[fdp]: https://frictionlessdata.io/specs/fiscal-data-package/
[fdpv1]: https://hackmd.io/BwNgpgrCDGDsBMBaAhtALARkWsPEE5posR8RxgAzffWfDIA=
[ts]: https://frictionlessdata.io/specs/table-schema/
[profile]: https://frictionlessdata.io/specs/profiles/
[who]: http://www.who.int/ictrp/network/trds/en/
[ot]: https://opentrials.net
[who-dataset]: http://www.who.int/ictrp/network/trds/en/ "World Health Organisation Trial Registration Data Set"
[opencouncildata]: https://opencouncildata.org/ "Open Council Data"
[trees-data]: https://github.com/frictionlessdata/profiles/blob/master/assets/trees/data.csv "Trees CSV"
[trees-dp]: https://github.com/frictionlessdata/profiles/blob/master/assets/trees/datapackage.json "Trees Data Package"
[trees-schema]: https://github.com/frictionlessdata/profiles/blob/master/assets/trees/trees-data-package "Trees Data Package JSON Schema"
[trees-spec]: http://standards.opencouncildata.org/#/trees "Open Council Data: Trees 1.3 Specification"
[trees-datasource]: https://data.gov.au/dataset/colac-otway-shire-trees/resource/bcf1d62b-9e72-4eca-b183-418f83dedcea "Colac Otway Shire Trees"
