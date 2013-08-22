---
title: Apps using DBpedia Wikipedia from Open Knowledge Foundation Greece
author: Charalampos Bratsas
username: okfngr
location: Thessaloniki, GR
eventdate: 2013-07-23
categories: apps
layout: post
---


Having developed the Greek DBpedia, the first Internationalized DBpedia, OKFN Greece  is now involved in the OKFN Labs by introducing three applications using DBpedia.

## 1. DBpedia Spotlight 
DBpedia Spotlight is an application that automatically spots and disambiguates words or phrases of text documents that might be sources of DBpedia and annotates them with DBpedia URIs. 

DBpedia spotlight implements the Aho-Corasick string matching algorithm in the spotting stage described above along with the use of [Apache Lucene](http://lucene.apache.org/) over the index built in the offline training / configuration stage. For the disambiguation of the spotted words/phrases, a VSM representation of the DBpedia resources is used along with a variant of the TF-IDF technique for determining the weight of words based on their ability to distinguish between candidates of a given term.

The Greek DBpedia Spotlight with full compatibility with the Greek characters, encoded in UTF-8, was implemented by graduate student Ioannis Avraam under the supervision of Dr. Charalampos Bratsas, coordinator of OKFN: Greece. The project was organised by the OKFN Greece in coordination with the Web Science Master Program and Semantic Web Unit of the Aristotle University of Thessaloniki. The Greek DBpedia spotlight is deployed as a Web service and features a user interface at [http://dbpedia-spotlight.okfn.gr/](http://dbpedia-spotlight.okfn.gr/). The source code is open and available inder Apache license V2 at [https://github.com/iavraam/dbpedia-spotlight.git](https://github.com/iavraam/dbpedia-spotlight.git) (dbpediaSpotlight_el branch).

## 2.  Day Like Today 

Day Like Today ([http://el.dbpedia.org/apps/DayLikeToday/](http://el.dbpedia.org/apps/DayLikeToday/)) is the second application that uses DBpedia in order to inform the user about what happened a day like today, in the past. Similar existing applications are using data that their author has included into the application. The application developed, differs in, that the data displayed have been extracted from Wikipedia with DBpedia queries and visualize the results in a timeline using the okfn lab timeliner. 

At the back end of the application, the user can choose the DBpedia that will be queried as well as which the queries themselves. The queries are submitted, data is analyzed then exported into JSON format and forwarded to the frontend  and illustrated into a pie chart.

Queries return data such as :

* Title of the fact

* Date of the fact

* A small description

* A small thumbnail

* A large picture

* Link to the related article in Wikipedia

* Link to the corresponding DBpedia which we got the data.

The source code is open and available inder Apache license V2 at [https://github.com/okfngr/DayLikeToday](https://github.com/okfngr/DayLikeToday)

Here are some statistics on the amount of information that was exported

<img src="http://farm8.staticflickr.com/7294/9347989761_29b1227361_o.jpg" alt="" />

From Greek DBpedia

<img src="http://farm3.staticflickr.com/2845/9347989793_f25bdb1d37.jpg" width="300" height="180" alt="english_dbpedia-300x180">

From English DBpedia

<img src="http://farm3.staticflickr.com/2884/9350771082_6efe745d5e.jpg" width="300" height="180" alt="german_dbpedia-300x180">

From German DBpedia

## 3.DBpedia Game

The third application is DBpedia ** *Game * **([http://wiki.el.dbpedia.org/apps/ssg/dist/ssg.html](http://wiki.el.dbpedia.org/apps/ssg/dist/ssg.html) )  an entertaining and educational tool to produce knowledge and evaluation of knowledge. It is consisted of a series of games such as: multiple choice, anagram, hangman and matching. The novelty of the DBpedia [Game](http://wiki.el.dbpedia.org/apps/ssg/dist/ssg.html) is the immediate and automatic generation of games from Wikipedia’s data using Semantic Web technologies in Greek Linked Data (DBpedia). The DBpedia data is accessed with the SPARQL Query Language. A total of 31 SPARQL queries were created, that retrieved facts belonging to 8 general categories (geography, history, athletics, astronomy, general, chemistry, politics, economy). These facts form the basis the next processing steps of the application. A sample query is depicted in Listing 1, retrieving Animal labels along with their depiction and feedback links for the DBpedia and Wikipedia pages.

<img src="http://farm8.staticflickr.com/7281/9347989751_c6f71f30ca.jpg" width="500" height="228" alt="sparql">

<img src="http://farm3.staticflickr.com/2836/9347989725_1687807f5c.jpg" width="367" height="500" alt="table">

Even with a relatively small number of 30 queries, we managed to produce a total of 12,000 sets of results from Greek DBpedia (cf. Table 1)

The present version runs as a Java Applet and is a rapid prototype to be improved. ([https://github.com/okfngr/DBpedia-Game](https://github.com/okfngr/DBpedia-Game))

