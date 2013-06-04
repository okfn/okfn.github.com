---
title: Members
layout: two-column
bodyclass: members
---

# Labs Members

Anyone can participate in Labs and you don't need to sign up formally. At the same
time, we think it's good for people to be able to self-identify as official
"Members" as a way to show they are part of the community. **Anyone may
become a Member** &ndash; just follow the quick [sign-up steps][signup]!

[signup]: /members/signup/

## Members

<ul class="persons">
  {% for person in site.categories.members reversed %}
    <li class="person {% cycle 'odd', 'even' %}">
      <img class="photo" src="{{person.img}}">            
      <h4 class="name">
        <a href="{{person.username}}">{{person.title}}</a>
        <small class="area">{{person.area}}</small>
      </h4>
      <ul class="links">
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

