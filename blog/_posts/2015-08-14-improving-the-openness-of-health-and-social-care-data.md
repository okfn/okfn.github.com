---
title: Improving the openness of health and social care data
author: Chris Hutchins
---

The [Health and Social Care Information Centre](http://www.hscic.gov.uk/) (HSCIC) is responsible for publishing a large proportion of the official statistics related to health and care in England. Each year we release about 250 statistical publications, ranging from high-level summary data on hospital admissions, through to detail on prescriptions, and results from surveys on lifestyles and smoking, drinking and drug use habits. We publish a vast array of aggregated non-identifiable data, all under the Open Government Licence, and are working with an [open data](http://www.hscic.gov.uk/transparency) mind-set to ensure that these data can be used to maximum effect.

Most of our statistical data is presented in formatted spreadsheets, providing context and detail in accordance with the Statistics Code of Conduct, but we are also making the data available for re-use, in machine-readable, comma-separated-variable format. We hope that this encourages our non-identifiable data to be consumed by a greater array of users, for more purposes. An example of this is the annual [Hospital Episode Statistics](http://www.hscic.gov.uk/pubs/hes1314) (HES) publication for admitted patient care – the publication contains a raft of Excel tables of various statistics, but we have also now created a set of CSV files, which use a consistent structure.

To improve the discoverability of our non-identifiable data, as well as being published on our own site, our datasets are also available through data.gov.uk (DGU). We hope that organising datasets in this way makes it easier for users to find exactly the data they need. An area that we’ve recently worked on is our Clinical Indicators. The HSCIC is responsible for assuring the quality of health and care indicators, and publishes over 1700 indicators on our [Indicator Portal](https://indicators.ic.nhs.uk/webview/). 

Until recently, the only way to search or access the data was from within the portal. Now, the aggregated datasets that support over 100 indicators on health outcomes can be accessed using DGU, thanks to its harvesting tool. Our portal makes the metadata available for each indicator using the DDI xml standard – so we have converted this into a [data.json](https://github.com/hscic-open-data/indicator-portal) equivalent, which will be maintained in line with ongoing release of indicators.

This means that these indicators, and more in future, can be found without the user needing to be within our own portal. Users can also benefit from DGU’s additional CKAN functionality (for example, the ‘Preview’ function) and of course, being a CKAN implementation, the aggregated datasets have their own API, allowing other portals to re-harvest the data. All of which will hopefully increase the different ways in which our data is used.

To begin with, the indicators that can be found on data.gov.uk are:

- [NHS Outcomes Framework](http://data.gov.uk/data/search?sort=title_string+asc&q=title%3A+%22nhsof%22&publisher=health-and-social-care-information-centre#search-sort-by) (‘NHSOF’; 50 indicators) – which sets out the outcomes and corresponding indicators used by the Secretary of State to hold NHS England to account for improvements in health outcomes

- [Clinical Commissioning Group Outcomes Indicator Set](http://data.gov.uk/data/search?sort=title_string+asc&q=title%3A+%22ccgois%22&publisher=health-and-social-care-information-centre#search-sort-by) (‘CCGOIS’; 53 indicators) – which is an integral part of NHS England’s systematic approach to quality improvement.

If you’re already using our open data to generate benefits, we’d love to learn more – it will help us to prioritise our efforts. Tweet us at [@HSCICOpenData](http://twitter.com/HSCICOpenData). 

Chris Hutchins is Open Data Lead, Health and Social Care Information Centre (HSCIC)
