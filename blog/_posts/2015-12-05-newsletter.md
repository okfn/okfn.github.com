---
title: "Labs newsletter: Q4 2015"
author: Josh Wieder
username: jaydubya
layout: post
---

Hey there hackers & hackettes! Welcome to the 4th quarter 2015 Open Knowledge Labs Newsletter: A Very Special Holiday Edition of the Open Knowledge Labs Newsletter. We hope that all of our readers, volunteers, team members & contributors have a great holiday season. Labs is doing our part to keep things festive:
	
![Holiday computer](https://raw.githubusercontent.com/okfn/okfn.github.com/master/img/newsletter/xmas-computer.jpg)
	
Despite the hustle and bustle of the season, we are happy to report that Labs has made some serious progress with our existing projects and that we also have a few very cool tools to assist with your year-end data analysis.

### Tuttle - language, platform & version-control agnostic tool for collaborating on complex coding projects

Our very own @lexman (Alexandre Bonnasseau of mappy.com) was kind enough to provide Labs with a tool called [tuttle](https://github.com/lexman/tuttle) that should come in handy when submitting code for large projects.
	
@lexman does an excellent job describing the purpose of [tuttle](https://github.com/lexman/tuttle) in a [recent post to the Labs discussion site](https://discuss.okfn.org/t/a-tool-for-collaborating-on-datapackages/1397):
	
> "When we write scripts to create data, we don't make it right on the first time. How many times did you have to comment the beginning of a script, so that executions jumps directly to a bug fix? With tuttle, you won't have to. First, it computes only what is necessary : for example if a file has already been downloaded, it won't do it again. But also, when you change a line of code, tuttle knows exactly what data must be removed and what part of the code must be run instead."
	
Tuttle can be used to generate reports that generate workflows based on submission history and also highlight errors, as illustrated below (or in more detail [here](http://stuff.lexman.org/s-and-p-500/scripts/.tuttle/report.html)):

![Tuttle report 2](https://raw.githubusercontent.com/okfn/okfn.github.com/master/img/newsletter/tuttle-report-2.PNG)

@lexman provides a detailed (and incredibly helpful) [tutorial that helps acquaint new users with tuttle](https://github.com/lexman/tuttle/blob/master/doc/tutorial_musketeers/tutorial.md). We highly recommend giving the tutorial a try and using tuttle for complex development projects.
	
### Mira turns CSV files into an HTTP API	

[Mira](https://github.com/davbre/mira) is a new tool that comes to Labs from @davbre and is built using Ruby on Rails & relies on Postgres. [Mira](https://github.com/davbre/mira) allows users to generate an API using .json and .csv files - greatly simplifying what can often be a lengthy, tedious process. Here is how @davbre describes his utility:

> "This is a small application developed using Ruby-on-Rails. You upload a datapackage.json file to it along with the corresponding CSV files and it gives you a read-only HTTP API. It's pretty simple - it uses the metadata in the datapackage.json file to import each CSV file into its own database table. Once imported, various API endpoints become available for metadata and data. You can perform simple queries on the data, controlling the ordering, paging and variable selection. It also talks to the DataTables jQuery plug-in."
	
### Python data analysis library Agate has reached version 1.1

A new Python library has begun to come of age. [Agate](https://github.com/onyxfish/agate) was built by @onyxfish (NPR data journalist [Christopher Groskopf](https://source.opennews.org/en-US/people/christopher-groskopf/)) as an alternative to numpy and pandas. Whereas numpy and pandas were designed for scientists, Agate is designed with the needs of journalists in mind. Agate places a premium on ease of use and flexibility, even at the expense of performance optimazations present in other libraries. As @onyxfish puts it in [a post](https://source.opennews.org/en-US/articles/introducing-agate/) announcing the new version of Agate:
	
> "In greater depth, agate is a Python data analysis library in the vein of numpy or pandas, but with one crucial difference. Whereas those libraries optimize for the needs of scientists—namely, being incredibly fast when working with vast numerical datasets—agate instead optimizes for the performance of the human who is using it. That means stripping out those technical optimizations and instead focusing on designing code that is easy to learn, readable, and flexible enough to handle any weird data you throw at it."
	
Agate's leap from version 0.11.0 to version 1.0.0 on October 22nd of this year marked the [first major release](https://agate.readthedocs.org/en/1.1.0/changelog.html) for the up-and-coming library (version 1.1 was released November 4th). While Agate was fully functional at v0.11.0, the changes since then have been substantial. Among some of the more impressive additions:
	
- Agate can now be used as a drop-in replacement for Python’s csv module
- Migrated csvkit‘s unicode CSV reading/writing support into agate
- 100% test coverage reached
- Added support for Python 3.5
- Massive performance increases for joins.
- Dozens of other resolved issues ...

Agate has an impressive array of documentation for developers. Take a look at [the manual](https://agate.readthedocs.org/en/1.1.0/), the [standard tutorials](https://agate.readthedocs.org/en/1.1.0/tutorial.html), a tutorial for [using Agate with Jupyter notebook](http://nbviewer.ipython.org/urls/gist.githubusercontent.com/onyxfish/36f459dab02545cbdce3/raw/534698388e5c404996a7b570a7228283344adbb1/example.py.ipynb), the [Agate Cookbook](https://agate.readthedocs.org/en/1.1.0/cookbook.html) and the [Agate API documentation](https://agate.readthedocs.org/en/1.1.0/api.html).
	
Agate does indeed look promising, and there is an immense need for tools like it. Journalism is changing rapidly. With a flood of new information from Open Data advocates (like Open Knowledge) making their way to the newsroom, organizations that can effectively interpret that data will maintain a significant advantage over their competitors. Meanwhile, the public can only benefit from more accurate analysis of larger sets of information that impact their lives. Clearly, the need for analytics that were once only required at university now extends beyond the Ivory Tower.

### Webshot improvements

[Webshot](http://webshot.okfnlabs.org/) is a free, automated utility that allows for the generation of live screenshots. Screenshots serve an important role in demonstrating accountability (when content is removed, defaced or censored from the internet), but just as frequently are critical for troubleshooting & diagnostic services. There are many scenarios in which manually creating screenshots would not be feasible - because of routing issues, or because a screenshot needs to be generated at an exact time (Webshot can be called via an API).
	
The [Github page for Webshot](https://github.com/okfn/webshot/) includes not just the Webshot source code, but also a node-based web server with a default Heroku configuration. This enables users to spin up a fully functional Webshot instance using Heroku in just a few minutes, starting from scratch. Install the node package manager, create your heroku instance and push the configuration and you are all set!
	
When calling screenshots that have been generated by Webshot, the URLs reference the source website of the screenshot and allow for resizing of the image. Here are some examples from the Webshot documentation: 
	
	    http://localhost:5000/api/generate?url=google.com&width=500
	    http://localhost:5000/api/generate?url=google.com&height=300
	    http://localhost:5000/api/generate?url=google.com&width=200&height=400

Check out Webshot - and don't forget to [contribute to the project on Github](https://github.com/okfn/webshot/issues/)! 
	

### New tasks need your help within the Core Datasets Issue Registry
	
[Open Knowledge's Core Datasets](http://data.okfn.org/roadmap/core-datasets) are a selection of commonly-used datasets on a variety of topics that can be put to use for a variety of different research topics. All of the tools are free and available on Github - being able to find so many diverse, reliable and useful datasets in one place can save those of us who rely on open data a lot of time and hassle. Because so many people rely on these tools, submitting code to these tools allows your submissions to make a real and significant difference to projects all over the world. Here are some examples of the types of packages that are included:

- [geoip2](https://github.com/datasets/geoip2), a free IP geolocation database based on data from the [Geolite2 MaxMind databases](http://dev.maxmind.com/geoip/geoip2/geolite2/)
- [imf-weo](https://github.com/datasets/imf-weo), a copy of the [International Monetary Fund World Economic Outlook database](http://www.imf.org/external/ns/cs.aspx?id=28)
- [clinical-trials-us](https://github.com/datasets/clinical-trials-us), javascript-based tool listing official US clinical trial outcomes from the FDA, relies on data from [clinicaltrials.gov](http://clinicaltrials.gov/)
- [crime-uk](https://github.com/datasets/crime-uk), UK-specific crime data from multiple sources, including http://police.uk/data
- [browser-stats](https://github.com/datasets/browser-stats), a Python based tool that collects browser usage statistics trends, primarily gathered from [W3Schools log files](http://www.w3schools.com/browsers/browsers_stats.asp)
- and much more ...

Thanks in large part to @pdehaye, the new Core Datasets Managing Curator, there has been a flurry of new activity and project additions on the Core Datasets Issue Registry. Take a look at [the Issue Registry](https://github.com/datasets/registry/issues) for issues that you think you could help to resolve and start to tackle it! For example, [a thread has been created](https://github.com/datasets/registry/issues/122) for the [Big Mac Index Dataset](http://www.economist.com/content/big-mac-index). Don't know what a Big Mac Index is? Not a problem! You don't need to be an economist to write a script that will poll [the correct datasets](http://infographics.economist.com/2015/databank/BMfile2000-Jul2015.xls)(note: XLS file). If you want to help out, but aren't sure how to start or you're having trouble, browse the [easier issues](https://github.com/datasets/registry/issues?q=is%3Aopen+is%3Aissue+label%3A%22Difficulty%3A+easy%22) and leave a comment on the relevant thread! Also, be sure to let us know in a thread that you are working on a specific project to avoid duplicating effort. Now that you know all this, go get coding!	

### Labs establishes organizational structure, open positions still available

Labs continues to expand and attract interest from talented developers and all manner of smarty-pantses. With more people and more projects there is more responsibility and more to get done. To that end, Labs has begun to develop an organizational structure so that all of our team members can focus on what we are best at, to prevent duplication of efforts and to make communication easier and more effective. So far, the assigned positions are:
		
- @danfowler
  - Team Lead
- @loleg
  - Team Lead
- @mattfullerton
  - Team Lead
- @pdehaye
  - Core Datasets Managing Curator
- @davbre
  - Advisory Group Member
- @davidmiller
  - Advisory Group Member
- @jgkim
  - Advisory Group Member
- @jwieder
  - Advisory Group Member 
	
For more detailed information about each position, be sure to check out [this thread](https://github.com/okfn/okfn.github.com/issues/367). There are still positions available and a significant need for assistance from those with all sorts of different skills - leave a comment on the thread to let us know that you want to help step up to keep Labs growing!
	
### It's time to get involved

The New Year is a time for reflection of the year gone by and an opportunity to resolve to engage in good deeds for the year ahead. This year, OFKN Labs urges you to forget about silly New Years resolutions like more exercise or less carbs. Do something important with 2016 and **write more code**! The first thing to do is to make sure that you are a part of the Labs team by [signing up](http://okfnlabs.org/join/). Once you have joined the Labs community, check out [our Ideas page](http://okfnlabs.org/ideas/) or our [current Projects](http://okfnlabs.org/projects/) and find something that you would be interested in collaborating on. Do you have a plan for something we haven't though of yet? Tell us about it [on Twitter](https://twitter.com/intent/user?screen_name=OKFNLabs) or better yet jump on [the mailing list](http://okfnlabs.org/contact/).

For all of you already contributing to Labs: keep up the great work! Open Data is important, and your efforts continue to provide transparency for critical information. With your help, Labs will continue its success into 2016. See you then!
