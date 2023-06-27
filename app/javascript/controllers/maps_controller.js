import { Controller } from "@hotwired/stimulus"

import * as bootstrap from "bootstrap"


// Connects to data-controller="maps"
export default class extends Controller {
  connect() {
    const map = this.element;

    switch (map.dataset.action) {
      case 'show':
        showMap(map)
        break
      case 'new':
        newMap(map)
        break
      case 'edit':
        editMap(map)
        break
    }

    function newMap(map) {
      ymaps.ready(init);
      const objectFieldId = map.dataset.modelName + '_geolocation_attributes_'
  
      function init(){
        var myPlacemark,
          myMap = new ymaps.Map("map", {
          center: [45.041, 35.350],
          zoom: 10,
          controls: ['zoomControl'],
          behaviors: ['drag','dblClickZoom', 'multiTouch']
        });    
  
        myMap.events.add('click', function (e) {      
          const coords = e.get('coords');

          if (myPlacemark) {
            myPlacemark.geometry.setCoordinates(coords);
            const newCoords = myPlacemark.geometry.getCoordinates()
            document.getElementById(objectFieldId + 'latitude').value = newCoords[0].toPrecision(7)
            document.getElementById(objectFieldId + 'longitude').value = newCoords[1].toPrecision(7)
          }
          else {
            myPlacemark = createPlacemark(coords);
            myMap.geoObjects.add(myPlacemark);
  
            myPlacemark.events.add('dragend', function () {
              const newCoords = myPlacemark.geometry.getCoordinates()
              document.getElementById(objectFieldId + 'latitude').value = newCoords[0].toPrecision(7)
              document.getElementById(objectFieldId + 'longitude').value = newCoords[1].toPrecision(7)
            });
          }
        });
      }
      
      function createPlacemark(coords) {
        document.getElementById(objectFieldId + 'latitude').value = coords[0].toPrecision(7)
        document.getElementById(objectFieldId + 'longitude').value = coords[1].toPrecision(7)
        return new ymaps.Placemark(coords, {
            iconCaption: ''
        }, {
            preset: 'islands#blueHomeIcon',
            draggable: true
        });
  }
  
      // document.getElementById('clear-btn').onclick = function(e) {
      //   document.getElementById(objectFieldId + 'latitude').value = ''
      //   document.getElementById(objectFieldId + 'longitude').value = ''
      // }  
    }

    function showMap (map) {
      ymaps.ready(init);
      function init(){
        const coords = [map.dataset.latitude, map.dataset.longitude]      
        const myMap = new ymaps.Map("map", {
            center: coords,
            zoom: 14,
            behaviors: ['drag','dblClickZoom', 'multiTouch']
        });    
        const myPlacemark = new ymaps.Placemark(coords, {
          balloonContentHeader: 'Header',
          balloonContentBody: 'Body',
          balloonContentFooter: 'Footer',
          hintContent: 'Hint'
        }, {
          preset: map.dataset.icon
        });
        myMap.geoObjects.add(myPlacemark);
      }
    }

    function editMap(map) {
      ymaps.ready(init);
      const objectFieldId = map.dataset.modelName + '_geolocation_attributes_'
  
      function init(){
        const coords = [map.dataset.latitude, map.dataset.longitude]
        const myMap = new ymaps.Map("map", {
            center: coords,
            zoom: 16,
            controls: ['zoomControl'],
            behaviors: ['drag','dblClickZoom', 'multiTouch']
        });
  
        const myPlacemark = new ymaps.Placemark(coords, {}, {
          preset: "islands#blueHomeIcon",        
          hideIconOnBalloonOpen: false,
          draggable: true
        });
        myMap.geoObjects.add(myPlacemark);
  
        myPlacemark.events.add('dragend', function(e) {
          const newCoords = myPlacemark.geometry.getCoordinates()
          document.getElementById(objectFieldId + 'latitude').value = newCoords[0].toPrecision(7)
          document.getElementById(objectFieldId + 'longitude').value = newCoords[1].toPrecision(7)
  
        })
  
        // document.getElementById('clear-btn').onclick = function(e) {
        //   document.getElementById(objectFieldId + 'latitude').value = ''
        //   document.getElementById(objectFieldId + 'longitude').value = ''
        // }
      } 
    }  
  }

  showMapModal(e) {
    e.preventDefault()
    document.getElementById('map').innerHTML = ''
    ymaps.ready(init);
    function init(){
      const coords = [e.target.dataset.latitude, e.target.dataset.longitude]      
      const myMap = new ymaps.Map("map", {
          center: coords,
          zoom: 14,
          behaviors: ['drag','dblClickZoom', 'multiTouch']
      });    
      const myPlacemark = new ymaps.Placemark(coords, {
        balloonContentHeader: 'Header',
        balloonContentBody: 'Body',
        balloonContentFooter: 'Footer',
        hintContent: 'Hint'
      }, {
        preset: "islands#blueHomeIcon"
      });
      myMap.geoObjects.add(myPlacemark);

      new bootstrap.Modal('#mapmodal').show()
    }
  }
}
