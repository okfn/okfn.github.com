var $ = jQuery;
var labs_project = null;
var labs_debug = true;

$(function() {
  // Create the spinner object
  var opts = {
    lines: 12, // The number of lines to draw
    length: 7, // The length of each line
    width: 4, // The line thickness
    radius: 10, // The radius of the inner circle
    color: '#000', // #rgb or #rrggbb
    speed: 1, // Rounds per second
    trail: 60, // Afterglow percentage
    shadow: false // Whether to render a shadow
  };
  var target = document.getElementById('spinner');
  var spinner = new Spinner(opts).spin(target);

  console.log('Initialising OKFN Labs app');

  // Templating system
  var projectTemplate = $('.project#template').html();
  var projectContainer = $('.project-container');
  var spinner = $('#spinner');
  if (!projectTemplate) console.log('ER1');
  if (!projectContainer) console.log('ER2');
  if (!spinner) console.log('ER3');

  var projectUrl = function(owner, project) {
    return 'https://raw.github.com/'+owner+'/'+project+'/master/.labs_project';
  };

  var load_labs_project = function(labsProject) {
    var element = $('<div/>').addClass('project');
    var content = Mustache.to_html(projectTemplate, labsProject);
    element.html(content);
    spinner.before(element);
    element.hide();
    element.show('fast');
  };

  //var repos = [{ name: 'annotator' }, { name: 'dpm' }];
  //$.each(repos, function(i,repo) {
  //});
  var loadRepositories = function(data) {
    $.each(data.repositories, function(i, repo) {
    var url = projectUrl('okfn',repo.name);
    // Returned file should invoke labs_project
    var req = $.ajax({
      url : url,
      dataType : "jsonp",
      timeout : 10000
    });
    });
  };

  // Limit is 100 per page. TODO Need to programmatically wok through them...
  $.getJSON('http://github.com/api/v2/json/repos/show/okfn?callback=?', 
      function(data) { 
        loadRepositories(data); 
      }
  );
  $.getJSON('http://github.com/api/v2/json/repos/show/okfn?page=2&callback=?', 
      function(data) { 
        loadRepositories(data); 
      }
  );
  // Kill the spinner after a few seconds
  var t = setTimeout("$('#spinner').hide()",7000);

  // Bind to public namespace
  labs_project = function(data) { load_labs_project(data); };
});
