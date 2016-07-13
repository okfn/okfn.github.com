---
title: Using Data Packages with R
username: dfowler
author: Dan Fowler
projects: [dpm,frictionless-data,mira]
---

R is a popular open-source programming language and platform for data
analysis.  *Frictionless Data* is an Open Knowledge International
project aimed at making it easy to publish and load *high-quality
data* into tools like R through the creation of a standard wrapper
format called the Data Package.

In this post, I will demonstrate an in-progress version of
**datapkg**, an R package that makes it easy to load Data Packages
into your R environment by automating otherwise manual import steps
using information provided in the Data Package descriptor file
`datapackage.json`.  datapkg was developed through a collaboration
between [Open Knowledge International][oki] and [rOpenSci][ropensci],
an organization that specializes in creating open-source tools using R
for advancing open science.

## Loading Tabular Data in R 

![R Logo](/img/posts/rlogo.png)

R's core strengths as a data analysis framework lie in its support for
a wide array of statistical tests, its straightforward, powerful
options for static visualization, and the ease with which its
functionality can be extended.  For these reasons, R enjoys a vibrant
online community who contribute daily to thousands of packages on
[CRAN][cran].  For this post, we will avoid going deep into what makes
R so powerful, and instead focus on the typical first step in any data
analysis project: loading source data.

When loading tabular data from a file into an R environment, it is
common to use the functions `read.csv` or `read.delim`.  These are
wrappers for the more generic `read.table` function that provide sane
defaults for reading from commonly formatted
[CSV](http://frictionlessdata.io/guides/csv/) and tab-delimited files,
respectively.  These commands read data into what's called a "data
frame", R's basic data structure for storing data tables.  In this
structure, each column ("vector") in the original tabular data file
may be assigned a different type (e.g. string, integer, date).

As a simple example, let's load a CSV file containing the
[CBOE Volatility Index][vix] using `read.csv()`.  First, we will set
our working directory to where I've stored my data and take a peek at
the files in the `data` subdirectory:

{% highlight r %}
setwd('/Users/dan/open_knowledge/datasets/finance-vix')
list.files("data")
{% endhighlight %}
   
    'vix-daily.csv'

We can read this single CSV, `vix-daily`, using R's `read.csv()`
function and assign its output to a data frame called
`volatility_raw`.  Afterwards, I can get a sample of the data by
viewing the first few rows of the file using the `head()` function.

{% highlight r %}
volatility_raw <- read.csv("data/vix-daily.csv")
head(volatility_raw)
{% endhighlight %}

<table>
<thead><tr><th></th><th scope="col">Date</th><th scope="col">VIXOpen</th><th scope="col">VIXHigh</th><th scope="col">VIXLow</th><th scope="col">VIXClose</th></tr></thead>
<tbody>
	<tr><th scope="row">1</th><td>1/2/2004</td><td>17.96   </td><td>18.68   </td><td>17.54   </td><td>18.22   </td></tr>
	<tr><th scope="row">2</th><td>1/5/2004</td><td>18.45   </td><td>18.49   </td><td>17.44   </td><td>17.49   </td></tr>
	<tr><th scope="row">3</th><td>1/6/2004</td><td>17.66   </td><td>17.67   </td><td>16.19   </td><td>16.73   </td></tr>
	<tr><th scope="row">4</th><td>1/7/2004</td><td>16.72   </td><td>16.75   </td><td>15.5    </td><td>15.5    </td></tr>
	<tr><th scope="row">5</th><td>1/8/2004</td><td>15.42   </td><td>15.68   </td><td>15.32   </td><td>15.61   </td></tr>
	<tr><th scope="row">6</th><td>1/9/2004</td><td>16.15   </td><td>16.88   </td><td>15.57   </td><td>16.75   </td></tr>
</tbody>
</table>



In the process of loading this data into a data frame, R made an
educated guess as to the types of data found in each column.  We can
display those types by looking at the the "structure" of an R object
using the `str` command.

{% highlight r %}
str(volatility_raw)
{% endhighlight %}

    'data.frame':	3122 obs. of  5 variables:
     $ Date    : Factor w/ 3122 levels "01/02/2014","01/02/2015",..: 543 644 652 659 666 672 493 501 508 515 ...
     $ VIXOpen : num  18 18.4 17.7 16.7 15.4 ...
     $ VIXHigh : num  18.7 18.5 17.7 16.8 15.7 ...
     $ VIXLow  : num  17.5 17.4 16.2 15.5 15.3 ...
     $ VIXClose: num  18.2 17.5 16.7 15.5 15.6 ...

We can see that while R has correctly guessed the types of `VIXOpen`,
`VIXHigh`, `VIXLow`, and `VIXClose` to be `num`, it has incorrectly
guessed the type of the `Date` to be `Factor`.  This is a problem
easily demonstrable by plotting the data.

{% highlight r %}
plot(volatility_raw$Date, volatility_raw$VIXOpen, type='l')
{% endhighlight %}

![Bad Type](/img/posts/r-vix-bad-type.png)

What should be the steadily increasing Date on the X axis is, instead,
out of order because the Date column is has not been assigned its
correct type.  In this very simple case, there is a straightforward
fix which is to manually re-assign the Date column (in our data frame
represented as `volatility_raw$Date`) to a type `Date` in the format
`%m/%d/%Y`.  We can revisit its structure using the `str()` command.

{% highlight r %}
volatility_raw$Date <- as.Date(volatility_raw$Date, "%m/%d/%Y")
str(volatility_raw)
{% endhighlight %}

    'data.frame':	3122 obs. of  5 variables:
     $ Date    : Date, format: "2004-01-02" "2004-01-05" ...
     $ VIXOpen : num  18 18.4 17.7 16.7 15.4 ...
     $ VIXHigh : num  18.7 18.5 17.7 16.8 15.7 ...
     $ VIXLow  : num  17.5 17.4 16.2 15.5 15.3 ...
     $ VIXClose: num  18.2 17.5 16.7 15.5 15.6 ...
     
We have successfully given the Date column a `Date` type, and we
should be able to run the same `plot()` function above and get a
better result.  While this is a good solution for this single dataset
with a single incorrectly guessed column, it doesn't scale well to
multiple incorrectly guessed columns across multiple datasets.  In
addition, it only represents one type of manual task to be performed
on a set of data.  We have designed the Data Package format to obviate
this, and other kinds of tedious "data wrangling" tasks.  In the next
section, we will perform the same task above using the `datapkg`
library.

## Loading Tabular Data Packages in R

A Data Package is a [specification][dp] for creating a
"[container][containerization]" for transporting data by
saving useful metadata in a specially formatted file.  This file is
called `datapackage.json`, and it is stored in the root of a directory
containing a given dataset.  When loading a Data Package,
[datapkg][datapkg], reads this extra metadata to conveniently load
high quality data into an R environment.

### Installing datapkg

*Note: the Data Package library for R is still in testing and subject
 to change.  For this reason, it is not yet on CRAN and must be
 installed from its [GitHub repository][datapkg] using the
 [devtools][devtools] package.*

To install in R:

{% highlight r %}
install.packages("devtools")
library(devtools)
install_github("hadley/readr")
install_github("ropenscilabs/jsonvalidate")
install_github("frictionlessdata/datapackage-r")
{% endhighlight %}

### Reading Data

Revisiting our data directory, we can examine the files in the root
using the `list.files()` function:

    'archive' 'data' 'datapackage.json' 'README.md' 'scripts'

The presence of the `datapackage.json` file indicates our current R
working directory is points to a Data Package, so we can use the
`datapkg_read()` function to read our Data Package (note: we can also
pass a path or URL to this function).  The `datapkg_read()` function
reads not only the data in the dataset, but also the metadata stored
with it.  This metadata includes high level information like the
author, the source, of the dataset.

{% highlight r %}
library(datapkg)
volatility <- datapkg_read()
{% endhighlight %}

We can inspect this information by reading various variables stored on
this object.  For instance, to get a fuller, human-readable title, we
can access `volatility$title` or, if the Data Package has a "homepage"
variable set, we can access it using `volatility$homepage`.

    'VIX - CBOE Volatility Index'
    'http://www.cboe.com/micro/VIX/'

`datapkg_read()` also uses *schema* information stored in the
`datapackage.json` to facilitate the loading of data.  As shown above,
one misstep when loading a new dataset into R is neglecting to correct
incorrectly guessed column types, for instance, giving a "Date" column
an appropriate type of `Date`.  What the Data Package format provides
is a simple, standard way to store that information with a dataset to
automate this and other steps.  The following snippet shows how the
`datapackage.json` descibes this information:

{% highlight js %}
      "schema": {
        "fields": [
          {
            "name": "Date",
            "type": "date",
            "format": "fmt:%m/%d/%Y"
          },
          {
            "name": "VIXOpen",
            "type": "number"
          },
          {
            "name": "VIXHigh",
            "type": "number"
          },
          {
            "name": "VIXLow",
            "type": "number"
          },
          {
            "name": "VIXClose",
            "type": "number"
          }
        ]
      }
{% endhighlight %}

We can verify that `datapkg_read()` used this information to construct
its data frame by calling the `str()` function below.  The `data`
variable on the `volatility` object points to a list of files
("resources") on the dataset; `vix-daily` is the name of the resource
we want.

{% highlight r %}
str(volatility$data$`vix-daily`)
{% endhighlight %}

    Classes ‘tbl_df’, ‘tbl’ and 'data.frame':	3122 obs. of  5 variables:
     $ Date    : Date, format: "2004-01-02" "2004-01-05" ...
     $ VIXOpen : num  18 18.4 17.7 16.7 15.4 ...
     $ VIXHigh : num  18.7 18.5 17.7 16.8 15.7 ...
     $ VIXLow  : num  17.5 17.4 16.2 15.5 15.3 ...
     $ VIXClose: num  18.2 17.5 16.7 15.5 15.6 ...

The output shows that the Date column has been set with the correct
type.  Because the type on the Date column has been set correctly, we
can immediately plot the data.

{% highlight r %}
vix.daily <- volatility$data$`vix-daily`
plot(vix.daily$Date, vix.daily$VIXOpen, type='l')
{% endhighlight %}

![Good Type](/img/posts/r-vix-good-type.png)

## Feedback 

This has been a very small example of some of the functionality of the
R library.

This software is still in testing, so if you are an R user and have
some feedback for us, let us know.  You can leave a comment here or
create an issue on the issue tracker.

To see a Jupyter notebook featuring the code in this post, click here: [nb]

[r]: https://www.r-project.org/
[jts]: http://specs.frictionlessdata.io/json-table-schema/
[dp]: http://frictionlessdata.io/data-packages/
[datapkg]: https://github.com/frictionlessdata/datapackage-r
[fd]: http://frictionlessdata.io/
[ropensci]: https://ropensci.org/
[oki]: https://okfn.org/
[previously-on]: /blog/2016/03/11/frictionless-data-transport-in-python.html
[cran]: https://cran.r-project.org/
[gh]: https://github.com/search?q=r&type=Repositories&utf8=✓
[vix]: https://en.wikipedia.org/wiki/VIX
[containerization]: http://frictionlessdata.io/about/#data-containerization
[devtools]: https://github.com/hadley/devtools
[r-user-story]: https://trello.com/c/CQV5Dk90/16-as-a-researcher-i-want-to-get-a-data-package-into-r-in-seconds-so-that-i-can-start-using-the-data-for-doing-analysis-and-visuali
