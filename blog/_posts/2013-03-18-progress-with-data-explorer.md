---
layout: post
author: Rufus Pollock
title: Progress on the Data Explorer
username: rgrp
---

This is an update on progress with the [Data Explorer][de] (aka Data Transformer).

[de]: http://explorer.okfnlabs.org/

Progress is best seen from this [demo which takes you on a tour of house prices and the difference between real and nominal values](http://explorer.okfnlabs.org/#rgrp/e3e0b0f18dfe151f9f7e).

More information on recent developments can be found below. Feedback is *very welcome* - either here or the issues <https://github.com/okfn/dataexplorer>.

<a href="http://explorer.okfnlabs.org/#rgrp/e3e0b0f18dfe151f9f7e"><img src="http://i.imgur.com/WeDO0vK.png" alt="House prices tutorial" /></a>

## What is the Data Explorer

For those not familiar, the [Data Explorer is a HTML+JS app][de] to view, visualize and process data *just in the browser* (no backend!). It draws heavily on the [Recline library](http://okfnlabs.org/recline/) and features now include:

* Importing data from various sources (the UX of this could be much improved!)
* Viewing and visualizing using Recline to create grids, graphs and maps
* Cleaning and transforming data using a scripting component that allows you to write and run javascript
* Saving and sharing: everything you create (scripts, graphs etc) can be saved and then shared via public URL.

Note, that persistence (for sharing) is to Gists (here's the [gist for the House Prices demo linked above](https://gist.github.com/rgrp/e3e0b0f18dfe151f9f7e)). This has some nice benefits such as versioning; offline editing (clone the gist, edit and push); and bl.ocks.org-style ability to create a gist and have it result in public viewable output (though with substantial differences vs blocks ...).

## What's Next

There are many areas that could be worked on -- a full list of [issues is in github][2]. The most important I think at the moment are:

* [Storing the data "locally" in the data project][3]. At present, data is always loaded from an "external" source. This probably involves extending the current Recline datastore to back on to IndexedDB.
* A [better project creation & data import process][4] - I think we could learn a lot from Refine here
* ["Fork" support][5]
* More [documentation and tutorials especially for scripting][6]
* Getting rid of the many rough edges especially on the UX side of things!

I'd very interested in people's thoughts on the app so far and what should be done next and code contributions are also very welcome (the app has already benefitted from the efforts of many people including the likes of [Martin Keegan][] and [Michael Aufreiter][] to the app itself; and from folks like [Max Ogden][], [Friedrich Lindenberg][], [James Casbon][], [Gregor Aisch][], [Nigel Babu][] (and many more) in the form of ideas, feedback, work on Recline etc). 

[2]: https://github.com/okfn/dataexplorer/issues
[3]: https://github.com/okfn/dataexplorer/issues/88
[4]: https://github.com/okfn/dataexplorer/issues/60
[5]: https://github.com/okfn/dataexplorer/issues/84
[6]: https://github.com/okfn/dataexplorer/issues/52

[Martin Keegan]: http://mk.ucant.org/
[James Casbon]: http://casbon.me/
[Gregor Aisch]: http://driven-by-data.net/
[Max Ogden]: http://maxogden.com/
[Michael Aufreiter]: https://github.com/michael
[Friedrich Lindenberg]: http://pudo.org/
[Nigel Babu]: http://nigelb.me/

