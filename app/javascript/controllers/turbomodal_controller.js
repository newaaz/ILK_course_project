import { Controller } from "@hotwired/stimulus"
import * as bootstrap from "bootstrap"

// Connects to data-controller="turbomodal"
export default class extends Controller {
  connect() {
    const modal = document.getElementById("bookingModal");
    modal.style.display = "block";

    const span = document.getElementsByClassName("close")[0];
    span.onclick = function() {
      modal.style.display = "none";
    }    
    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
      if (event.target == modal) {
        modal.style.display = "none";
      }
    }
  }

  submitEnd(e) {
    if (e.detail.success) {
      this.hideModal()
    }
  }
  
  hideModal() {
    this.element.remove()
  }
}
