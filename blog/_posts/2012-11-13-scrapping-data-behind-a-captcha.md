---
layout: post
author: Vitor Baptista
title: Scraping Data Behind a CAPTCHA
username: vitorbaptista
---

How much does the highest paid person in the Brazilian Federal Senate earns?
That's the question I asked myself a few weeks ago, and one that should be
easy to answer. In Brazil, every public body must publish its employees'
salaries online, but some do so in a terrible way. The Federal Senate is
one of these.

To access its data you have to not only fill in your personal info, but also
solve a CAPTCHA for each salary you want to see. With no other tricks, it would
take ages to answer my question. I needed a way to gather all salaries and
compare them. But how to scrape a page that's "protected" behind a CAPTCHA?

<img src="/img/res/senado-gov-br-captcha.jpg"
style="margin: 0 auto; display: block;" alt="senado.gov.br CAPTCHA" />

[Decaptcher](http://decaptcher.com) is a company that sells CAPTCHA-solving
services. They provide an API that you can send an image, and get the contained
text. It's really cheap (US$ 1.38 per 1.000 CAPTCHAs), and works well, albeit a
bit slow (30~40 secs).  They promise a success rate of over 95%, but I got only
43% in my tests. Probably because the CAPTCHAs I'm sending are really hard to read.

[Their API](http://decaptcher.org/api) is simple to implement, with only 3
actions (upload, refund, and balance). There're examples in C# and PHP, and
I've hacked together [one in Ruby](https://gist.github.com/4063793). For a
bit more than US$ 5.92, I was able to access and publish the salaries of
4,487 public servants in [http://senado.cc](http://senado.cc).

There're many other companies that offer the same service, like
[Death by CAPTCHA](http://deathbycaptcha.com), [Bypass CAPTCHA](http://bypasscaptcha.com/),
[Beat CAPTCHA](http://www.beatcaptchas.com/), and [Antigate](http://antigate.com/).
These services allow us to access public data that would be unreachable otherwise,
but they might be considered illegal in some countries. As we're not breaking the
CAPTCHA, but paying people to solve them, we should be fine. But don't take my word
for it: ask a lawyer.
