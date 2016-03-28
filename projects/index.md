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
      <option value="[data-featured*=true]">Featured</option>
    </optgroup>
    <optgroup label="Help wanted">
      <option value="[data-helpwanted*=true]">Help wanted</option>
    </optgroup>
  </select>
  <button type="submit" class="btn btn-primary">Filter</button>
</form>



<div class="projects">
  {% for csv_project in site.data.projects %}

    {% for page_project in site.projects %}
      {% if page_project.title == csv_project.title %}
        {% assign page_project_metadata = page_project %}
      {% endif %}
    {% endfor %}

    <div class="record" data-title="{{csv_project.title}}" data-featured="{{csv_project.featured | downcase }}" data-helpwanted="{{csv_project.helpwanted | downcase}}" data-activity_status="{{csv_project.activity_status}}" data-maturity_status="{{csv_project.maturity_status}}" data-language="{{csv_project.language | join: ";" }}" data-type="{{ csv_project.type | join: ";" }}" data-tags="{{ csv_project.tags | join: ";" }}" data-url="{{page_project_metadata.url | replace:'index.html',''}}">
      <h2>
        <a href="{{page_project_metadata.url | replace:'index.html',''}}">{{csv_project.title}}
        </a>

        {% if csv_project.author %}
          <div class="author">by {{csv_project.author}}</div>
        {% endif %}
      </h2>
      {% if csv_project.imageurl %}
        <img src="{{csv_project.imageurl}}" alt="{{csv_project.title}}" />
      {% endif %}

      <p class="description">{{page_project_metadata.content}}</p>
      {% if csv_project.github_repo %}
        <p><img src="/img/github.png" /> <a href="https://github.com/{{csv_project.github_user}}/{{csv_project.github_repo}}">Github</a></p>
      {% endif %}
    </div>
  {% endfor %}
</div>


<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/chosen/1.0/chosen.jquery.min.js"></script>
<script type="text/javascript" src="../js/isotope.pkgd.js"></script>
<script type="text/javascript" src="../js/imagesloaded.pkgd.js"></script>
<script type="text/javascript" src="../js/projects.js"></script>
