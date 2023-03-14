document.addEventListener("turbo:load", () => {
  // display yandex map
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

  // LitePicker
  const form = document.getElementById('new_order')
  if (form) {
    new Litepicker({
      element: (document.getElementById('order_check_in') || document.getElementById('check_in')),
      elementEnd: (document.getElementById('order_check_out') || document.getElementById('check_out')),
      plugins: ['mobilefriendly'],
      format: 'YYYY-MM-DD',
      resetButton: true,
      minDate: Date.now(),
      numberOfColumns: 2,
      numberOfMonths: 2,
      lang: 'ru-RO',
      singleMode: false,
      tooltipText: {
        one: 'ночь',
        few: 'ночи',
        many: 'ночей',
        other: 'ночей'
      },
      tooltipNumber: (totalDays) => {
        return totalDays - 1;
      },
      allowRepick: true        
    });
  }

  // Fotorama
  $(function () {

    // Initialize main fotorama
    $('.fotoramain').fotorama({
      width: 990,
      ratio: 3/2,
      allowfullscreen: true,
      nav: 'thumbs',
      loop: true,
      keyboard: true,
    })

    //Initialize fotorama manually for rooms
    var $fotoramaDiv = $('.fotorama-rooms').fotorama();

    $fotoramaDiv.on('fotorama:fullscreenenter',
      function (e, fotorama) {        
        fotorama.setOptions({
          nav: "thumbs"
        });
      });
    
    $fotoramaDiv.on('fotorama:fullscreenexit',
    function (e, fotorama) {      
      fotorama.setOptions({
        nav: "false"
      });
    })
  });

  // Parallax
  $('.parallax-window').parallax({zIndex:1}); /* Parallax modal*/ 

})

