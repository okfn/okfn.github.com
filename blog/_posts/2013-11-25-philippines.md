---
title: "Looking at aid in the Philippines"
author: Mark Brough
username: markbrough
layout: post
---

*See also: "[A closer look at aid in the Philippines](http://www.publishwhatyoufund.org/updates/by-topic/techfortransparency/closer-look-aid-philippines/)"*

Since Typhoon Yolanda/Haiyan struck the Philippines on 8th November there has been some discussion around the availability of information to help coordinate activities effectively in the disaster response phase.

To see what data was already available, I put together [a quick projects browser](http://pwyf.github.io/philippines/), which generates a static site for all projects currently available in the Philippines that have been published to the [IATI Registry](http://iatiregistry.org), a CKAN instance for sharing aid information in the standard [IATI format](http://iatistandard.org).

[![Philippines projects browser](http://publishwhatyoufund.org/files/philippines-front-page.png)](http://pwyf.github.io/philippines/)

*Philippines Projects browser*

## Where the data comes from

IATI data is available in a standard XML schema, which makes it relatively easy to pull together quickly. However, with almost 200 publishers and over 3000 individual packages now published, searching for data for a single country would be complicated.

The [IATI datastore](http://iati-datastore.herokuapp.com) simplifies this task by pulling together all of the data published to the IATI Registry each night, and provides a queryable API for requesting results in CSV, XML or JSON format.

It was therefore possible to get all data for the Philippines by querying:

    http://iati-datastore.herokuapp.com/api/1/access/activity.json?recipient-country=PH&limit=50&offset=%s

... and then paging through the results (by increasing offset by 50 each time)

[![IATI Datastore](http://publishwhatyoufund.org/files/iati-datastore-front-page.png)](http://iati-datastore.herokuapp.com)

*The IATI Datastore*

**NB:** IATI was originally designed with a focus on traditional development aid, which is why the number of projects that specifically relate to the typhoon are limited. But the key concepts are mostly the same, which is why you do see some humanitarian aid in there.

## Creating a static site

I decided to create a static site so that:

1. I would not have to think about creating a database, or modelling the data;
2. I could deploy the site to Github pages, so I wouldn't have to think about server setup;
3. The site would run fast.

Ruby has some nice modules for creating static sites, such as [Jekyll](http://jekyllrb.com/) and particularly [Middleman](http://middlemanapp.com/) in this sort of context.

However, I wanted to write this one in Python, and unfortunately all of the [static site generators available in Python](http://gistpages.com/2013/08/12/complete_list_of_static_site_generators_for_python) come with a lot of assumptions about the structure of your site (basically, they all think it should look like a blog).

One exception (discovered via [this blogpost](https://nicolas.perriault.net/code/2012/dead-easy-yet-powerful-static-website-generator-with-flask/)) is [Frozen-Flask](http://packages.python.org/Frozen-Flask/). This is great because [Flask](http://flask.pocoo.org/) is super simple and easy to work with, and provides a lot of the stuff you need out of the box.

In this instance, all I had to do was add the lines:

	app.config['FREEZER_RELATIVE_URLS'] = True
	freezer = Freezer(app)

and then to generate a static site, which is output to `/build`:

    freezer.freeze()

Frozen-Flask wants to set all of the URLs as absolute and beginning with `/`. Because I'm deploying to Github pages, I need to be able to have relative URLs. Frozen-Flask provides [an option to do that](http://pythonhosted.org/Frozen-Flask/#configuration) with `FREEZER_RELATIVE_URLS`, but the weird side effect of this is that all the URLs have to end with `index.html`.

## What's next?

Firstly, **it would be great to get more data in there**. The projects browser can be updated automatically each night by pulling the data in from the datastore -- something I'm going to try and get set up in the next couple of days. 

However, with a couple of exceptions (particularly GlobalGiving and UNOCHA FTS), in general IATI publishers update their data a maximum of once a month. The projects browser suggests that may not be frequent enough in this sort of situation. Additionally, it is somewhat difficult to see which projects are related to this crisis as opposed to previous earthquakes and typhoons in the region (or alternatively, development rather than humanitarian activities). Some discussions have begun about adding an extension to IATI to capture additional fields that might be relevant to humanitarian actors, for example to tag a project as related to the Haiyan response.

Secondly, **the interface could be improved somewhat**. Some other ways of filtering and searching through the data would be useful, and improving the performance of the existing filter would be sensible.

## Let me know what you think!

* Email: [mark.brough@publishwhatyoufund.org](mailto:mark.brough@publishwhatyoufund.org)
* Tweet: [@mark_brough](http://twitter.com/mark_brough) or [@aidtransparency](http://twitter.com/aidtransparency)
* Source code: [http://github.com/pwyf/philippines](http://github.com/pwyf/philippines)
* Live site: [http://pwyf.github.io/philippines]([http://pwyf.github.io/philippines)
