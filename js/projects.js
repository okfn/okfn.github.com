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