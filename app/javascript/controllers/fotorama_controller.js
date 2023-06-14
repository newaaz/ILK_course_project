import { Controller } from "@hotwired/stimulus"

// Fotorama
import "../custom/plugins/fotorama"

// Connects to data-controller="fotorama"
export default class extends Controller {
  connect() {
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
  }
}
