---
layout: post
author: Rufus Pollock
title: Archiving Twitter the Hacky Way
username: rgrp
---

There are many circumstances where you want to archive a tweets - maybe just from your own account or perhaps for a hashtag for an event or topic.

Unfortunately Twitter search queries do not give data more than 7 days old and for a given account you can only get approximately the last 3200 of your tweets and 800 items from your timeline. [Update: People have pointed out that [Twitter released a feature to download an archive of your personal tweets at the end of December](http://blog.twitter.com/2012/12/your-twitter-archive.html) - this, of course, still doesn't help with queries or hashtags]

Thus, if you want to archive twitter you'll need to come up with another solution (or pay them, or a reseller, a bunch of money - see Appendix below!). Sadly, most of the online solutions have tended to disappear or be acquired over time (e.g. twapperkeeper). So a DIY solution would be attractive. After reading various proposals on the web I've found the following to work pretty well (but see also this [excellent google spreadsheet based solution][1]).

The proposed process involves 3 steps:

[1]: http://mashe.hawksey.info/2012/01/twitter-archive-tagsv3/

1. Locate the Twitter Atom Feed for your Search
2. Use Google Reader as your Archiver
3. Get your data out of Google Reader (a 1000 items at a time!)

One current drawback of this solution is that each stage has to be done by hand. It could be possible to automate more of this, and especially the important third step, if I could work out how to do more with the [Google Reader API][api-docs]. Contributions or suggestions here would be very welcome!

[api-docs]: http://undoc.in/

***Note that the above method will become obsolete as of March 5 2013 when [Twitter close down RSS and Atom feeds][twitter-shutdown] - continuing their long march to becoming a <del>fully</del> more closed and controlled ecosystem.***

***As you struggle, like me, to get precious archival information out of Twitter it may be worth reflecting on just how much information you've given to Twitter that you are now unable to retrieve (at least without paying) ...***

[twitter-shutdown]: https://dev.twitter.com/docs/api/1.1/overview#New_Twitter_client_policies

## Twitter Atom Feed

Twitter still have Atom feeds for their search queries:

<http://search.twitter.com/search.atom?q=my_search>

Note that if you want to search for a hash tag like #OpenData or a user e.g. @someone you'll need to escape the symbols:

<http://search.twitter.com/search.atom?q=%23OpenData>

Unfortunately twitter atom queries are limited to only a few items (around 20) so we'll need to continuously archive that feed to get full coverage.

## Archiving in Google Reader

Just add the previous feed URL in your Google Reader account. It will then start archiving.

Aside: because the twitter atom feed is limited to a small number of items and the check in google reader only happens every 3 hours (1h if someone else is archiving the same feed) you can miss a lot of tweets. One option could be to use Topsy's RSS feeds <http://otter.topsy.com/searchdate.rss?q=%23okfn> (though not clear how to get more items from this feed either!)

## Gettting Data out of Google Reader

Google Reader offers a decent (though still beta) API. Unoffical docs for it can be found here: <http://undoc.in/>

The key URL we need is:

<http://www.google.com/reader/atom/feed/[feed_address]?n=1000>

Note that the feed is limited to a maximum of 1000 items and you can only access it for your account if you are logged in. This means:

* If you have more than a 1000 items you need to find the continuation token in each set of results and then at &c={continuation-token} to your query.
* Because you need to be logged in your browser you need to do this by hand :-( (it may be possible to automate via the API but I couldn't get anything work - any tips much appreciated!)

Here's a concrete example (note, as you need to be logged in this won't work for you):

<http://www.google.com/reader/atom/feed/http://search.twitter.com/search.atom%3Fq%3D%2523OpenData?n=1000>

And that's it! You should now have a local archive of all your tweets!

## Appendix

Increasing Twitter is selling access to the full Twitter archive and there are a variety of 3rd services (such as Gnip, DataSift, Topsy [and possibly more][more]) who are offering full or partial access for a fee.

[more]: https://dev.twitter.com/programs/twitter-certified-products/products#Data

