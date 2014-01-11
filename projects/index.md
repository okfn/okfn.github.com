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
<script type="text/javascript">
jQuery(document).ready(function($) {
  var $container = $('.projects');
  
  $container.find('.readmore').each(function() {
    // Find the current project's detail URL
    var url = $('a', this).attr('href');
    var $record = $(this).hide().parent();
    $record.addClass('expand');

    // Mouse over the record container
    $record.hover(function() {
      var $record = $(this);
      if (!$record.hasClass('loaded')) {
        // Load and display it on hover
        $.get(url, function(data) {
          $record.find('.rhs').html(
            $(data).find('.record .rhs').html());
          $record.addClass('loaded');
        });
      }
    });
  });

  // Load the image
  $container.find('div.image').each(function() {
    var t = $(this);
    t.append('<img src="' + 
      t.attr('data-src') + '" alt="' +
      t.attr('data-alt') + '" />');
  });

  // Create Isotope grid view
  $container.isotope({
    itemSelector: '.record',
    layoutMode: 'masonry'
  });

});
</script>

