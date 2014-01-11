jQuery(document).ready(function($) {
  var $container = $('.projects');
  var projectdata = window.projectdata = [];
  var projectfilters = {
    featured: {},
    helpwanted: {},
    status: {},
    language: {},
    type: {},
    tags: {}
  };
  
  $container.find('.readmore').each(function() {
    // Find the current project's detail URL
    var url = $('a', this).attr('href');
    var $record = $(this).hide().parent();
    $record.addClass('expand');

    // Get project data
    var pd = { object: $record };
    Object.keys(projectfilters).forEach(function (k) {
      var v = $record.attr('data-' + k);
      if (v.indexOf(';') > 0) v = v.split(';');
      pd[k] = v;
    });
    projectdata.push(pd);

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

  // Initialise filters
  

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