---
layout: post
author: Pierre-Yves Vandenbussche
title: How a bad experience made an OKFN labs project
username: pyvandenbussche
---

From theory to experimentation
----------------------------
Back in November 2010, I faced a problem while teaching my students about the Semantic Web. I wanted to convey the idea that Semantic Web technologies can break down the barriers between dataset silos on the Web and simplify the publication and consumption of open data. This idealistic idea was suddenly undermined when we moved from theory to practice. My exercise used open data to answer the following question: which films have been biased by a partnership relation between the film director and a member of the cast? This question, when written in the SPARQL Semantic Web querying language, can be executed on the DBPedia SPARQL Endpoint (if you are curious about the results, visit [http://bit.ly/14didjd](http://bit.ly/14didjd)). Based on this query I built a whole exercise for my students to discover the potential of the SPARQL language.

When the day came for my students to experiment with the amazing capabilities of Semantic Web technology, the DBPedia server (hosting the SPARQL Endpoint service used by this exercise) was down, leaving me with some awkward remarks like: "it was too beautiful to be true". As a result of that experience I took 2 decisions: 1) Instead of using one exercise and one endpoint, I will provide 3 exercises using 3 different endpoints to maximise my chances to have at least one running, and 2) I decided to develop an application that gives the real picture of one aspect of the Semantic Web architecture: the availability of SPARQL Endpoints.

SPARQL Endpoint Status
----------------------------
![SPARQL Endpoint Status logo](https://sites.google.com/site/pierreyvesvandenbussche/resources/SES.png)
The SPARQL Endpoint Status application has been monitoring the publicly available SPARQL Endpoints listed in [datahub.io](http://datahub.io/) for 2 and a half years. From this study, we can see in the following figure:

![Evolution of the average endpoint availability between February 2011 and April 2013](https://sites.google.com/site/pierreyvesvandenbussche/resources/sparqles_fig1.png)

that the mean endpoint availability has been decreasing over time; however the mean trend is not followed by all endpoints. For instance, the DBPedia endpoint has always been above 90% of availability whereas the mean availability is affected by a growing number of offline endpoints exemplified by KASABI NASA endpoint.

The variance of endpoint-availability profiles is illustrated by the distribution

![Evolution of Endpoints number per availability rate between February 2011 and April 2013](https://sites.google.com/site/pierreyvesvandenbussche/resources/sparqles_fig2.png)

where many endpoints fall into one of two extremes: 24.3% of endpoints are always down, whereas 31% of endpoints have an availability rate higher than 95%. The apparent overall decline in endpoint availability is possibly an effect of maturation. SPARQL is currently moving away from experimentation, leaving permanently offline endpoints in its wake (e.g. Kasabi endpoints) with fewer new _experimental_ endpoints being reported. However, other endpoints (such as data.gov) are supported by well-established stakeholders (here, the U.S. government), and are part of a sustainable policy to deliver a high quality of service to end-user applications.

An OKFN Labs Project
----------------------------
Thanks to a growing community interest and the support of the Open Knowledge Foundation, our project scope is now being extended to further monitor the performance, the discoverability and the interoperability of SPARQL Endpoints. A new version of the tool will soon be hosted by OKFN and will be presented during the ISWC 2013 conference.

As soon as the tool is up and running, we will announce it on the OKFN Labs blog, so stay tuned!