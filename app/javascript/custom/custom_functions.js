document.addEventListener("turbo:load", () => {

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
  //$('.parallax-window').parallax({zIndex:1});
})

