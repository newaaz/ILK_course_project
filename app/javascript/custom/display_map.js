document.addEventListener("turbo:load", () => {
  const map = document.getElementById('map')

  if (map) {
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
  }

  function editMap(map) {
    ymaps.ready(init);
    objectFieldId = map.dataset.modelName + '_geolocation_attributes_'

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

      document.getElementById('clear-btn').onclick = function(e) {
        document.getElementById(objectFieldId + 'latitude').value = ''
        document.getElementById(objectFieldId + 'longitude').value = ''
      }
    } 
  }

  function newMap(map) {
    ymaps.ready(init);
    objectFieldId = map.dataset.modelName + '_geolocation_attributes_'

    function init(){
      const myMap = new ymaps.Map("map", {
        center: [45.041, 35.350],
        zoom: 10,
        controls: ['zoomControl'],
        behaviors: ['drag','dblClickZoom', 'multiTouch']
      });    

      myMap.events.add('click', function (e) {
        if (!myMap.balloon.isOpen()) {
          const coords = e.get('coords');
          myMap.balloon.open(coords, {                
              contentBody:'<p>Вы отметили новое место на карте.</p>' +
                '<p>Координаты щелчка: ' + [
                coords[0].toPrecision(7),
                coords[1].toPrecision(7),
                ].join(', ') + '</p>',
              contentFooter:'Чтобы изменить координаты щёлкните в другом месте'
          });

          document.getElementById(objectFieldId + 'latitude').value = coords[0].toPrecision(7)
          document.getElementById(objectFieldId + 'longitude').value = coords[1].toPrecision(7)
        }
        else {
          myMap.balloon.close();
        }
      });
    }

    document.getElementById('clear-btn').onclick = function(e) {
      document.getElementById(objectFieldId + 'latitude').value = ''
      document.getElementById(objectFieldId + 'longitude').value = ''
    }  
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
})

