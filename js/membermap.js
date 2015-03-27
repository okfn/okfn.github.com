// Loads leaflet.js map (http://leafletjs.com/) and populates map with
// member data pulled from member page.

jQuery(document).ready(function($) {
  var container = $('.persons');
  var people = [].slice.call($('.persons').children());

  people_obj = people.reduce(function(p,c) {
    var template = function (d) {
      return '<a href="#' + d.id + '">' + d.dataset.name + '</a> <em>' + d.dataset.area + '</em>';
    };
    p[c.dataset.place] = p[c.dataset.place] ? [template(c),p[c.dataset.place]].join('<br><br>') : template(c);
    return p;
  },{});

  // Center map on appoximate center of markers collected so far
  var map = L.map('map').setView([26.062,9.845],1);

  L.tileLayer('http://otile1.mqcdn.com/tiles/1.0.0/map/{z}/{x}/{y}.jpg', {
    attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors. Tiles Courtesy of <a href="http://www.mapquest.com/" target="_blank">MapQuest</a> <img src="http://developer.mapquest.com/content/osm/mq_logo.png">',
    minZoom: 1
  }).addTo(map);

  // Adds given place to map using helper function to generate coordinates
  function addToMap(place,popup) {
    function geocode(place,callback) {
      var url = 'http://open.mapquestapi.com/nominatim/v1/search?format=json&addressdetails=0&limit=1&q=' + encodeURIComponent(place);
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
  $.each(people_obj,function(k,v){
    if (k) {
      addToMap(k,v);
    }
  });
});
