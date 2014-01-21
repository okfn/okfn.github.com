---
title: Labs Projects
layout: default
bodyclass: code
---

# Labs Projects

<ul class="filters hidden">
  <li data-filter="featured" class="active">Featured</li>
  <li data-filter="helpwanted">Help wanted</li>
  <li data-filter="type">Type</li>
  <li data-filter="tags">Tagged</li>
  <li data-filter="language">Languages</li>
</ul>

<div class="projects">
  {% for project in site.categories.projects %}
    <div class="record" data-featured="{{project.featured}}" data-helpwanted="{{project.helpwanted}}" data-status="{{project.status}}" data-language="{{ project.language | join: ";" }}" data-type="{{ project.type | join: ";" }}" data-tags="{{ project.tags | join: ";" }}" data-url="{{project.url | replace:'index.html',''}}">
      <h2>
        <a href="{{project.url | replace:'index.html',''}}">{{project.title}}{% if project.tagline %}
            – {{project.tagline}}
          {% endif %}
        </a>
        {% if project.author %}
        <div class="author">maintained by {{project.author}}</div>
        {% endif %}
      </h2>
      {% if project.imageurl %}
        <img src="{{project.imageurl}}" alt="{{project.title}}" />
      {% endif %}

      <p class="description">{{project.content}}</p>
      {% if project.github_repo %}
        <p><img src="/img/github.png" /> <a href="https://github.com/{{project.github_user}}/{{project.github_repo}}">Github</a></p>
      {% endif %}
    </div>
  {% endfor %}
</div>


<script type="text/javascript" src="../js/isotope.pkgd.js"></script>
<script type="text/javascript" src="../js/imagesloaded.pkgd.js"></script>
<script type="text/javascript" src="../js/projects.js"></script>

