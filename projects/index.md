---
title: Labs Projects
layout: default
bodyclass: code
---

<div class="page-header">
  <h1>
    <div style="float: right; font-size: 75%;">
      [<a href="/projects/add/">Add a Project</a>]
    </div>
    Labs Projects
  </h1>
</div>

<form class="form-inline hidden" id="filters">
  <select data-placeholder="Filter projects..." style="width:500px;" class="form-control chosen-select" multiple>
    <option value=""></option>
    <optgroup label="Featured">
      <option value="[data-featured*=true]" selected>Featured</option>
    </optgroup>
    <optgroup label="Help wanted">
      <option value="[data-helpwanted*=true]">Help wanted</option>
    </optgroup>
  </select>
  <button type="submit" class="btn btn-primary">Filter</button>
</form>

<div class="projects">
  {% for project in site.categories.projects %}
    <div class="record" data-featured="{{project.featured}}" data-helpwanted="{{project.helpwanted}}" data-status="{{project.status}}" data-language="{{ project.language | join: ";" }}" data-type="{{ project.type | join: ";" }}" data-tags="{{ project.tags | join: ";" }}" data-url="{{project.url | replace:'index.html',''}}">
      <h2>
        <a href="{{project.url | replace:'index.html',''}}">{{project.title}}
        </a>
        {% if project.author %}
        <div class="author">maintained by {{project.author}}</div>
        {% endif %}
      </h2>
  
    {% if project.imageurl %}
      {% if site.data.projectimgs contains project.slug %}
      <img src="/img/projects/{{project.slug}}" alt="{{project.title}}" />
      {% else %}
      <img src="{{project.imageurl}}" alt="{{project.title}}" />      
      {% endif %}
    {% endif %}

      <p class="description">{{project.content}}</p>
      {% if project.github_repo %}
        <p><img src="/img/github.png" /> <a href="https://github.com/{{project.github_user}}/{{project.github_repo}}">Github</a></p>
      {% endif %}
    </div>
  {% endfor %}
</div>


<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/chosen/1.0/chosen.jquery.min.js"></script>
<script type="text/javascript" src="../js/isotope.pkgd.js"></script>
<script type="text/javascript" src="../js/imagesloaded.pkgd.js"></script>
<script type="text/javascript" src="../js/projects.js"></script>

