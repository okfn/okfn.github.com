---
layout: post
author: Michael Bauer
title: Datapackageproxy - work with datapackages in your browser
username: mihi
---

[Datapackages](http://data.okfn.org/standards/data-package) are a neat idea
along the "using data like we use code" way. While Tryggvi has created a
nice [python module to handle datapackages](https://github.com/tryggvib/datapackage) - there is a problem
using datapackages in javascript. 

In an ideal world I'd just call something like ```d3.csv()``` on any csv
file on the web. Browser restrictions, however don't allow loading of
arbitrary files from arbitrary websites (for good reasons). To do so
anyway, you'll need to explicitly allow this. (read more on
[CORS](http://cors-enable.org). 

Datapackages are hosted on a variety of hosters and many don't support
CORS - thus we'll need to proxy them through a system that understand the
format and is CORS enabled: datapackageproxy.

Using datapackageproxy is simple. To access a resource of a package, simply
use:

```
http://datapackageproxy.appspot.com/resource?url=http://data.okfn.org/data/bond-yields-uk-10y
```

the optional id='' parameter allows specifying the id (though this is not
implemented yet). It will return the data as a csv. (so you can use it in
d3.csv()). To get the metadata (package definition) of a datapackage use:

```
http://datapackageproxy.appspot.com/metadata?url=http://data.okfn.org/data/bond-yields-uk-10y
```

The datapackageproxy is built on appspot - so if there is very heavy load,
it might go over usage limits. (If this happens, I'll try to either move it
or figure something else out...)

Find the code on [github](https://github.com/mihi-tr/datapackageproxy) -
and the proxy itself on [datapackageproxy.appspot.com](http://datapackageproxy.appspot.com)
