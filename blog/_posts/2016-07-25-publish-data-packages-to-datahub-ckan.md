---
author: Dan Fowler
username: dfowler
title: "Publish Data Packages to DataHub (CKAN)"
projects: [dpm,frictionless-data,mira]
---

Back in March, I wrote about a CKAN extension for publishing and
exporting Data Packages[^1].  This extension, `datapackager`, has been
updated and is now **live** on our very own CKAN instance,
**DataHub**.  DataHub users can now import and export Data Packages
via the CKAN UI and API.  This post will show you how.

[![DataHub](/img/posts/datahub.png)][dh]

## DataHub and Data Packages

[DataHub][dh] is a free, powerful data management platform hosted by
Open Knowledge International.  It is powered by [CKAN][ckan], the
leading open-source data management system used by governments and
civic organizations
[around the world](http://ckan.org/instances/#)---including
[Data.gov](http://www.data.gov/) and
[data.gov.uk](https://data.gov.uk/).  In this post, I describe how to
load "Data Packages" onto DataHub to take advantage of CKAN's powerful
visualization and analytics features.

A [Data Package][dp] is a coherent collection of data, metadata, and
other assets.  Open Knowledge International is currently working on
[Frictionless Data][fd], a project aimed at creating an ecosystem for
*frictionless* data transport by defining the Data Package standard
and designing the tools and integrations that support them.  Given its
ubiquity as a data publishing platform, CKAN support is an important
part of this strategy.

## Importing a Data Package into DataHub.io

1. **Register on DataHub**: If you're not already a DataHub user, you
will need to [register for an account][register].  Once registered,
you will also need to [request an "organization"][request-org] via our
forum.  New datasets can only be loaded on DataHub if they are
associated with an organization.
1. **Create Your Data Package**: If you don't have your data in a Data
Package already, you can visit this
[online Data Package creator][dpist] or
[create a Data Package programmatically in Python][dpcreate].  If you
are just interested in trying out this demo, you should be able to
visit the [datasets organization][datasets] on GitHub and download any
of the repos as a zip file.
1. **Zip your Data Package**: If you created your Data
Package in the previous step,e create a new zip file from the Data
Package folder with the `datapackage.json` at the root.  If you are on
a Unix-type machine, you can usually run `zip -r
my-datapackage-to-import.zip <data package directory>`.  **Note**:
make sure your packaged data, unzipped, is **less than the 100MB**, as
this is current size limit on DataHub.
1. **Import your Data Package**: While signed in, click on
"Import Data Package" on [the dataset page][dsp], choose the
organization you created in Step 1, and upload the zipped Data Package
you created in the previous step.

Once your Data Package has been successfully imported, you should be
to use the dataset as you would any dataset on the DataHub.  This
includes adding or editing any of your dataset's metadata, or,
accessing the dataset using the [CKAN API][api].

### Screencast

This screencast walks through the import steps outlined above.

![Screencast][screencast-ui]

### Exporting a Data Package from DataHub.io

Exporting a Data Package from DataHub is even easier.  Just navigate
to the dataset you'd like to export, click on "Download Data Package",
and a `datapackage.json` file will be downloaded to your computer.
The JSON file will contain the Data Package representation of the
metadata stored on DataHub as well as links to the resources stored on
DataHub.

### CKAN Data Packager and Other Extensions

For information on importing and exporting data via the
[CKAN API][api] or, if you are interested in adding `datapackager` to
your own CKAN instance, you can read more on the extension
[repository][repo].

Of course, CKAN is not the only data repository software we are
looking to support.  A major aim of Frictionless Data is to create
integrations with the many different types of tools and platforms
people already use for working with data.  Visit our
[User Stories][us] page to learn about the kinds of use cases and data
workflows we're looking to support.  Let us know how you store your
data and what you would like to see next!

[frictionless-python]: /blog/2016/03/11/frictionless-data-transport-in-python.html
[ckan]: http://ckan.org/
[register]: https://datahub.io/user/register
[request-org]: https://discuss.okfn.org/t/creating-a-dataset-on-the-datahub/1627
[repo]: https://github.com/ckan/ckanext-datapackager
[screencast-ui]: https://github.com/ckan/ckanext-datapackager/raw/master/doc/images/ckanext-datapackager-import-demo.gif
[screencast-api]: https://asciinema.org/a/8jrpft2etpubte8jupfko8ci5
[dp]: http://frictionlessdata.io/guides/data-package
[ckan-logo]: /img/posts/ckan-logo-s.png
[dh]: https://datahub.io
[dsp]: https://datahub.io/dataset
[us]: http://frictionlessdata.io/user-stories/
[fd]: http://frictionlessdata.io/
[dpcreate]: http://frictionlessdata.io/guides/creating-tabular-data-packages-in-python/
[dpist]: http://datapackagist.okfnlabs.org/
[datasets]: https://github.com/datasets/
[api]: http://docs.ckan.org/en/latest/api/

[^1]: [Frictionless Data Transport in Python: 11 March 2016][frictionless-python]
