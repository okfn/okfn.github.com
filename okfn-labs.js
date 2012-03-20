$(function() {
  // Open the tab given by the hash location
  if (window.location.search) {
    var tabName ='#' + window.location.search.substr(1);
    $('a[data-toggle="tab"][href=\''+tabName+'\']').tab('show')
  }
});


// Add ... after text
$(document).ready(function() {
		$(".project-list li .text").dotdotdot({
				after: "a.read-more", // put after the ellipsis
				watch: true, // allow it to work with tabs
	});
});
