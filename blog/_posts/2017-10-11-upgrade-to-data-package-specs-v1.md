---
author: Meiran Zhiyenbayev
username: mikanebu
projects: [frictionless-data,dpm,goodtables-web]
title: Data Package v1 Specifications. What has Changed and how to Upgrade
---

This post walks you through the major changes in the Data Package v1 specs compared to pre-v1. It covers changes in the full suite of Data Package specifications including Data Resources and Table Schema. It is particularly valuable if:

* you were using Data Packages pre v1 and want to know how to upgrade your datasets
* if you are implementing Data Package related tooling and want to know how to upgrade your tools or want to support or auto-upgrade pre-v1 Data Packages for backwards compatibility

It also includes a script we have created (in JavaScript) that we've been using ourselves to automate upgrades of the [Core Data][core-data].

## The Changes

Two major changes in v1 were presentational:

* Creating Data Resource as a separate spec from Data Package. This did not change anything substantive in terms of how data packages worked but is important presentationally. In parallel, we also split out a Tabular Data Resource from the Tabular Data Package.
* Renaming JSON Table Schema to just Table Schema

In addition, there were a fair number of substantive changes. We summarize these in the sections below. For more detailed info see the [current specifications][specs] and [the old site containing the pre spec v1 specifications][prev1].

### Table Schema

Link to spec: [https://specs.frictionlessdata.io/table-schema/](https://specs.frictionlessdata.io/table-schema/)

| Property              | Pre v1                                                 | v1 Spec                                                                         | Notes                                            | Issue                                                                                                                    |
|-----------------------|--------------------------------------------------------|---------------------------------------------------------------------------------|--------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| id/name               | id                                                     | name                                                                            | Renamed id to name to be consistent across specs |                                                                                                                          |
| type/number           | format: currency                                       | format: currency - removed format: bareNumber format: decimalChar and groupChar |                                                  | [#509](https://github.com/frictionlessdata/specs/issues/509)<br/>[#246](https://github.com/frictionlessdata/specs/issues/246) |
| type/integer          | No additional properties                               | Additional properties: bareNumber                                               |                                                  | [#509](https://github.com/frictionlessdata/specs/issues/509)                                                             |
| type/boolean          | true: [yes, y, true, t, 1],false: [no, n, false, f, 0] | true: [ true, True, TRUE, 1],false: [false, False, FALSE, 0]                    |                                                  | [#415](https://github.com/frictionlessdata/specs/issues/415)                                                             |
| type/year + yearmonth |                                                        | year and yearmonth NB: these were temporarily gyear and gyearmonth              |                                                  | [#346](https://github.com/frictionlessdata/specs/issues/346)                                                             |
| type/duration         |                                                        | duration                                                                        |                                                  | [#210](https://github.com/frictionlessdata/specs/issues/210)                                                             |
| type/rdfType          |                                                        | rdfType                                                                         | Support rich "semantic web" types for fields     | [#217](https://github.com/frictionlessdata/specs/issues/217)                                                             |
| type/null             |                                                        | removed (see missingValue)                                                      |                                                  | [#262](https://github.com/frictionlessdata/specs/issues/262)                                                             |
| missingValues         |                                                        | missingValues                                                                   | Missing values support did not exist pre v1.     | [#97](https://github.com/frictionlessdata/specs/issues/97)                                                               |
{: .table .table-striped .table-bordered style="display: block; overflow: auto;"}


### Data Resource

Link to spec: [https://specs.frictionlessdata.io/data-resource/](https://specs.frictionlessdata.io/data-resource/)

*Note: Data Resource did not exist as a separate spec pre-v1 so strictly we are comparing the Data Resource section of the old Data Package spec with the new Data Resource spec.*

| Property              | Pre v1       | v1 Spec         | Notes                                                                                                      | Issue                                                        |
|-----------------------|--------------|-----------------|------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------|
| path                  | path and url | path only       | url merged into path and path can now be a url or local path                                               | [#250](https://github.com/frictionlessdata/specs/issues/250) |
| path                  | string       | string or array | path can be an array to support a single resource split across multiple files                              | [#228](https://github.com/frictionlessdata/specs/issues/228) |
| name                  | recommended  | required        | Made name required to enable access to resources by name consistently across tools                         |                                                              |
| profile               |              | recommended     | See profiles discussion                                                                                    |                                                              |
| sources, licenses ... |              |                 | Inherited metadata from Data Package like sources or licenses upgraded inline with changes in Data Package |                                                              |
{: .table .table-striped .table-bordered style="display: block; overflow: auto;"}

### Tabular Data Resource

Link to spec: [https://specs.frictionlessdata.io/data-resource/](https://specs.frictionlessdata.io/data-resource/)

Just as Data Resource split out from Data Package so Tabular Data Resource split out from the old Tabular Data Package spec.

There were no significant changes here beyond those in Data Resource.

### Data Package

Link to spec: [https://specs.frictionlessdata.io/data-package/](https://specs.frictionlessdata.io/data-package/)

| Property         | Pre v1                                                                                                                      | v1 Spec                                                                                                                                                                               | Notes                                                                                                   | Issue                                                        |
|------------------|-----------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------|--------------------------------------------------------------|
| name             | required                                                                                                                    | recommended                                                                                                                                                                           | Unique names are not essential to any part of the present tooling so we have have moved to recommended. |                                                              |
| id               |                                                                                                                             | id property-globally unique                                                                                                                                                           | Globally unique id property                                                                             | [#228](https://github.com/frictionlessdata/specs/issues/228) |
| licenses         | license - object or string. The object structure must contain a type property and a url property linking to the actual text | licenses - is an array. Each item in the array is a License. Each must be an object. The object must contain a name property and/or a path property. It may contain a title property. |                                                                                                         |                                                              |
| author           | author                                                                                                                      | author is removed in favour of contributors                                                                                                                                           |                                                                                                         |                                                              |
| contributor      | name, email, web properties with name required                                                                              | title property required with roles, role property values must be one of - author, publisher, maintainer, wrangler, and contributor. Defaults to contributor.                          |                                                                                                         |                                                              |
| sources          | name, web and email and none required                                                                                       | title, path and email and title is required                                                                                                                                           |                                                                                                         |                                                              |
| resources        |                                                                                                                             | resources array is required                                                                                                                                                           |                                                                                                         | [#434](https://github.com/frictionlessdata/specs/issues/434) |
| dataDependencies | dataDependencies                                                                                                            |                                                                                                                                                                                       | Moved to a pattern until we have greater clarity on need.                                               | [#341](https://github.com/frictionlessdata/specs/issues/341) |
{: .table .table-striped .table-bordered style="display: block; overflow: auto;"}

### Tabular Data Package

Link to spec: [https://specs.frictionlessdata.io/tabular-data-package/](https://specs.frictionlessdata.io/data-package/)

Tabular Data Package is unchanged.

### Profiles

Profiles arrived in v1:

[http://specs.frictionlessdata.io/profiles/](http://specs.frictionlessdata.io/profiles/)

Profiles are the first step on supporting a rich ecosystem of "micro-schemas" for data. They provide a very simple way to quickly state that your data follows a specific structure and/or schema. From the docs:

> Different kinds of data need different formats for their data and metadata. To support these different data and metadata formats we need to extend and specialise the generic Data Package. These specialized types of Data Package (or Data Resource) are termed profiles.
>
> For example, there is a Tabular Data Package profile that specializes Data Packages specifically for tabular data. And there is a "Fiscal" Data Package profile designed for government financial data that includes requirements that certain columns are present in the data e.g. Amount or Date and that they contain data of certain types.

We think profiles are an easy, lightweight way to starting adding more structure to your data.

Profiles can be specified on both resources and packages.

[core-data]: https://github.com/datahq/datapackage-normalize-js
[specs]: https://specs.frictionlessdata.io/
[prev1]: https://pre-v1.frictionlessdata.io/
[normalization]: https://github.com/datahq/datapackage-normalize-js
[ghrepo]: https://github.com/frictionlessdata/specs/



## Automate upgrading your descriptor according to the spec v1

We have created a [data package normalization script][norm-script] that you can use to automate the process of upgrading a `datapackage.json` or Table Schema from pre-v1 to v1.

The script enables you to automate updating your `datapackage.json` for the following properties: `path`, `contributors`, `resources`, `sources` and `licenses`.

[norm-script]: https://github.com/datahq/datapackage-normalize-js

This is a simple script that you can download directly from here:

https://raw.githubusercontent.com/datahq/datapackage-normalize-js/master/normalize.js

e.g. using wget:
```bash
wget https://raw.githubusercontent.com/datahq/datapackage-normalize-js/master/normalize.js
```

```bash
# path (optional) is the path to datapackage.json
# if not provided looks in current directory
normalize.js [path]

# prints out updated datapackage.json
```

You can also use as a library:

```bash
# install it from npm
npm install datapackage-normalize
```

so you can use it in your javascript:

```javascript
const normalize = require('datapackage-normalize')

const path = 'path/to/datapackage.json'
normalize(path)
```

## Conclusion

The above summarizes the main changes for v1 of Data Package suite of specs and instructions on how to upgrade.

If you want to see specification for more details, please visit [Data Package specifications][specs]. You can also visit the [Frictionless Data initiative for more information about Data Packages][fd].

[fd]: http://frictionlessdata.io/

---
*This blog post was originally published on [datahub.io](http://datahub.io/) by Meiran Zhiyenbayev. Meiran works for [Datopian](https://datopian.com/) who have been developing datahub.io as part of the Frictionless Data initative*.
