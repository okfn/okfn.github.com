---
layout: post
author: Stefan Wehrmeyer
title: Bundes-Git – German Laws on GitHub
snapshot: bundesgit_intro
username: stwe
---

If you compare software code and legislation you can find many similarities: both are big bodies of text spread over multiple units (laws/files). The total amount of text inevitably grows bigger over time with many small changes to existing parts while most of the corpus stays the same.

However, the tooling and editing process for these domains is very different: while developers are in the fortunate position that they can build and improve their own tools, legislators are stuck with proprietary tools like MS Word that are simply not built to collaboratively work on a big corpus of text.

But if source code and laws have a similar information structure, why not apply the tools used in software development to the legislative process? That is what Bundes-Git ("Federal Git") is currently trying out in Germany.

[Bundes-Git](https://github.com/bundestag/gesetze) is a Git version control repository of all German Federal Laws and Regulations as Markdown. The goal was to come up with the simplest solution to handle laws that could possibly work and integrate it well into the existing developer ecosystem.

The idea has been well received with [an article on Wired.com](http://www.wired.com/wiredenterprise/2012/08/bundestag/) and articles on German IT news sites [Heise](http://www.heise.de/open/meldung/Entwicklungshistorie-von-Gesetzen-mit-Git-verfolgen-1662758.html) and [Golem](www.golem.de/news/bundesgit-ein-git-repository-fuer-deutsche-gesetze-1208-93709.html).

The popularity can surely also be attributed to our marvelous Bundes-Git mascot, dubbed octo eagle, thought up by myself and designed by [Konstantin Käfer](https://kkaefer.com/) released under [CC0](https://creativecommons.org/publicdomain/zero/1.0/) (please go this way if you are [interested in a t-shirt or hoodie](http://bundesgit.spreadshirt.de/)).

### Design decisions explained

All other law storage formats use XML. But to me XML is neither human readable nor human writable. Let me get into the details of some of the design decisions:

- **Git** because it's the most popular distributed version control system right now.
- **GitHub** because it's the most popular Git host right now and comes with some nice perks like Pull Request and GitHub Pages.
- **Markdown** because any more structure like XML or JSON would make it harder for humans to read or write the format and diffs would be difficult to read.
- Naming files `index.md` because it works nicely with **Jekyll and GitHub Pages** renders all laws into a currently very simple page.
- **YAML Front Matter** is necessary for Jekyll but also serves as nice a meta data store on laws.
- Committing from branches with non-fast-forward merges because... uhmm. This is really up for discussion. I want to keep track of where changes originate and branches are created for each law publication but this heavily diverts from the clean commit history philosophy that e.g. the Linux kernel lives by.

There are some more software development concepts that can be applied to the legislation process. Here are some fun things I'd like to try:

- A [prose.io](http://prose.io/)-like editor to easily create law proposals and make a pull request.
- Measuring the complexity of corpus/laws/paragraphs and using Travis CI to test pull requests if they make the complexity worse. [Pattern](http://www.clips.ua.ac.be/pages/pattern) is a Python NLP library and they recently released a [German module](http://www.clips.ua.ac.be/pages/pattern-de) which I want to try on our laws.
- Testing foreign key integrity: are all referenced paragraphs still available?
- Create an informative visualization out of the Git log automatically like [Gregor Aisch did by hand for the German political party law](http://blog.openingparliament.org/post/37650393621/what-opening-parliamentary-information-can-tell-us).
- Let the German president sign off on commits to master.

The design decisions around Bundes-Git fit nicely into the Git/GitHub eco system but they are not set in stone. They also create some problems and annoyances that need to be fixed or circumvented. While I believe the general philosophy and the freshness of the approach is the right direction, we clearly need more discussion.

### Future happenings around Bundes-Git:

- We applied for funding at [Testing 123 Global Integrity Innovation Fund](http://innovation.globalintegrity.org/idea-submissions/2012/12/10/applying-version-control-to-the-legislative-process). Bundes-Git definitely fits their criteria of brand new, innovative and high-risk. The decision will be made later this month, fingers crossed!
- I will talk at the [29th Chaos Communication Congress about Bundes-Git](http://events.ccc.de/congress/2012/Fahrplan/events/5263.en.html).
- There will be Bundes-Git Hacker Meetup in mid January. If you are interested, [sign up here](https://terminplaner.dfn.de/foodle.php?id=hhndrdx742az60wf).


We decided that the language of discussion on GitHub will be German, but feel free to start a conversation on the [OKF Open Legislation mailing list](http://lists.okfn.org/mailman/listinfo/open-legislation).

**Also be sure to follow [@bundesgit on Twitter](https://twitter.com/bundesgit)!**
