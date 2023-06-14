import { Controller } from "@hotwired/stimulus"

import "../custom/plugins/parallax"

// Connects to data-controller="parallax"
export default class extends Controller {
  connect() {
    $('.parallax-window').parallax({zIndex:1});
  }
}
