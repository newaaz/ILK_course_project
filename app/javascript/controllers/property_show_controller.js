import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="property-show" (https://youtu.be/qM4ZK0uuZUE)
export default class extends Controller {
  connect() {    
    $('.content_toggle').click(function(){
      $('.content_block').toggleClass('hide');	
      if ($('.content_block').hasClass('hide')) {
        $('.content_toggle').html('<i class="bi bi-caret-down me-1"></i>Ещё');
        $('.content_block').removeClass('mb-3');
      } else {
        $('.content_toggle').html('<i class="bi bi-caret-up me-1"></i>Свернуть');
        $('.content_block').addClass('mb-3');
      }		
      return false;
    });	
  }
}
