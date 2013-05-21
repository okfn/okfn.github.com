---
title: Hangouts - Events
layout: events
---

# Hangouts

We run regular online hangouts where we get together to discuss and build.

## Humanities Hangout

The Humanities Hangout is for people interested in tapping in to the increasing amount of **open cultural data and content** to create **apps and insights**.

<ul>
{% for post in site.categories.blog %}
{% if post.event == 'hangout' %}
  <li>{{post.eventdate}} &ndash; <a href="{{post.url}}">{{post.title}}</a></li>
{% endif %}
{% endfor %}
</ul>
