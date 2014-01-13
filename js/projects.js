jQuery(document).ready(function($) {
  var container = $('.projects');
  var projectdata = [];
  var projectfilters = {
    featured: 0,    // true/false
    helpwanted: 0,  // true/false
    status: [],
    language: [],
    type: [],
    tags: []
  };
  projectselects = ['tags', 'type', 'status', 'language'];

  container.find('.record').each(function() {
    // Find the current project's detail URL
    var record = $(this);
    var url = record.data('url');
    record.addClass('expand');

    // Get project data
    var pd = { record: record };
    $.each(projectfilters, function (k, type) {
      var v = record.attr('data-' + k);
      if (typeof(type) === 'object') {
        v = v.split(';');
      }
      pd[k] = v;
    });
    projectdata.push(pd);

    // Mouse over the record container
    record.hover(function() {
      var record = $(this);
      if (!record.hasClass('loaded')) {
        // Load and display it on hover
        $.get(url, function(data) {
          record.append(
            $(data).find('.record .rhs').html()
          ).addClass('loaded');
        });
      }
    });
  });

  // Parse filter title
  function toFilterName(title) {
    return title.trim().toLowerCase()
                .replace(/[^a-z0-9]+/gi, '-');
  }

  // Add filter references if unique (case-insensitive)
  function pushToFilter(array, refs, prefix) {
    var str = "";
    var refs_l = refs.map(function(e) { return e.toLowerCase(); });
    array.forEach(function(k) {
      var name = toFilterName(k);
      if (name.length > 0) {
        if (refs_l.indexOf(k.toLowerCase())<0) {
          refs.push(k);
        }
        str = prefix + "-" + name;
      }
    });
    return str;
  }

  // Iterate through projects metadata
  projectdata.forEach(function(pd) {
    if (pd.featured == 'true') {
      projectfilters.featured++;
      pd.record.addClass('is-featured');
    }
    if (pd.helpwanted == 'true') {
      projectfilters.helpwanted++;
      pd.record.addClass('is-helpwanted');
    }
    projectselects.forEach(function(f) {
      pd.record.addClass(
        pushToFilter(pd[f], projectfilters[f], f)
      );
    });
  });

  var filters = $('ul.filters');
  projectselects.forEach(function(filter) {

      // Create a blank SELECT tag
      var select =
        filters.find('[data-filter="' + filter + '"]')
          .append('<select />').find('select');

      // Sort case insensitive
      var sorted = projectfilters[filter].sort(function (a, b) {
        return a.toLowerCase().localeCompare(b.toLowerCase());
      });

      // Create each option
      sorted.forEach(function(f) {
        select.append('<option>' + f + '</option>');
      });

      select.click(function(e) {
        e.stopPropagation();
        $(this).change();
      }).change(function() {

        // Set filters
        var f = toFilterName($(this).val());
        if (f.length > 1) {
          container.isotope({
            filter: '.' + filter + '-' + f
          });
        }

        return false;
      });
    });

  filters.removeClass('hidden')
    .children().click(function() {
      // Handle navigation to filter
      var self = $(this);
      if (self.hasClass('active')) {
        // Clear all filters
        self.removeClass('active');
        container.isotope({ filter: '*' });

      } else {
        // Clear selection and set this filter
        self.parent().children().removeClass('active');
        self.addClass('active');

        // Set filter directly
        if (self.attr('filter')) {
          container.isotope({
            filter: '.is-' + self.attr('filter')
          });
        }

        // Set selects
        self.find('select').click().focus();
      }
    });

  // Create Isotope grid view
  container.isotope({
    itemSelector: '.record',
    layoutMode: 'masonry',
    filter: '.is-featured'
  });

});
