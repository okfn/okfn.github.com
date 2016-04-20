---
title: Tools for Extracting Data and Text from PDFs - A Review
author: Rufus Pollock
username: rgrp
---

Extracting data from PDFs remains, unfortunately, a common data wrangling task. This post reviews various tools and services for doing this with a focus on free (and preferably) open source options.

The tools we can consider fall into three categories:

* Extracting text from PDF
* Extracting tables from PDF
* Extracting data (text or otherwise) from PDFs where the content is not text but is images (for example, scans)

The last case is really a situation for OCR (optical character recognition) so we're going to ignore it here. We may do a follow up post on this.

<img src="/img/posts/pdf-tools-climate-treaty-paris-pdf.png" alt="Climate Treaty PDF" style="width: 70%; margin: auto; display: block;" />

<div style="text-align: center;" markdown="1">
*The Paris Climate Agreement text was [published as PDF][cop21pdf]. Some of the tools described here -- plus the usual blood, sweat and tears -- were used turn them back into usable HTML for our [Paris COP21 Climate Treaty Texts site][cop21]*
</div>

[cop21]: http://cop21.okfnlabs.org/
[cop21pdf]: http://unfccc.int/resource/docs/2015/cop21/eng/l09r01.pdf

<img src="/img/posts/pdf-tools-senate-report-pdf.png" alt="Example PDF" style="width: 70%; margin: auto; display: block;" />

<div style="text-align: center;" markdown="1">
*A classic example of an important government report published as PDF only*
</div>

## Generic (PDF to text)

* [PDFMiner][pdfminer] - PDFMiner is a tool for extracting information from PDF documents. Unlike other PDF-related tools, it focuses entirely on getting and analyzing text data. PDFMiner allows one to obtain the exact location of text in a page, as well as other information such as fonts or lines. It includes a PDF converter that can transform PDF files into other text formats (such as HTML). It has an extensible PDF parser that can be used for other purposes than text analysis.
  * Pure python
  * In our trials PDFMiner has performed excellently and we rate as one of the best tools out there.
* [pdftohtml][] - pdftohtml is a utility which converts PDF files into HTML and XML formats. Based on xpdf. One of the better for tables but have found PDFMiner somewhat better for a while. Command-line Linux
* [pdftoxml][] - command line utility to convert PDF to XML built on poppler.
* [docsplit][] - part of DocumentCloud. Docsplit is a command-line utility and Ruby library for splitting apart documents into their component parts: searchable UTF-8 plain text via OCR if necessary, page images or thumbnails in any format, PDFs, single pages, and document metadata (title, author, number of pages...)
* [pypdf2xml][] - convert PDF to XML. Built on pdfminer. Started as an alternative to poppler's pdftoxml, which didn't properly decode CID Type2 fonts in PDFs.
* [pdf2htmlEX][] - Convert PDF to HTML without losing text or format. C++. Fast. Primarily focused on producing HTML that exactly resembles the original PDF. Limited use for straightforward text extraction as it generates css-heavy HTML that replicates the exact look of a PDF document.
* [pdf.js](http://mozilla.github.io/pdf.js/) - you probably want a fork like [pdf2json](https://github.com/modesty/pdf2json) or [node-pdfreader](https://github.com/jviereck/node-pdfreader) that integrates this better with node. Not tried this on tables though ...
  * Max Ogden has this list of Node libraries and tools for working with PDFs: <https://gist.github.com/maxogden/5842859>
  * Here's a gist showing how to use pdf2json: <https://gist.github.com/rgrp/5944247>
* [Apache Tika][tika] - Java library for extracting metadata and content from all types of document types including PDF.
* [Apache PDFBox][pdfbox] - Java library specifically for creating, manipulating and getting content from PDFs.

[pdf2htmlEX]: http://coolwanglu.github.io/pdf2htmlEX/
[pypdf2xml]: https://github.com/zejn/pypdf2xml
[docsplit]: http://documentcloud.github.io/docsplit/
[pdfminer]: http://www.unixuser.org/~euske/python/pdfminer/
[pdftohtml]: http://pdftohtml.sourceforge.net/
[pdftoxml]: http://pdftoxml.sourceforge.net/
[tika]: https://tika.apache.org/
[pdfbox]: https://pdfbox.apache.org/

### Tables from PDF

* [Tabula][] - open-source, designed specifically for tabular data. Now easy to install. Ruby-based.
* <https://github.com/okfn/pdftables> - open-source. Created by Scraperwiki but now closed-source and powering [PDFTables][] so here is a fork.
* [pdftohtml] - one of the better for tables but have not used for a while
* <https://github.com/liberit/scraptils/blob/master/scraptils/tools/pdf2csv.py> AGPLv3+, python, scraptils has other useful tools as well, pdf2csv needs pdfminer==20110515
* Using scraperwiki + pdftoxml - see this recent tutorial [Get Started With Scraping – Extracting Simple Tables from PDF Documents][scoda-simple-tables]

[Tabula]: http://tabula.technology/
[PDFTables]: https://pdftables.com/

### Existing open services

* <http://givemetext.okfnlabs.org/> - Give me Text is a free, easy to use open source web service that extracts text from PDFs and other documents using Apache Tika (and built by [Labs member Matt Fullerton][mattf])
* <http://pdfx.cs.man.ac.uk/> - has a nice command line interface
  * Is this open? Says at [bottom of usage](http://pdfx.cs.man.ac.uk/usage) that it is powered by http://www.utopiadocs.com/
  * Note that as of 2016 this seems more focused on conversion to structured XML for scientific articles but may still be useful
* <del>Scraperwiki - https://views.scraperwiki.com/run/pdf-to-html-preview-1/ and [this tutorial](http://blog.scraperwiki.com/2010/12/17/scraping-pdfs-now-26-less-unpleasant-with-scraperwiki/)</del> - no longer working as of 2016

[mattf]: http://okfnlabs.org/members/mattfullerton/ 

### Existing proprietary free or paid-for services

There are many online -- just do a search -- so we do not propose a comprehensive list. Two we have tried and seem promising are:

* <http://www.newocr.com/> - free, with an API, very bare bones site but quite good results based on our limiting testing
* <https://pdftables.com/> - pay-per-page service focused on tabular data  extraction from the folks at ScraperWiki

We also note that Google app engine [used to do this](http://developers.google.com/appengine/docs/python/conversion/overview) but unfortunately it seems discontinued.

## Other good intros

* [Thomas Levine on Parsing PDFs][levine]
* [Extracting Data from PDFs - School of Data][scoda-1]

[levine]: http://okfnlabs.org/blog/2013/12/25/parsing-pdfs.html
[scoda-1]: http://schoolofdata.org/handbook/courses/extracting-data-from-pdf/
[scoda-simple-tables]: http://schoolofdata.org/2013/06/18/get-started-with-scraping-extracting-simple-tables-from-pdf-documents/

