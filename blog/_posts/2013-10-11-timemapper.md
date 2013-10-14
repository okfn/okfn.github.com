---
layout: post
author: Neil Ashton
title: Introducing TimeMapper - Create Elegant TimeMaps in Seconds
username: nmashton
---

[TimeMapper](http://timemapper.okfnlabs.org) lets you create elegant and embeddable timemaps quickly and easily from a simple spreadsheet.

<a href="http://timemapper.okfnlabs.org/okfn/medieval-philosophers"><img src="http://i.imgur.com/FmPTZlr.png" alt="Medieval philosophers timemap"></a>

A timemap is an interactive timeline whose items connect to a geomap. Creating a timemap with TimeMapper is as easy as filling in a spreadsheet template and copying its URL.

In this quick walkthrough, we'll learn how to recreate the [timemap of medieval philosophers](http://timemapper.okfnlabs.org/okfn/medieval-philosophers) shown above using TimeMapper.

## Getting started with TimeMapper

To get started, go to the [TimeMapper website][2] and sign in using your [Twitter][3] account. Then click **Create a new Timeline or TimeMap** to start a new project. As you'll see, it really is as easy as 1-2-3.

TimeMapper projects are generated from [Google Sheets](http://docs.google.com) spreadsheets. Each item on the timemap – an event, an individual, or anything else associated with a date (or two, for the start and end of a period) – is a spreadsheet row.

What can you put in the spreadsheet? Check out the [TimeMapper template](https://docs.google.com/a/okfn.org/spreadsheet/ccc?key=0AqR8dXc6Ji4JdFRNOTVYYTRqTmh6TUNNd3U2X2pKMGc#gid=0). It contains all of the columns that TimeMapper understands, plus a row of cells explaining what each of them means. Your timemap doesn't have to use all of these columns, though—it just requires a *Start* date, a *Title*, and a *Description* for each item, plus geographical coordinates for the map.

So you've put your data in a Google spreadsheet—how can you make it into a timemap? Easy! From Google Sheets, go to **File -> Publish to the web** and hit **Start publishing**. Then click on your sheet's **Share** button and set the sheet's visibility to *Anyone who has the link can **view***. You can either copy the URL from *Link to share* and paste that URL into the box in Step 2 of the TimeMapper creation process or click on **Select from Your Google Drive** to just browse to the sheet. Whichever you do, then hit **Connect and Publish**—and voilà!

![Share your spreadsheet](http://i.imgur.com/5SLOURu.png)

Embedding your new timemap is just as easy as creating it. Click on **Embed** in the top right corner. It will pop up a snippet of HTML which you can paste into your webpage to embed the timemap. And that's all it takes!

![Embed your timemap](http://i.imgur.com/3KWL6p6.png)

## Coming next

We have big plans for TimeMapper, including:

- Support for indicating size and time on the map
- Quickly create TimeMaps using information from Wikipedia
- Connect markers in maps to form a route
- Options for timeline- and map-only project layouts
- [Disqus](http://disqus.com)-based comments
- Core JS library, **timemapper.js**, so you can build your own apps with timemaps

Check out the [TimeMapper issues list](https://github.com/okfn/timemapper/issues) to see what ideas we’ve got and to leave suggestions.

## Code

In terms of the internals the app is a simple node.js app with storage into s3. The timemap visualization is pure JS built using KnightLabs excellent [Timeline.js][] for the timeline and [Leaflet][] (with OSM) for the maps. For those interested in the code it can be found at: <https://github.com/okfn/timemapper/>

[Timeline.js]: http://timeline.knightlab.com/
[Leaflet]: http://leafletjs.com/

## History and credits

TimeMapper is made possible by awesome open source libraries like [TimelineJS](http://timeline.verite.co), [Backbone](http://backbonejs.org), and [Leaflet](http://leafletjs.com), not to mention open data from [OpenStreetMap](http://www.openstreetmap.org). When we first built a TimeMapper-style site in 2007 under the title “Weaving History”, it was a real struggle over many months to build a responsive JavaScript-heavy app. Today, thanks to libraries like these and advances in browsers, it’s now a matter of weeks.

[2]:	http://timemapper.okfnlabs.org/
[3]:	http://twitter.com
