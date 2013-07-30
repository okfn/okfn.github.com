---
layout: post
author: Michael Bauer
title: Making puzzles out of Shapefiles - bringing Open Data to the physical world
username: mihi
---

For a while I've been thinking about how to make Open Data more tangible.
Even with great visualizations, it tends to remain stuck in computers and
smartphones. Recently, I had the idea to start taking geodata, released by
cities, and start making it into physical things. This is the first steps
and prototypes: Making a puzzle out of district borders.

![Shapefile Puzzle](http://farm6.staticflickr.com/5469/9380801297_dd91e4b99e_z_d.jpg)

Thanks to the [Open Week](http://openscience.alpine-geckos.at/events/open-week-graz-3/)
organized by [OKFN Austria](http://at.okfn.org) member [Stefan Kasberger](https://twitter.com/stefankasberger) 
I finally got the chance to put this idea into action. Here's what we did:

* First download the city boundaries as Shapefile
* Make sure it's WGS 84 EPSG 4326 formatted 
* Convert it to SVG using [kartograph.py](http://kartograph.org/about/kartograph.py/)
* Convert it to PDF - so the lazercutter can understand it
* Adopt the PDF for lazercutting (set line-widths to hairlines...)
* Cut!
* Try to assemble the puzzle

To make the process a little easier Stefan created a [script for converting shapefiles to svg](https://github.com/skasberger/lazzzor-puzzle)
with the data. 

![finished puzzle](http://farm6.staticflickr.com/5490/9383586970_99d359e228_z_d.jpg)

We created puzzles for both Vienna and Graz using district boundaries
released as Open Data.  Once done, we noticed that solving a district boundary puzzle is not as
easy as it seems... (even though the number of pieces are limited)
