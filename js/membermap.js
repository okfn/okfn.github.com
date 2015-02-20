// Loads leaflet.js map (http://leafletjs.com/) and populates map with
// member data pulled from member page.

jQuery(document).ready(function($) {
  var container = $('.persons');

  // Center map on appoximate center of markers collected so far
  var map = L.map('map').setView([26.062,9.845],1);

  L.tileLayer('http://otile1.mqcdn.com/tiles/1.0.0/map/{z}/{x}/{y}.jpg', {
    attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors. Tiles Courtesy of <a href="http://www.mapquest.com/" target="_blank">MapQuest</a> <img src="http://developer.mapquest.com/content/osm/mq_logo.png">',
    minZoom: 1
  }).addTo(map);

  // Adds given place to map using helper function to generate coordinates
  function addToMap(place,popup) {
    function geocode(place,callback) {
      var url = 'http://open.mapquestapi.com/nominatim/v1/search?format=json&q=' + encodeURIComponent(place);

      jQuery.getJSON(url, function(data) {
        if (data.length > 0) {
          callback(null,{lon: parseFloat(data[0].lon),lat: parseFloat(data[0].lat)});
        } else {
          callback(null,null);
        }
      });
    }

    geocode(place,function(err,coords){
      if (coords) {
        L.marker(coords).addTo(map).bindPopup(popup);
      }
    });
  }

  // Cycles through members and adds their location to the map
  $.each(container.children(),function(k,v){
    addToMap(v.dataset.place,'<a href="#' + v.id + '">' + v.dataset.name + '</a><br><em>' + v.dataset.area + '</em>');
  });
});
