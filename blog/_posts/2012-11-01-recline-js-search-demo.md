---
layout: post
title: Recline JS Search Demo
author: Rufus Pollock
username: rgrp
---

<a href="http://reclinejs.com/"><img src="http://assets.okfn.org/p/recline/img/logo.png" style="float: right; height: 100px;" alt="Recline JS" /></a>

We've recently finished a demo for ReclineJS showing how it can be used to build
JS-based (ajax-style) search interfaces in minutes (or even seconds!):
<http://reclinejs.com/demos/search/>

Because of Recline's [pluggable backends][backends] you get out of the box
support for data sources such as SOLR, Google Spreadsheet, ElasticSearch, or
plain old JSON or CSV &ndash; see examples below for live examples of using
different backends.

[backends]: http://reclinejs.com/docs/backends.html

Interested in using this yourself? The [(prettified) source JS for the demo is
available][source-pretty] (plus the [raw version][raw]) and it shows how simple
it is to build an app like this using Recline &ndash; plus it has tips on how
to customize and extend).

[source-pretty]: http://reclinejs.com//docs/src/demo.search.app.html
[raw]: http://reclinejs.com/demos/search/demo.search.app.js

<a href="http://reclinejs.com/demos/search/"><img src="http://i.imgur.com/Ja8SV.png" alt="demo" style="width: 100%" /></a>

## More Examples

In addition to the simple example with local data there are several other
examples showing how one can use this with other data sources including Google
Docs and SOLR: 

1. A [search example using a google docs listing Shell Oil spills in the Niger
delta](http://reclinejs.com/demos/search/?backend=gdocs&url=https://docs.google.com/spreadsheet/ccc?key=0Aon3JiuouxLUdExXSTl2Y01xZEszOTBFZjVzcGtzVVE)

2. A [search example running of OpenSpending SOLR
API](http://reclinejs.com/demos/search/?backend=solr&url=http://openspending.org/api/search)
&ndash; we suggest searching for something interesting like "Drugs" or "Nuclear
power"!

## Code

The full [(prettified) source JS for the demo is available][source-pretty]
(plus the [raw version][raw]) but here's a key code sample to give a flavour:

{% highlight javascript %}
// ## Simple Search View
//
// This is a simple bespoke Backbone view for the Search. It Pulls together
// various Recline UI components and the central Dataset and Query (state)
// object
//
// It also provides simple support for customization e.g. of template for list of results
// 
//      var view = new SearchView({
//        el: $('some-element'),
//        model: dataset
//        // EITHER a mustache template (passed a JSON version of recline.Model.Record
//        // OR a function which receives a record in JSON form and returns html
//        template: mustache-template-or-function
//      });
var SearchView = Backbone.View.extend({
  initialize: function(options) {
    this.el = $(this.el);
    _.bindAll(this, 'render');
    this.recordTemplate = options.template;
    // Every time we do a search the recline.Dataset.records Backbone
    // collection will get reset. We want to re-render each time!
    this.model.records.bind('reset', this.render);
    this.templateResults = options.template;
  },

  // overall template for this view
  template: ' \
    <div class="controls"> \
      <div class="query-here"></div> \
    </div> \
    <div class="total"><h2><span></span> records found</h2></div> \
    <div class="body"> \
      <div class="sidebar"></div> \
      <div class="results"> \
        {{{results}}} \
      </div> \
    </div> \
    <div class="pager-here"></div> \
  ',
 
  // render the view
  render: function() {
    var results = '';
    if (_.isFunction(this.templateResults)) {
      var results = _.map(this.model.records.toJSON(), this.templateResults).join('\n');
    } else {
      // templateResults is just for one result ...
      var tmpl = '{{#records}}' + this.templateResults + '{{/records}}'; 
      var results = Mustache.render(tmpl, {
        records: this.model.records.toJSON()
      });
    }
    var html = Mustache.render(this.template, {
      results: results
    });
    this.el.html(html);

    // Set the total records found info
    this.el.find('.total span').text(this.model.recordCount);

    // ### Now setup all the extra mini-widgets
    // 
    // Facets, Pager, QueryEditor etc

    var view = new recline.View.FacetViewer({
      model: this.model
    });
    view.render();
    this.el.find('.sidebar').append(view.el);

    var pager = new recline.View.Pager({
      model: this.model.queryState
    });
    this.el.find('.pager-here').append(pager.el);

    var queryEditor = new recline.View.QueryEditor({
      model: this.model.queryState
    });
    this.el.find('.query-here').append(queryEditor.el);
  }
});

{% endhighlight %}

