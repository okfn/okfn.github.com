---
layout: post
author: Rufus Pollock
title: Web Scraping with CSS Selectors in Node using JSDOM or Cheerio
username: rgrp
---

I've traditionally used python for web scraping but I'd been increasingly thinking about using Node given that it is pure JS and therefore could be a more natural fit when getting info out of *web* pages.

In particular, when my first steps when looking to extract information from a website is to open up the Chrome Developer tools (or Firebug in Firefox) and try and extract information by inspecting the page and playing around in the console - the latter is especially attractive if jQuery is available.

What I often end up with from this is a few lines of jQuery selectors. My desire here was to find a way to directly reuse these same css selectors I use in my browser experimentation directly in the scraping script. Now, things like [pyquery][] do exist in python (and there is some css selector support in the brilliant BeautifulSoup) but a connection with something like Node seems even more natural - it is after the JS engine from a browser!

[pyquery]: http://packages.python.org/pyquery/

## UK Crime Data

My immediate motivation for this work was wanting to play around with the [UK Crime data][ukcrime] (all [open data][] now!).

To do this I needed to:

1. Get the data in consolidated form by scraping the file list and data files from <http://police.uk/data/> - while they commendably provide the data in bulk there is no single file to download, instead there is one file per force per month. 
2. Do data cleaning and analysis - this included some fun geo-conversion and csv parsing

I'm just going to talk about the first part in what folllows - though I hope to cover the second part in a follow up post.

I should also note that all the code used for scraping and working with this data can be found in the [UK Crime dataset data package on GitHub][code] on Github - [scrape.js file is here][scrape.js]. You can also see some of the ongoing results of these data experiments in an experimental [UK crime "dashboard" here][dashboard].

[ukcrime]: http://police.uk/data
[code]: https://github.com/datasets/crime-uk
[scrape.js]: https://github.com/datasets/crime-uk/blob/master/scripts/scrape.js
[open data]: http://opendefinition.org/
[dashboard]: http://okfnlabs.org/crime/

## Scraping using CSS Selectors in Node

Two options present themselves when doing simple scraping using css selectors in node.js:

* Using [jsdom][] (+ jquery)
* Using [cheerio][] (which provides jquery like access to html) + something to retrieve html (my preference is [request][] but you can just uses [node's built in http request][node-http])

[jsdom]: https://github.com/tmpvar/jsdom
[cheerio]: https://github.com/MatthewMueller/cheerio
[request]: https://github.com/mikeal/request
[node-http]: http://nodejs.org/docs/v0.6.11/api/http.html#http.request

For the UK crime work I used jsdom but I've subsequently used cheerio as it is substantially faster so I'll cover both here (I didn't discover cheerio until I'd started on the crime work!).

Here's an excerpted code example (full example in the [source file][scrape.js]):

{% highlight javascript %}
var url = 'http://police.uk/data';
// holder for results
var out = {
  'streets': []
}
jsdom.env({
  html: url,
  scripts: [
    'http://code.jquery.com/jquery.js'
  ],
  done: function(errors, window) {
    var $ = window.$;
    // find all the html links to the street zip files
    $('#downloads .months table tr td:nth-child(2) a').each(function(idx, elem) {
      // push the url (href attribute) onto the list
      out['streets'].push( $(elem).attr('href') );
    });
  });
});
{% endhighlight %}

As an example of Cheerio scraping here's an example from work [scraping info the EU's TED database][opented] (sample [html file][sample]):

[opented]: https://github.com/datasets/opented
[sample]: http://files.opented.org.s3.amazonaws.com/scraped/100120-2011/summary.html

{% highlight javascript %}
var url = 'http://files.opented.org.s3.amazonaws.com/scraped/100120-2011/summary.html';
// place to store results
var data = {};
// do the request using the request library
request(url, function(err, resp, body){
  $ = cheerio.load(body);

  data.winnerDetails = $('.txtmark .addr').html();

  $('.mlioccur .txtmark').each(function(i, html) {
    var spans = $(html).find('span');
    var span0 = $(spans[0]);
    if (span0.text() == 'Initial estimated total value of the contract ') {
      var amount = $(spans[4]).text()
      data.finalamount = cleanAmount(amount);
      data.initialamount = cleanAmount($(spans[1]).text());
    }
  });
});
{% endhighlight %}

