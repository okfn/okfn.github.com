---
author: Matt Fullerton
username: mattfullerton
title: A public web service for document to text conversion including OCR
projects: [tika-server]
---

## Getting text out of documents

Last year I was working on [beta.offenedaten.de](http://beta.offenedaten.de), a catalog of data catalogs in Germany using the [CKAN](http://www.ckan.org/) platform as the basis. Although the topic of [how to enable full-text search of documents in CKAN data catalogs](https://lists.okfn.org/pipermail/ckan-dev/2014-September/008051.html) is somewhat open, I wanted to be able to collect the full text of open data resources for searching. We can't assume that PDFs are always nice PDFs full of text: they can just as easily be scans of paper documents without any optical character recognition (OCR) having taken place. So when we extract text from documents, it would be nice to have an option to do OCR too. This is a need common to other projects we have at [OKF Germany](http://www.okfn.de), and, after discussion on the [Labs list](https://lists.okfn.org/pipermail/okfn-labs/2014-October/001491.html), apparently something people would like to have.

## Lend me your files, I send you back text
In short, there is now a web service available for converting [a multitude of document types](http://tika.apache.org/1.8/formats.html) to simple text. It lives at:

http://beta.offenedaten.de:9998/tika

To test it, just throw some images with text in them at it. For example, on a terminal on Mac or Linux:

    curl -T tiff_example.tif http://beta.offenedaten.de:9998/tika

### How it was built
My involvement in the code for this project was zero. I just took the [web server part](http://wiki.apache.org/tika/TikaJAXRS) of the developer version of the [Apache Tika Project](http://tika.apache.org/) and put it on a server. OCR support using [Tesseract](https://code.google.com/p/tesseract-ocr/) has [recently been added](http://wiki.apache.org/tika/TikaOCR) to Tika.

### Roll your own
For intensive use of the service or to include it in your own infrastructure, you can use this [Docker image](https://registry.hub.docker.com/u/mattfullerton/tika-tesseract-docker/), built on this [GitHub Repository](https://github.com/mattfullerton/tika-tesseract-docker). In case you don't know [what Docker is](https://www.docker.com/whatisdocker/), don't ask me, as I won't do a great job of explaining it to you. I'm sure there's a few Docker experts out there who could improve the Dockerfile setup: pull requests [on GitHub](https://github.com/mattfullerton/tika-tesseract-docker) are welcome!

### Improvements
The big missing feature from this, and from Tika generally, is the ability to perform OCR on a PDF when little or no text comes back. There is [a trick to get the OCR on a PDF](https://github.com/okfn/ideas/issues/88#issuecomment-71388714), but your application will need to decide when to employ it, for example based on the non-OCR results.

### Get involved
A quick look at the [discussion on GitHub](https://github.com/okfn/ideas/issues/88) shows how many ideas there are floating around to improve open document processing tooling on the web. This is just one tiny piece of that puzzle. More concretely, it would be great to get some Open Knowledge involvement in the Tika project going to support them, particularly with the "no text found in PDF" conundrum above. Just [get in touch with them](http://tika.apache.org/contribute.html) directly or with me via the [GitHub issue](https://github.com/okfn/ideas/issues/88) or [old-fashioned email](mailto:matt.fullerton@gmail.com).

## Avoiding the OCR problem in the first place
I thought it might be worth mentioning to anyone involved in putting open data and open documents on the web that there [is a procedure for adding the text to a scan-based PDF](http://computers.tutsplus.com/tutorials/how-to-ocr-text-in-pdf-and-image-files-in-adobe-acrobat--cms-20406), using Adobe Acrobat. If anyone knows of an open source solution for this (i.e. embedding and attaching the OCR text in the images in the PDF), I would love to [hear from you](mailto:matt.fullerton@gmail.com).
