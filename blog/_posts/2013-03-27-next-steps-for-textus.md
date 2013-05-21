---
layout: post
author: Sam Leon
title: Next Steps for Textus
username: noelmas
---

At the Culture Labs hangout yesterday we wrote up the plans for the next steps for Textus we have been discussing over the last few months.

The result is this slide deck overview. It both introduces Textus and outlines next steps (slide 12 onwards).

<iframe src="https://docs.google.com/presentation/d/1OlXIaGgntenmBLNMu0tZYTdrP09TvzZ-R5bpJAgznF4/embed?start=false&loop=false&delayms=3000" frameborder="0" width="580" height="464" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true"></iframe>

## Key Points

We want to:

- Maximize simplicity
- Connect with a CMS (people always want other content than just the texts)

Implications are:

- Componentize "Textus" and separate text preparation / import from presentation
- Create a plugin to make "Textus" style functionality one-click install into Wordpress
- Eliminate dependencies on ElasticSearch & NodeJS (texts & markup stored in plain files online or in WP ...)

Specifically, we plan to break Textus into 3 components:

* [textus-formatter][formatter] - nodejs app/command line tool for formatting texts
* textus-viewer - JS-only viewer
* textus-wordpress - wordpress integration

<img src="https://docs.google.com/drawings/d/1S9Hv98LWdcfuG3KjF1qELsZBp-RQ08Ylo3gxaO6tyQg/pub?w=960&amp;h=720" alt="" title="New Architecture" />

[formatter]: https://github.com/CultureLabs/textus-formatter
[viewer]: https://github.com/CultureLabs/textus-viewer
[wordpress]: https://github.com/CultureLabs/textus-wordpress


