$(function() {
  // Open the tab given by the hash location
  if (window.location.search) {
    var tabName ='#' + window.location.search.substr(1);
    $('a[data-toggle="tab"][href=\''+tabName+'\']').tab('show')
  }
});
