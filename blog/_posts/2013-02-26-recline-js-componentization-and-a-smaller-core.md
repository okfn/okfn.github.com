---
layout: post
author: Rufus Pollock
title: Recline JS - Componentization and a Smaller Core
username: rgrp
---

Over time [Recline JS][r] has grown. In particular, since the first [public
announce of Recline][announce] last summer we've had several people producing
new backends and views (e.g.  [backends for Couch, a view for d3, a map view
based on Ordnance Survey's tiles etc etc][extensions]).

[r]: http://okfnlabs.org/recline/
[announce]: http://blog.okfn.org/2012/07/05/announcing-recline-js-a-javascript-library-for-building-data-applications-in-the-browser/
[extensions]: https://github.com/okfn/recline/wiki/Extensions#list-of-extensions

As [I wrote to the labs list recently][labs-post], continually adding these to
core Recline runs the risk of bloat. Instead, we think it's better to keep the
core lean and move more of these "extensions" out of core with a clear listing
and curation process - the design of Recline means that [new backends][be] and
[views][] can extend the core easily and without any complex dependencies.

[labs-post]: http://lists.okfn.org/pipermail/okfn-labs/2013-February/000638.html
[be]: http://okfnlabs.org/recline/docs/backends.html
[views]: http://okfnlabs.org/recline/docs/views.html

This approach is useful in other ways. For example, Recline backends are
designed to support standalone use as well as use with Recline core (they have
no dependency on *any* other part of Recline - *including core*) but this is
not very obvious as it stands (where the backend is bundled with Recline). To
take a concrete example, the Google Docs backend is a useful wrapper for the
Google Spreadsheets API in its own right. While this is already true, when this
code is in the main Recline repository it isn't very obvious but having the
repo split out with its own README would make this much clearer.

## So the plan is ...

* Announce this approach of a leaner core and more "Extensions"
  * Link to the specifications for [Backends][be] and [Views][views]
  * Create an official [Recline Extensions page][extensions]
* Identify first items to split out from core - see [this issue][2]
* Identify what components *should* remain in core? (I'm thinking Dataset +
  Memory DataStore plus one Grid, Graph and Map)

[extensions]: https://github.com/okfn/recline/wiki/Extensions
[2]: https://github.com/okfn/recline/issues/314

So far I've already started the process of factoring out some backends (and
soon views) into standalone repos, e.g. here's GDocs:

<https://github.com/okfn/recline.backend.gdocs>

Any thoughts very welcome and if you already have Recline extensions lurking in
your repos please add them to the [wiki page][extensions]

