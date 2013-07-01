---
layout: post
author: Neil Ashton
title: Basic data cleaning with Data Explorer
username: nmashton
---

[Data Explorer][dataexplorer] is a client-side web application for
data processing and visualization. With Data Explorer, you can import data,
transform it with JavaScript code, and visualize it on a graph or a map – all
fully within the browser and with your data and code nicely persisted to
[gists][].

[gists]: https://gist.github.com/

This tutorial will get you started using Data Explorer by walking you through
the cleaning of a messy data set. It introduces some of the basic concepts of
the [Recline][recline] library which provides Data Explorer's model of data
and highlights why it's nice to be able to use JavaScript to wrangle data.

[dataexplorer]: http://explorer.okfnlabs.org/
[recline]: http://okfnlabs.org/recline/
[exchange]: https://github.com/okfn/dataexplorer/issues/127

## Getting started

For this tutorial, we're going to use a set of [Greater London Authority (GLA) financial data][dataset],
a report of payments made by the GLA for property worth more than £250 over a one-month
period in 2013. Conveniently for our purposes, this dataset is a little buggy.

[dataset]: http://static.london.gov.uk/gla/expenditure/docs/2012-13-P12-250.csv

To get started, go to the [Data Explorer][dataexplorer] website, and click **Get
started with your own data** to proceed to the *Import* page. From there, you will be
able to load the data in a number of ways: uploading a local file, pasting in a URL, or
pasting the data itself into a text box. Choose your preferred method and hit the appropriate
**Load** button, which will take you to the *Preview & Save* page.

The *Preview* shows what the data will look like as a grid. Already some
fiddling is necessary to get things started. The row containing the names of fields is six rows
down, and the fields are all nameless – except for one with an erroneous name! To fix this,
change the **Skip initial rows** value to 6.

You can also see that there is a blank column, but you can't do anything about this yet.
Just choose a name for the dataset, click **Save**, and move on to actually working with the data.


## The grid and the graph

Once the data has been loaded and named, you are taken to the Data Explorer proper. Your
first view of the data will be the **Grid**, a tabular display identical to what was already
shown in the *Preview* screen.

![The initial grid](http://i.imgur.com/B48sGc9.png)

Data visualizations are constructed with the **Graph**. Let's try to make a graph
of the data. Click **Graph** to go to the graph screen, which will ask you to choose
which of the data's fields to bind to the two axes, Axis 1 (= x) and Axis 2 (= y). First
change the Graph Type to **Points**. Then, for Group Column, choose "Clearing Date", and
for Series A, choose "Amount". You should get a graph that looks like this.

![First graph](http://i.imgur.com/NDPFkLN.png)

This graph is useless. There are no points with an Amount higher than about £990.
A quick look at the grid will tell you that in fact many points have Amounts
running into the millions of pounds. Also note that the x axis is completely unlabeled. If you scan
your cursor over the data points, which displays their underlying value, you'll see that
their horizontal arrangement is meaningless.

The problem is that the dataset is formatted badly. All of the values in the Amounts field
that run higher than £999.99 include a comma, which prevents them from being parsed as
numbers. The dates, too, are not being treated as dates but just as ordinary strings,
making it impossible to put them on a scale.

To fix these problems, we'll write some code. Roll up your sleeves and get ready.


## Basics of DE coding

To pull up Data Explorer's tool for editing and running JavaScript code, click **Code**
at the top right of the page. This will cause the **JavaScript console** to drop down.
This console consists of a panel for editing code and, beneath it, an area where
messages are printed.

A bit of code is included in the edit panel by default:

    loadDataset("current", function (error, dataset) {
      // error will be null unless there is an error
      // dataset is a Recline memory store (http://reclinejs.com//docs/src/backend.memory.html).
      console.log(dataset);
    });

This code loads up the current dataset by calling the function `loadDataset`
on the string `"current"` (the name of the current dataset) and an anonymous
callback function which binds a representation of the dataset to the name `dataset`.
The callback function, as defined, prints the dataset to the console's
message area by calling `console.log` on `dataset`.
Watch this code work by clicking **Run the Code**.

The console output might surprise you. The dataset is represented as a JavaScript
object with attributes `"records"` and `"fields"`, the first of which is an array
of objects with attributes for each of the top-level object's `"fields"`. This is
an instance of the [Recline memory store][memorystore]. A dataset is a collection
of records, and a record is just an object.

[memorystore]: http://reclinejs.com//docs/src/backend.memory.html

If you understand that, you're ready to clean the dataset.


## Cleaning with JavaScript

The full gamut of JavaScript tools and tricks are available to you when you
clean data in Data Explorer. Besides handy core JavaScript functionality like
regular expressions, Data Explorer makes the [Underscore.js](http://underscorejs.org)
suite of functional programming utilities available for data cleaning.

To clean a dataset, write code inside a `loadDataset` call that modifies the dataset
in the appropriate way, and finish by calling `saveDataset` on the modified dataset.
All code presented in this section is to be placed inside the curly brackets of the `loadDataset`
callback function.

Let's start by getting rid of that annoying blank column we noticed earlier. To do this,
we have to delete `_noname_` from the dataset's fields. We must also drop the `_noname_`
attribute from every record in the dataset.

To get rid of the bad field, set the dataset's field attribute to be the old value
of the attribute minus the field named `"_noname_"`.

    dataset.fields = 
      _.reject(dataset.fields,
               function (f) {
                 return f.id === "_noname_";
               }) ;

Erasing the bad field from each record can be done with an application of `each`,
which calls a function with side effects on each item in a collection.

    _.each(dataset.records,
           function (r) {
             delete r._noname_ ;
           }) ;

Now let's look at the next problem: the unparsed Amounts with commas. To fix these,
we need to eliminate the commas and then parse the resulting string as a float.
Since we're already iterating over every record in the dataset, we can add to the
anonymous function in the `each` call:

    if (typeof r.Amount === "string") {
      r.Amount = parseFloat(r.Amount.replace(/,/g, "")) ;
    }

Finally, we can fix the dates. There are two problems with these. The first is that
the Recline dataset object needs to know that the type of their field is *date*.
The second is that the dates haven't been parsed. To fix the first problem, add
to the `loadDataset` callback function:

    _.find(dataset.fields,
           function (f) {
             return f.id === "Clearing Date" ;
           })
     .type = "date" ;

Next, add another bit to the anonymous function in `each`:

    if (typeof r["Clearing Date"] === "string") {
      r["Clearing Date"] = new Date(r["Clearing Date"]) ;
    }

That's it! All that remains is to save the modified dataset. At the bottom of
the `loadDataset` callback function, add a line to save the data:

    saveDataset(dataset) ;

Click **Run the Code** and watch the data transform before your very eyes.
The new graph view of the data is now meaningful, correct, and fully consistent
with your expectations. Awesome!

![Fixed graph](http://i.imgur.com/Bl1cxL8.png)

You can also have another look at the grid, which will show you exactly what
has changed in your data.

![Final grid](http://i.imgur.com/WfQxGdV.png)

If you have logged in to GitHub, you will be able to save the result of your
work. To share the work, simply copy the URL of your project. An example of
a project constructed according to the instructions above can be found [here][project].

[project]: http://explorer.okfnlabs.org/#nmashton/e4f4ab6a21471e1aa1b8/view/graph


## Conclusion

With Data Explorer, the full power of arbitrary JavaScript code (enhanced
with Underscore functionality) can be brought to bear on tough data cleaning
problems. The cleaning script's effects are immediately visible in the grid
and graph views of the data, which enables an easy, interactive style of data
cleaning. And it is all done without a backend, in memory and in the browser.



