---
layout: post
author: Daniel Lombraña González
title: Exporting PyBossa data to CSV or JSON with one click
username: teleyinex
---

I'm really happy to announce that today we have finally added a feature that 
will allow to [export your data](http://docs.pybossa.com/en/latest/user/tutorial.html#exporting-the-obtained-results) into a CSV format with just one click
(we also support the same for JSON).

![](http://i.imgur.com/zqPkMST.png)

For this purpose, all the applications in PyBossa now feature a new URI:

> http://PYBOSSA-SERVER/app/slug/export

Where you will find several options to export the tasks or task runs (the answers)
to different formats. In the case of the CSV format, you will get a CSV file 
that could be downloaded to your computer to load it later in any spreadsheet 
software :-)

![](http://i.imgur.com/zVZCYW8.png)

**NOTE**: bear in mind that CSV is a flat format, so nested JSON objects will 
be "dumped" as they are, so for example if you are using GeoJSON for storing 
some location, you will get in the CSV file the JSON object as a string. 
You can see [an example of this issue in the Urban Parks application](http://crowdcrafting.org/app/urbanpark/export?type=task&format=csv), as this 
demo application uses the [GeoJSON](http://www.geojson.org/) format for storing the location of the parks. 

If you prefer JSON, just click in any of the buttons and save the generated file!

![](http://i.imgur.com/vBDWLeb.png)

If you want to try the new feature, just go ahead and check it in [CrowdCrafting.org](http://crowdcrafting.org)
