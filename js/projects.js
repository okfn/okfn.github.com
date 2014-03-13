jQuery(document).ready(function($) {
  var container = $('.projects');
  var chosen_select = $('.chosen-select');

  $(".form-inline").removeClass("hidden");

  // triggered when the form text is changed
  $("form#filters").on('change', function() {
    var chosen_opts = $('.chosen-select').val();
    if (chosen_opts !== null) {
      chosen_opts = chosen_opts.join('');
    }
    // filter projects
    container.isotope({
      filter: chosen_opts
    });

    return false;
  });

  var filters = {tags: {}, type: {}, status: {}, language: {}};

  container.find('.record').each(function() {
    // Find the current project's detail URL
    var record = $(this);
    var url = record.data('url');
    record.addClass('expand');

    // de-duplicate filter values
    $.each(filters, function (filter_type) {
      var filter_vals = record.data(filter_type).split(';');
      $.each(filter_vals, function(ignore, filter_val) {
        k = toFilterName(filter_val);
        if (!(k in filters[filter_type]) && k !== '') {
          filters[filter_type][k] = filter_val;
        }
      });
    });

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

  // create filter options
  $.each(filters, function(filter_type, filter) {
    var chosen_group = $('<optgroup label="' + filter_type.substr(0,1).toUpperCase() + filter_type.substr(1) + '">');
    $.each(filter, function(k, v) {
      // the '*=' here is a hack. if a filter value is a substring of
      // another (e.g. java and javascript) this will go wrong.
      chosen_group.append('<option value="[data-' + filter_type + '*=' + v + ']">' + v + '</option>');
    });
    chosen_select.append(chosen_group);
  });

  // Parse filter title
  function toFilterName(title) {
    return title.trim().toLowerCase();
  }

  // Create Isotope grid view
  container.isotope({
    itemSelector: '.record',
    layoutMode: 'masonry',
    filter: '[data-featured=true]'
  });

  $('.chosen-select').chosen();
});
