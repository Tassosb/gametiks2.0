

var markers = [];

function initialize() {
  
  var belfast = { lat: 44.502, lng: -69.009 };
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 9,
    center: belfast,
    mapTypeId: 'terrain',
    styles: [
            {
              featureType: 'landscape',
              stylers: [
                { saturation: -50 }
              ]
            },{
              featureType: 'water',
              stylers: [
                { hue: '#174a67' },
                { saturation: 50 },
                { lightness: -80 }
              ]
            },{
              featureType: 'road',
              elementType: 'geometry',
              stylers: [
                { hue: '#00ffee' },
                { saturation: 50 }
              ]
            },{
              featureType: 'poi',
              elementType: 'labels',
              stylers: [
                { visibility: 'off' }
              ]
            }
          ]
  });
  
  
  // This event listener calls addMarker() when the map is clicked.
  google.maps.event.addListener(map, 'click', function(event) {
    addMarker(event.latLng, map);
  });
}

// Adds a marker to the map.
function addMarker(location, map) {
  
  //simply clear out all items from array
  for (var i = 0; i < markers.length; i++) {
      markers[i].setMap(null);
  }
  markers = [];
  
  
  // create draggable marker 
  
  var marker = new google.maps.Marker({
    position: location,
    draggable: true,
    label: "+",
    map: map
  });
  
  markers.push(marker);
}

function initMap(){
  initialize();
}

/*google.maps.event.addDomListener(window, 'load', initialize);*/