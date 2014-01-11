---
title: Labs Projects
layout: default
bodyclass: code
---

# Labs Projects

<div class="projects">
  {% for project in site.categories.projects %}
    <div class="record">
      <h2>
        <a href="{{project.url | replace:'index.html',''}}">{{project.title}}</a>
        {% if project.author %}
        <div class="author">by {{project.author}}</div>
        {% endif %}
      </h2>
      {% if project.imageurl %}
      <div class="image">
        <img src="{{project.imageurl}}" alt="{{project.title}}" />
      </div>
      {% endif %}
      <p class="description">
        {{project.content}}
      </p>
      <p>
        <a href="{{project.url | replace:'index.html',''}}">Read more &raquo;</a>
      </p>
    </div>
    <div style="clear: both;"></div>
  {% endfor %}
</div>


<script type="text/javascript" src="../js/isotope.pkgd.js"></script>
<script type="text/javascript" src="../js/imagesloaded.pkgd.js"></script>
<script type="text/javascript">
jQuery(document).ready(function($) {
  var $container = $('.projects');
  $container.imagesLoaded(function() {
    $container.isotope({
      itemSelector: '.record',
      layoutMode: 'masonry'
    });
  });
});
</script>

