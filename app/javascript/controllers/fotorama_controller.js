import { Controller } from "@hotwired/stimulus"

// Fotorama
import "../custom/plugins/fotorama"

// Connects to data-controller="fotorama"
export default class extends Controller {
  connect() {  
    if (this.element.dataset.object == "main") {
      // Fotorama main
      $(this.element).fotorama({
        width: 990,
        ratio: 3/2,
        allowfullscreen: true,
        nav: 'thumbs',
        loop: true,
        keyboard: true
      })
    } else if (this.element.dataset.object == "widget") {      
      // Fotorama for rooms or widgets
      $(this.element).fotorama().on('fotorama:fullscreenenter',
                                      function (e, fotorama) {        
                                        fotorama.setOptions({
                                          nav: "thumbs"
                                        });
                                      })
                                .on('fotorama:fullscreenexit',
                                      function (e, fotorama) {        
                                        fotorama.setOptions({
                                          nav: "false"
                                        });
                                      });;
      
      
    }
  }
}
