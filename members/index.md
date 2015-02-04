---
title: Members
layout: two-column
bodyclass: members
hasmap: true
---

# Labs Members

Anyone can participate in Labs and you don't need to sign up formally. At the same
time, we think it's good for people to be able to self-identify as official
"Members" as a way to show they are part of the community. **Anyone may
become a Member** &ndash; just follow the quick [sign-up steps][signup]!

Labs members come from a wide variety of backgrounds and are based all
over the world.  See below if there's an open data hacker, wrangler,
or researcher in your area.

<div id="map"></div>

[signup]: /members/signup/

## Members

<ul class="persons">
  {% for person in site.categories.members %}
    <li id="{{person.username}}" class="person {% cycle 'odd', 'even' %}">
		{% if person.img %}
		<img class="photo" src="{{person.img}}">
		{% endif %}
      <h3 class="name">
        <a href="{{person.username}}">{{person.title}}</a>
        <small class="area">{{person.area}}</small>
      </h3>
      <p class="joined"><i class="icon-time"></i> Member since <span class="date">{{ person.date | date_to_long_string }}</span></p>

      {% assign user_roles = person.roles %}
      {% assign user_username = person.username %}
	  {% include badges_load_dynamic_roles_recognition.html %}
      {% include badges_display.html %}

      <ul class="links">
        <li><a href="https://twitter.com/{{ person.twitter }}">
          <i class="icon-twitter"></i> {{ person.twitter }}</a></li>
        <li><a href="https://github.com/{{ person.github }}">
          <i class="icon-github"></i> {{ person.github }}</a></li>
        <li><a href="{{ person.web }}">
          <i class="icon-globe"></i> {{ person.web }}</a></li>
      </ul>
      <div class="excerpt">
        {{ person.content }}
      </div>
    </li>
  {% endfor %}
</ul>

<script src="/js/membermap.js"></script>
