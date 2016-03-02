jQuery(document).ready(function($) {
  var container = $('.projects');
  var chosen_select = $('.chosen-select');

  $(".form-inline").removeClass("hidden");

  // triggered when the form text is changed
  $("form#filters").on('change', function() {
    var chosen_opts = chosen_select.val();
    // reducing function
    function objectify (p,c) {
      var opt = c.slice(6,-1).split('*='),
          k = opt[0],
          v = opt[1];
      p[k] = p[k] ? [p[k],encodeURIComponent(v)].join(',') : encodeURIComponent(v);
      return p;
    }

    // write url parameters
    if (chosen_opts !== null) {
      // sort (deeply) chosen options, turn into object

      hash_params_obj = chosen_opts.sort().reduce(objectify, {});

      // set hash as stringified object
      location.hash = $.map(hash_params_obj, function(v,k) {
        return encodeURIComponent(k) + '=' + v;
      }).join('&');
      chosen_opts = chosen_opts.join('');
    } else {
      location.hash = '';
    }

    // filter projects

    container.isotope({
      filter: chosen_opts
    });

    return false;
  });

  var filters = {tags: {}, type: {}, activity_status: {}, maturity_status: {}, language: {}, title: {}};

  container.find('.record').each(function() {
    // Find the current project's detail URL
    var record = $(this);
    var url = record.data('url');
    record.addClass('expand');

    // de-duplicate filter values
    $.each(filters, function(filter_type) {
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

  function filterLabel(filter_type) {
    var label = filter_type.substr(0,1).toUpperCase() + filter_type.substr(1);
    label = label.replace("_", " ");
    return label;
  }

  // create filter options
  $.each(filters, function(filter_type, filter) {
    var chosen_group = $('<optgroup label="' + filterLabel(filter_type) + '">');
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

  // read hash parameters into filters_in array
  // (using jQuery map for its flatmap characteristics)
  var hash_params_in = (location.href.split("#")[1] || "");
  if (hash_params_in.length !== 0) {
    var filters_in = $.map(hash_params_in.split('&'), function(optset) {
      var opt = optset.split('=');
      var k = opt[0],
          vs = opt[1].split(',');
      return $.map(vs, function(v) {
        return "[data-" + decodeURIComponent(k) + "*=" + decodeURIComponent(v) + "]";
      });
    });

    // mark initial filters as selected
    filters_in.forEach(function(filter) {
      $("option[value='" + filter + "']").attr("selected","selected");
    });

    filter_set = filters_in.join('');
  } else {
    filter_set = '';
  }

  // Create Isotope grid view
  container.isotope({
    itemSelector: '.record',
    layoutMode: 'masonry',
    filter: filter_set
  });

  chosen_select.chosen();
});
