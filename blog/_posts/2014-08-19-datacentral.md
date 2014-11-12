---
title: 'Data Central: a static frontend for data package collections'
author: Ricardo Lafuente
username: rlafuente
layout: post
projects: [frictionless-data]
---

[<img src="/img/posts/datacentral.png">](http://centraldedados.pt)

This post explains our issues at the Portuguese open data front when it
comes to providing bulk datasets in standard and easy-to-parse ways. It
also introduces [Data Central](https://github.com/centraldedados/datacentral), 
our tentative solution to those issues: a Python tool to
generate static web frontends for your data packages.


## First problem: Have a common format for storing datasets


At [Transparência Hackday Portugal][1], as with any other open data interest group,
we work with many datasets. An issue that has been slowing us down for a long
time is that we never had a centralized solution for storing datasets: some are
in Google Docs, others in Git repositories, others live on web servers. 

Before that, another issue was the data format: we found ourselves lost among
CSV or JSON files, SQL database dumps, spreadsheets and plaintext files.
Converting these was something we'd do in an ad hoc basis, and the challenge of
finding (or devising) a common format usually stumbled into differing personal
preferences and the difficulty involved in mass-conversion of heterogeneous
data collections.

## Solution: Tabular data packages

We stumbled almost accidentally into the [Data Package standards page][2]. It was a
revelation to see how elegant a solution this was to our format problems: using
the [Tabular Data Package][3] spec, we could go ahead and convert our datasets into
CSV, along with their metadata -- which is fairly easy to generate and maintain
using the existing tools for the job. From there, we can also develop scripts
to re-fetch and update the datasets, as well as post-processing tools to
generate other formats from the data package.

There is already much information available on Data Packages:

* the [Frictionless Data vision][4], which clearly lays out the problem and the
  proposed workflow to deal with heterogeneous sets of data
* the [Data Package][5] info page
* the [Tabular Data Package][6] info page, which is the format we use
* the comprehensive specifications for [Data Packages][7] and [Tabular Data Packages][8]
* many tools to manage and publish data packages at [data.okfn.org/tools][9]

So our common data format problem is now solved. We then faced another issue:
how to publish and distribute these datasets in an equally frictionless way.


## Second problem: Simple system to publish data packages

Something that we've also been missing was a central point from which to
distribute the datasets we have. Having a site to aggregate all of our data
packages would be a necessary step for some requirements we had:

* It would make hosting data workshops easier, by providing a quick way to 
  access bulk data instead of fumbling around with USB sticks, Google documents
  and Dropbox links.
* It'd make our efforts more visible, by aggregating all our work that is
  currently all over the place and presenting them in a simple manner.
* More importantly, it gives us an easier way to present our work in gathering
  and converting data, and a better argument to present to public entities for
  publishing their data: instead of saying "Give us your data so we can convert
  it and make it open", we can simply say "Give us your data so it can be
  available at OurGreatOpenDataPortal.pt". Having a separate "brand" makes
  things easier to explain -- and open data matters are involved enough to be
  able to hold people's attention.

There are existing solutions, such as [DataTank][10] or, more prominently, [CKAN][11]. So
why wouldn't CKAN be an option?

CKAN is a brilliant framework for hosting, managing and dealing with groups of
heterogeneous datasets. However, installing CKAN is an [involved process](http://docs.ckan.org/en/latest/maintaining/installing/index.html), and its
power comes at the cost of maintaining a full web application: it requires a
carefully configured server, doing regular updates, and ensuring server
resources are not going above a reasonable level. And since we're a small team,
we don't require most of its advanced features (like permissions). 

Finally, at Transparência Hackday we
have to manage many web applications already, and being too familiar with the
experience made us look for a simpler application design.


## Solution: Data Central, a static site generator for data package collections

We set out to design a simple application that could meet our purposes. The main
design principles are:

* *Enable access to bulk data sets*. Easy, straightforward access to
  the actual files is the main driver behind the current implementation. This
  differs from an API-driven approach which, while powerful, would require
  significant additional complexity.

* *Generated static HTML site* -- Publishing datasets doesn't need a real-time
  server-based application to query the data and show it. We would only need to
  update the site daily, at most, and we could then skip the server-side logic. 

* *Generate locally and upload* -- The site generation ought to happen locally.
  We decided to have one of our non-remote servers take care of the hard work of
  generating the site, and then upload it with rsync to a hosted service. 
  
* *Low hardware footprint* -- Local generation means that our system spec
  requirements are low. Not needing specialized hardware means that we can use
  an old computer for this task. It's actually what we do -- the site
  generation is being done on an old 2007 Sony Vaio laptop with a broken screen.

* *Separate the datasets from the site* -- By hosting each data package on a
  separate Git repository, the local generator could fetch it and re-generate
  the site without having to host and manage a separate copy of the data
  package and run the risk of both versions going out of sync. We found this
  happens often when building a database-driven web application. By separating
  the data packages and the web frontend, packagers and editors can work
  independently on the data, while the site generator updates the live version
  periodically.

* *Operated via the command line* -- For the sake of simplicity and at the cost
  of user-friendliness, we settled for a CLI-centered management workflow. We
  realised that managing this kind of site should be a mostly automated process,
  and an efficient way to do this would be to restrict the application to a set
  of scripts that can be managed through Makefiles and run by cron jobs.


There are some significant downsides to this direction, though.

* There is no API since it's all just HTML. This might be the most evident
  shortcoming of a static approach.

* This also means there are no search capabilities. One could always consider
  using a third-party search engine since the site is plain HTML that can be
  scraped by Google, DuckDuckGo and other web crawlers.

* There is no support for dynamic content, such as a site blog. Listing external
  feeds could be done through widgets in JavaScript.
 
* Since the application management is done locally through the command line,
  there isn't any web interface to make edits or changes inside the
  browser.

## How it works

The workflow goes like this:

  1. Data packages are published and updated on individual repositories by
     package maintainers.
  2. The Datacentral application is configured to become aware of which
     repositories it should track.
  3. The first run of the application clones all repositories and generates the
     HTML pages for each data package.
  4. Individual HTML pages (About, Contact) are generated from local Markdown
     files.
  5. The generated output can then be pushed through FTP or rsync to a remote,
     public web server.

In practice, there is a `generate.py` script that inspects each data package
and uses [Jinja][12] to fill up a set of HTML template files. It saves the generated
HTML in an `_output` directory, that can then be inspected using a local
webserver or pushed into a live VPS. All actions, from installation to generation and upload, can be carried out by means of a Makefile.

If you're interested in reading more about Data Central and even trying it out (it's simple!), [check out the project site][13]. We'd heartily welcome all possible feedback, so please let us know about any bugs, suggestions or feature requests at the Datacentral [issue tracker][14]. Finally, you can see it in action in our (in development) Portuguese independent data hub, [Central de Dados][15].


  [1]: http://transparenciahackday.org
  [2]: http://data.okfn.org/standards
  [3]: http://data.okfn.org/doc/tabular-data-package
  [4]: http://data.okfn.org/vision
  [5]: http://data.okfn.org/doc/data-package
  [6]: http://data.okfn.org/doc/tabular-data-package
  [7]: http://www.dataprotocols.org/data-packages/
  [8]: http://www.dataprotocols.org/simple-data-format/
  [9]: http://data.okfn.org/tools
  [10]: http://thedatatank.com
  [11]: http://ckan.org
  [12]: http://jinja.pocoo.org
  [13]: https://github.com/centraldedados/datacentral
  [14]: https://github.com/centraldedados/datacentral/issues
  [15]: http://centraldedados.pt
