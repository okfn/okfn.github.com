---
layout: project
title: Public Tika Server including OCR Service
slug: tikaserver
permalink: /projects/tikaserver/index.html
type: [service]
author: Matt Fullerton
maintainers: [mattfullerton]
featured: no
github_user: mattfullerton
github_repo: tika-tesseract-docker
helpwanted: yes
typeofhelp: [coding, testing]
language: [Java, Dockerfile]
projecturl: http://beta.offenedaten.de:9998/tika
stage: alpha
tags: [ocr]
tagline: Turn many files, even text inside images, into text
status: [active]
---

This is a web service available for converting a multitude of document types to simple text. It is a public facing instance of the Apache Tika server (developer version). It lives at:

http://beta.offenedaten.de:9998/tika

To test it, just throw some images with text in them at it. For example, on a terminal on Mac or Linux:

    curl -T tiff_example.tif http://beta.offenedaten.de:9998/tika

More details at http://okfnlabs.org/blog/2015/02/21/documents-to-text.html. Please note that Matt is not the author of the software, just the developer for the Dockerfile that makes setting up an instance of what is quite a large piece of software very straightforward.
