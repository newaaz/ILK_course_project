document.addEventListener("turbo:load", () => {
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
  $('.parallax-window').parallax({zIndex:1});
})

