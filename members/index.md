---
title: Members
layout: about
---

<h1>Labs Members</h1>

<p>We operate as a collaborative community and anyone can join as a member.</p>

<h3>Members</h3>
<ul class="persons">
  {% for person in site.categories.members %}
    <li class="person {% cycle 'odd', 'even' %}">
      <img class="photo" src="{{person.img}}">            
      <h4 class="name">
        {{ person.name }}
        <small class="area">{{person.area}}</small>
      </h4>
      <ul>
        <li><a href="https://twitter.com/{{ person.twitter }}">
          <img src="/img/twitter.png"> {{ person.twitter }}</a></li>
        <li><a href="https://github.com/{{ person.github }}">
          <img src="/img/github.png"> {{ person.github }}</a></li>
        <li><a href="{{ person.web }}">
          {{ person.web }}</a></li>
      </ul>
      <div class="excerpt">
        {{ person.content }} 
      </div>
    </li>
  {% endfor %}
</ul>

