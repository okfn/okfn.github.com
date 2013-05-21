---
layout: post
author: Daniel Lombraña González
title: Mozilla FirefoxOS App Days & Crowdcrafting.org
snapshot: firefoxosappdays
username: teleyinex
---
<img class="pull-left" src="https://hacks.mozilla.org/wp-content/uploads/2012/12/firefoxOS-app-days_graphic_RGB.png"/>
Last Saturday, the 26th of January, [Mozilla held in parallel in 25 cities all over the world a hack day](https://hacks.mozilla.org/2013/01/join-us-for-firefox-os-app-days/), the [#FirefoxOSAppDay](https://twitter.com/search?q=%23firefoxosappdays&amp;src=tyah), about creating new web applications for their new [FirefoxOS mobile OS](http://www.mozilla.org/en-US/firefoxos/) and the desktop web browser (this stills in beta and alpha mode!).

One of the events was held in Madrid, Spain, organized by the [Mozilla Hispano Community](http://www.mozilla-hispano.org/) so I had the chance to expend some time with the Mozilla community and play with the [new APIs and developer tools for their new platform](https://developer.mozilla.org/en/docs/Mozilla/Firefox_OS).

<img class="pull-right" src="http://mozorg.cdn.mozilla.net/media/img/firefoxos/firefox-phone.png"/>

In the morning we attend several talks by several experts on the new APIs that
Mozilla are developing to integrate mobile actions like for example the [battery
API](http://www.w3.org/TR/battery-status/) that will allow you to check the 
device battery status (right now integrated in the W3C standards) or the [Alarm
API](https://wiki.mozilla.org/WebAPI/AlarmAPI) that you can use to schedule a 
notification, or for an application to be started, at a specific time. 

Mozilla is working really hard to standardize and integrate most of [these APIs](https://wiki.mozilla.org/WebAPI) into the W3C in order to make them available in any web browser. Some of the APIs are actually now accepted in the W3C as for example the [Battery Status API](http://dvcs.w3.org/hg/dap/raw-file/tip/battery/Overview.html), [Network Information API](http://dvcs.w3.org/hg/dap/raw-file/tip/network-api/index.html), [Ambient light sensor](http://www.w3.org/TR/ambient-light/) or the [Proximity sensor](http://www.w3.org/TR/2012/WD-proximity-20120712/).

Mozilla also presented their efforts in making as easy as possible to create an
application from scratch re-using several [building-blocks](http://buildingfirefoxos.com/) 
they have created for their new platform. Basically, they have created [a web page](http://buildingfirefoxos.com/) where you can copy and paste code snippets that you can later re-use in your own application,
keeping the look and feel of the platform.

After the talks, all the participants had a better idea of what we could
develop with the platform: a web application that could use the hardware of the
new mobile phone devices, as well as Android phones out of the box!

As the goal of the day was to create an app for the FirefoxOS, my idea was to create an application that could help to track when a new scientific application has been added to <a href="http://crowdcrafting.org"><strong>crowd</strong>crafting</a> so you could help doing some tasks in the new application.

The web application basically lets you know which apps are new since the last time you check it out.

The application works in any web browser (even Chrome) but if you want to feel how it will be in the new OS you can try it in your phone if you have an Android device. You will need to install the <a href="http://nightly.mozilla.org/">latest Firefox nightly</a> (<strong>note: </strong><em>this is an experimental build, so it may crash in your phone!</em>) and then type this URL:

[http://daniellombrana.es/crowdcrafting-app](http://daniellombrana.es/crowdcrafting-app)

You will be able to install it in your phone and run it whenever you want directly from your home screen. If you don't want to install the browser, just open the link with a modern web browser and you should see it running (the install button will only work in <a href="http://www.mozilla.org/en-US/firefox/channel/">Firefox Beta</a> and <a href="http://www.mozilla.org/en-US/firefox/channel/#aurora">Aurora builds</a>).

![FirefoxOS Crowdcrafting app](http://i.imgur.com/xjljFcc.png)
