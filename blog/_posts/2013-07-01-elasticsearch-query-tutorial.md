---
layout: post
author: Rufus Pollock
title: Querying ElasticSearch - A Tutorial and Guide
username: rgrp
---

ElasticSearch is a great open-source search tool that's built on Lucene (like
SOLR) but is natively JSON + RESTful. Its been used quite a bit at the [Open
Knowledge Foundation][okfn] over the last few years. Plus, as its easy to
[setup locally][setup] its an attractive option for digging into data on your
local machine.

While its general interface is pretty natural, I must confess I've sometimes
struggled to find my way around ElasticSearch's powerful, but also quite
complex, query system and the associated JSON-based "[query DSL][]" (domain
specific language).

This post therefore provides a simple introduction and guide to querying
ElasticSearch that provides a short overview of how it all works together with
a good set of examples of some of the most standard queries.

* toc
{:toc}

[ElasticSearch]: http://elasticsearch.org/
[ElasticSearch client libraries]: http://www.elasticsearch.org/guide/appendix/clients.html
[okfn]: http://okfn.org/
[setup]: http://www.elasticsearch.org/guide/reference/setup/
[query DSL]: http://www.elasticsearch.org/guide/reference/query-dsl/

## Terminology and URLs

Throughout `{endpoint}` refers to the ElasticSearch [index type][estype] (aka
table). Note that ElasticSearch often let's you run the same queries on both
"[indexes][esindex]" (aka database) and types.

[estype]: http://www.elasticsearch.org/guide/reference/glossary/#type
[esindex]: http://www.elasticsearch.org/guide/reference/glossary/#index

If you were just using ElasticSearch standalone an example of an endpoint would be:
http://localhost:9200/gold-prices/monthly-price-table.

Key urls:

* Query: `{endpoint}/_search` (in ElasticSearch < 0.19 this will return an
  error if visited without a query parameter)

  * Query example: `{endpoint}/_search?size=5&pretty=true`

* Schema (Mapping): `{endpoint}/_mapping`


## Quickstart

### cURL (or Browser)

The following examples utilize the [cURL][] command line utility. If you prefer,
you you can just open the relevant urls in your browser:

{% highlight bash %}
    # query for documents / rows with title field containing 'jones'
    # added pretty=true to get the json results pretty printed
    curl {endpoint}/_search?q=title:jones&size=5&pretty=true
{% endhighlight %}

Adding some data:

{% highlight bash %}
    # Data (argument to -d) should be a JSON document
    curl -X POST  {endpoint} -d '{
      "title": "jones",
      "amount": 5.7
    }'
{% endhighlight %}

[cURL]: http://curl.haxx.se/

### Javascript

A simple ajax (JSONP) request to the data API using jQuery:

{% highlight javascript %}
    var data = {
      size: 5 // get 5 results
      q: 'title:jones' // query on the title field for 'jones'
    };
    $.ajax({
      url: {endpoint}/_search,
      dataType: 'jsonp',
      success: function(data) {
        alert('Total results found: ' + data.hits.total)
      }
    });
{% endhighlight %}

*Note: we've written a simple [JS library for ElasticSearch][jslib].*

[json2]: https://github.com/douglascrockford/JSON-js/blob/master/json2.js
[jslib]: https://github.com/okfn/elasticsearch.js

### Python

{% highlight python %}
    import urllib2
    import json

    # =================================
    # Store some data

    url = '{endpoint}'
    data = {
        'title': 'jones',
        'amount': 5.7
        }
    # have to send the data as JSON
    data = json.dumps(data)

    req = urllib2.Request(url, data, headers)
    out = urllib2.urlopen(req)
    print out.read()

    # =================================
    # Query the resulting "table"

    url = '{endpoint}/_search?q=title:jones&size=5'
    req = urllib2.Request(url)
    out = urllib2.urlopen(req)
    data = out.read()
    print data
    # returned data is JSON
    data = json.loads(data)
    # total number of results
    print data['hits']['total']
{% endhighlight %}

## Querying

### Basic Queries Using Only the Query String

Basic queries can be done using only query string parameters in the URL. For
example, the following searches for text 'hello' in any field in any document
and returns at most 5 results:

    {endpoint}/_search?q=hello&size=5

Basic queries like this have the advantage that they only involve accessing a
URL and thus, for example, can be performed just using any web browser.
However, this method is limited and does not give you access to most of the
more powerful query features.

Basic queries use the `q` query string parameter which supports the [Lucene
query parser syntax][] and hence filters on specific fields (e.g.
`fieldname:value`), wildcards (e.g. `abc*`) and more.

[Lucene query parser syntax]: http://lucene.apache.org/core/old_versioned_docs/versions/3_0_0/queryparsersyntax.html

There are a variety of other options (e.g. size, from etc) that you can also
specify to customize the query and its results. Full details can be found in
the [ElasticSearch URI request docs][].

[ElasticSearch URI request docs]: http://www.elasticsearch.org/guide/reference/api/search/uri-request.html

### Full Query API

More powerful and complex queries, including those that involve faceting and
statistical operations, should use the full ElasticSearch query language and API.

In the query language queries are written as a JSON structure and is then sent
to the query endpoint (details of the query langague below). There are two
options for how a query is sent to the search endpoint:

1. Either as the value of a source query parameter e.g.:

        {endpoint}/_search?source={Query-as-JSON}

2. Or in the request body, e.g.:

        curl -XGET {endpoint}/_search -d 'Query-as-JSON'

   For example:

        curl -XGET {endpoint}/_search -d '{
            "query" : {
                "term" : { "user": "kimchy" }
            }
        }'


## Query Language

Queries are JSON objects with the following structure (each of the main
sections has more detail below):

{% highlight javascript %}
    {
        size: # number of results to return (defaults to 10)
        from: # offset into results (defaults to 0)
        fields: # list of document fields that should be returned - http://elasticsearch.org/guide/reference/api/search/fields.html
        sort: # define sort order - see http://elasticsearch.org/guide/reference/api/search/sort.html

        query: {
            # "query" object following the Query DSL: http://elasticsearch.org/guide/reference/query-dsl/
            # details below
        },

        facets: {
            # facets specifications
            # Facets provide summary information about a particular field or fields in the data
        }

        # special case for situations where you want to apply filter/query to results but *not* to facets
        filter: {
            # filter objects
            # a filter is a simple "filter" (query) on a specific field.
            # Simple means e.g. checking against a specific value or range of values
        },
    }
{% endhighlight %}

Query results look like:

    {
        # some info about the query (which shards it used, how long it took etc)
        ...
        # the results
        hits: {
            total: # total number of matching documents
            hits: [
                # list of "hits" returned
                {
                    _id: # id of document
                    score: # the search index score
                    _source: {
                        # document 'source' (i.e. the original JSON document you sent to the index
                    }
                }
            ]
        }
        # facets if these were requested
        facets: {
            ...
        }
    }

### Query DSL: Overview

Query objects are built up of sub-components. These sub-components are either
basic or compound. Compound sub-components may contains other sub-components
while basic may not. Example:

    {
        "query": {
            # compound component
            "bool": {
                # compound component
                "must": {
                    # basic component
                    "term": {
                        "user": "jones"
                    }
                }
                # compound component
                "must_not": {
                    # basic component
                    "range" : {
                        "age" : {
                            "from" : 10,
                            "to" : 20
                        }
                    } 
                }
            }
        }
    }

In addition, and somewhat confusingly, ElasticSearch distinguishes between
sub-components that are "queries" and those that are "filters". Filters, are
really special kind of queries that are: mostly basic (though boolean
compounding is alllowed); limited to one field or operation and which, as such,
are especially performant.

Examples, of filters are (full list on RHS at the bottom of the [query-dsl][] page):

  * term: filter on a value for a field
  * range: filter for a field having a range of values (>=, <= etc)
  * geo_bbox: geo bounding box
  * geo_distance: geo distance

[query-dsl]: http://elasticsearch.org/guide/reference/query-dsl/

Rather than attempting to set out all the constraints and options of the
query-dsl we now offer a variety of examples.

### Examples

#### Match all / Find Everything

    {
        "query": {
            "match_all": {}
        }
    }

#### Classic Search-Box Style Full-Text Query

This will perform a full-text style query across all fields. The query string
supports the [Lucene query parser syntax][] and hence filters on specific fields
(e.g. `fieldname:value`), wildcards (e.g. `abc*`) as well as a variety of
options. For full details see the [query-string][] documentation.

    {
        "query": {
            "query_string": {
                "query": {query string}
            }
        }
    }

[query-string]: http://elasticsearch.org/guide/reference/query-dsl/query-string-query.html

#### Filter on One Field

    {
        "query": {
            "term": {
                {field-name}: {value}
            }
        }
    }

High performance equivalent using filters:

    {
        "query": {
            "constant_score": {
                "filter": {
                    "term": {
                        # note that value should be *lower-cased*
                        {field-name}: {value}
                    }
                }
            }
    }

#### Find all documents with value in a range

This can be used both for text ranges (e.g. A to Z), numeric ranges (10-20) and
for dates (ElasticSearch will converts dates to ISO 8601 format so you can
search as 1900-01-01 to 1920-02-03).

    {
        "query": {
            "constant_score": {
                "filter": {
                    "range": {
                        {field-name}: {
                            "from": {lower-value}
                            "to": {upper-value}
                        }
                    }
                }
            }
        }
    }

For more details see [range filters][].

[range filters]: http://elasticsearch.org/guide/reference/query-dsl/range-filter.html

#### Full-Text Query plus Filter on a Field

    {
        "query": {
            "query_string": {
                "query": {query string}
            },
            "term": {
                {field}: {value}
            }
        }
    }


#### Filter on two fields

Note that you cannot, unfortunately, have a simple `and` query by adding two
filters inside the query element. Instead you need an 'and' clause in a filter
(which in turn requires nesting in 'filtered'). You could also achieve the same
result here using a [bool query][].

[bool query]: http://elasticsearch.org/guide/reference/query-dsl/bool-query.html

    {
        "query": {
            "filtered": {
                "query": {
                    "match_all": {}
                },
                "filter": {
                    "and": [
                        {
                            "range" : {
                                "b" : { 
                                    "from" : 4, 
                                    "to" : "8"
                                }
                            },
                        },
                        {
                            "term": {
                                "a": "john"
                            }
                        }
                    ]
                }
            }
        }
    }

#### Geospatial Query to find results near a given point

This uses the [Geo Distance filter][]. It requires that indexed documents have
a field of [geo point type][].

[Geo Distance filter]: http://www.elasticsearch.org/guide/reference/query-dsl/geo-distance-filter.html
[geo point type]: http://www.elasticsearch.org/guide/reference/mapping/geo-point-type.html

Source data (a point in San Francisco!):

    # This should be in lat,lon order
    {
      ...
      "Location": "37.7809035011582, -122.412119695795"
    }
  
There are alternative formats to provide lon/lat locations e.g. (see
ElasticSearch documentation for more):

    # Note this must have lon,lat order (opposite of previous example!)
    {
      "Location":[-122.414753390488, 37.7762147914147]
    }

    # or ...
    {
      "Location": {
        "lon": -122.414753390488,
        "lat": 37.7762147914147
      }
    }

We also need a mapping to specify that Location field is of type geo_point as this will not usually get guessed from the data (see below for more on mappings):

    "properties": {
        "Location": {
            "type": "geo_point"
         }
         ...
    }

Now the actual query:

    {
        "query": {
            "filtered" : {
                "query" : {
                    "match_all" : {}
                },
                "filter" : {
                    "geo_distance" : {
                        "distance" : "20km",
                        "Location" : {
                            "lat" : 37.776,
                            "lon" : -122.41
                        }
                    }
                }
            }
        }
    }    

Note that you can specify the query using specific lat, lon attributes even
though original data did not have this structure (you can also use a query
similar to the original structure if you wish - see [Geo distance filter][] for
more information).


### Facets

Facets provide a way to get summary information about then data in an
elasticsearch table, for example counts of distinct values.

ElasticSearch (and hence the Data API) provides [rich faceting
capabilities][esfacets]. The [ES facet docs][esfacets] go a great job of listing of the various
kinds of facets available and their structure so I won't repeat it all here.
Here is a list of some of the most important (full list on the facets page):

* [Terms][] - counts by distinct terms (values) in a field
* [Range][] - counts for a given set of ranges in a field
* [Histogram][] and [Date Histogram][] - counts by constant interval ranges
* [Statistical][] - statistical summary of a field (mean, sum etc)
* [Terms Stats][] - statistical summary on one field (stats field) for distinct
  terms in another field. For example, spending stats per department or per
  region.
* [Geo Distance][]: counts by distance ranges from a given point

Note that you can apply multiple facets per query.

[esfacets]: http://www.elasticsearch.org/guide/reference/api/search/facets/
[Terms]: http://www.elasticsearch.org/guide/reference/api/search/facets/terms-facet.html
[Range]: http://www.elasticsearch.org/guide/reference/api/search/facets/range-facet.html
[Histogram]: http://www.elasticsearch.org/guide/reference/api/search/facets/histogram-facet.html
[Date Histogram]: http://www.elasticsearch.org/guide/reference/api/search/facets/date-histogram-facet.html
[Statistical]: http://www.elasticsearch.org/guide/reference/api/search/facets/statistical-facet.html
[Terms Stats]: http://www.elasticsearch.org/guide/reference/api/search/facets/terms-stats-facet.html
[Geo Distance]: http://www.elasticsearch.org/guide/reference/api/search/facets/geo-distance-facet.html


## Appendix

### Adding, Updating and Deleting Data

ElasticSeach, and hence the Data API, have a standard RESTful API. Thus:

    POST      {endpoint}         : INSERT
    PUT/POST  {endpoint}/{{id}}  : UPDATE (or INSERT)
    DELETE    {endpoint}/{{id}}  : DELETE

For more on INSERT and UPDATE see the [Index API][] documentation.

[Index API]: http://elasticsearch.org/guide/reference/api/index_.html

There is also support bulk insert and updates via the [Bulk API][].

[Bulk API]: http://elasticsearch.org/guide/reference/api/bulk.html


### Schema Mapping

As the ElasticSearch documentation states:

> Mapping is the process of defining how a document should be mapped to the
> Search Engine, including its searchable characteristics such as which fields
> are searchable and if/how they are tokenized. In ElasticSearch, an index may
> store documents of different “mapping types”. ElasticSearch allows one to
> associate multiple mapping definitions for each mapping type.

> Explicit mapping is defined on an index/type level. By default, there isn't a
> need to define an explicit mapping, since one is automatically created and
> registered when a new type or new field is introduced (with no performance
> overhead) and have sensible defaults. Only when the defaults need to be
> overridden must a mapping definition be provided.

Relevant docs: <http://elasticsearch.org/guide/reference/mapping/>.


### JSONP support

JSONP support is available on any request via a simple callback query string parameter:

    ?callback=my_callback_name

