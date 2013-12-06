---
layout: post
author: Michael Bauer
title: Introducing Reconcile-CSV
username: mihi
---

Recently I spent a week in Tanzania working on education data with the
ministry of education ([blog post
here](http://schoolofdata.org/2013/12/06/a-deep-dive-into-fuzzy-matching-in-tanzania/)).
One of the problems we faced there were spreadsheets, we liked to merge,
without having any unique IDs. I quickly realized we can do this through
reconciliation services in [OpenRefine](http://openrefine.org). The API and
some projects implementing the reconciliation service are described in the
[OpenRefine
wiki](https://github.com/OpenRefine/OpenRefine/wiki/Reconciliation-Service-API).
Nevertheless, most of the projects had a ton of requirements or need  a
database.

I wanted a service that is:

* easy to install and run
* works on top of a CSV file

Because I love [Clojure](http://clojure.org) and I already had a
[fuzzy-matching library](https://github.com/mihi-tr/fuzzy-string) at hand,
I chose to go down that route. Clojure has the great advantage of being
able to generate .jar files including all the dependencies. - thus running
the service is a matter of executing a .jar file.

All that was left was implementing the reconciliation API around it. I am
proudly introducing [reconcile-csv](http://okfnlabs.org/reconcile-csv) - a
reconciliation service, running on your machine without much hassle. See
[http://okfnlabs.org/reconcile-csv](http://okfnlabs.org/reconcile-csv) for
more details and instructions.

While this might not be the first reconciliation service to be written - I
do think by now it's the easiest to use: you'll only need java, a CSV file
and the .jar provided. 
