jQuery(document).ready(function($) {
  var $container = $('.projects');
  var projectdata = window.projectdata = [];
  var projectfilters = window.projectfilters = {
    featured: 0,    // true/false
    helpwanted: 0,  // true/false
    status: [],
    language: [],
    type: [],
    tags: []
  };
  projectselects = ['tags', 'type', 'status', 'language'];
  
  $container.find('.readmore').each(function() {
    // Find the current project's detail URL
    var url = $('a', this).attr('href');
    var $record = $(this).hide().parent();
    $record.addClass('expand');

    // Get project data
    var pd = { object: $record };
    Object.keys(projectfilters).forEach(function (k) {
      var v = $record.attr('data-' + k);
      if (typeof projectfilters[k] === 'object') {
        v = v.split(';');
      }
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

  // Load the image
  $container.find('div.image').each(function() {
    var t = $(this);
    t.append('<img src="' + 
      t.attr('data-src') + '" alt="' +
      t.attr('data-alt') + '" />');
  });

  // Initialise filters
  function pushToFilter(array, filters) {
    array.forEach(function(f) {
      if (filters.indexOf(f)<0) filters.push(f);
    });      
  }
  projectdata.forEach(function(pd) {
    if (pd.featured == 'true') {
      projectfilters.featured++;
      pd.object.addClass('is-featured');
    }
    if (pd.helpwanted == 'true') {
      projectfilters.helpwanted++;
      pd.object.addClass('is-helpwanted');
    }
    projectselects.forEach(function(filter) {
      pushToFilter(pd[filter], projectfilters[filter]);
      pd.object.addClass(pd[filter].join(' '));
    });
  });

  var $filters = $('ul.filters');
  projectselects.forEach(function(filter) {
      var select = 
        $filters.find('[filter="' + filter + '"]')
          .append('<select />').find('select');
      projectfilters[filter].forEach(function(f) {
        select.append('<option>' + f + '</option>');
      });
      select.click(function(e) {
        e.stopPropagation();

        // Set filter
        var f = $(this).val()
          .trim().toLowerCase()
          .replace(/[^a-z0-9]+/gi, '-');
        if (f.length > 1) {
          console.log(f);
          $container.isotope({ 
            filter: '.' + filter + '-' + f 
          });
        }

        return false;
      });
    });

  $filters.removeClass('hidden')
    .children().click(function() {
      var self = $(this);
      if (self.hasClass('active')) {
        // Clear all filters
        self.removeClass('active');
        $container.isotope({ filter: '*' });

      } else {
        // Clear selection and set this filter
        self.parent().children().removeClass('active');
        self.addClass('active');

        // Set filter directly
        if (self.attr('filter')) {
          $container.isotope({ 
            filter: '.is-' + self.attr('filter') 
          });
        }
      }
    });

  // Create Isotope grid view
  $container.isotope({
    itemSelector: '.record',
    layoutMode: 'masonry',
    filter: '.is-helpwanted'
  });

});