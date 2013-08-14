---
layout: post
author: Michael Bauer
title: ropenspending - accessing the OpenSpending API through R
username: mihi
---

Tonight a couple of us were having a discussion on the
[OpenSpending](http://openspending.org) IRC channel on how we can promote
and better document the usage of the API. Tony had already begun to work on
OpenSpending using [R](http://r-project.org). I had previously done so as
well. This prompted me to start out and create an R Package:
```ropenspending```. 

```ropenspending``` aims at making it easier to access the openspending API
from within R. It provides access to certain bits of the API - most
importantly the aggreagate function (through ```openspending.aggregate```).
While it is still in it's infancy, it is functional and can be obtained on
[github](http://github.com/mihi-tr/r-openspending). I'll work to push this
on CRAN as well (as soon as I figured out how to do this).
