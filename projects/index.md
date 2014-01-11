---
title: Labs Projects
layout: default
bodyclass: code
---

# Labs Projects

<ul class="filters">
  <li class="selected" filter="featured">Featured</li>
  <li filter="helpwanted">Help wanted</li>
  <li filter="type">Type</li>
  <li filter="tags">Tagged</li>
  <li filter="language">Languages</li>
</ul>

<div class="projects">
  {% for project in site.categories.projects %}
    <div class="record" data-featured="{{project.featured}}" data-helpwanted="{{project.helpwanted}}" data-status="{{project.status}}" data-language="{{ project.language | join: ";" }}" data-type="{{ project.type | join: ";" }}" data-tags="{{ project.tags | join: ";" }}">
      <h2>
        <a href="{{project.url | replace:'index.html',''}}">{{project.title}}</a>
        {% if project.author %}
        <div class="author">maintained by {{project.author}}</div>
        {% endif %}
      </h2>
      {% if project.imageurl %}
        <div class="image" data-src="{{project.imageurl}}" data-alt="{{project.title}}"></div>
      {% endif %}
      <div class="rhs">
        <p class="description">
          {{project.content}}
        </p>
      </div>
      <p class="readmore">
        <a href="{{project.url | replace:'index.html',''}}">Read more &raquo;</a>
      </p>
    </div>
    <div style="clear: both;"></div>
  {% endfor %}
</div>


<script type="text/javascript" src="../js/isotope.pkgd.js"></script>
<script type="text/javascript" src="../js/imagesloaded.pkgd.js"></script>
<script type="text/javascript" src="../js/projects.js"></script>

