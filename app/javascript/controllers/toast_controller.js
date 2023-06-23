import { Controller } from "@hotwired/stimulus"

import * as bootstrap from "bootstrap"

// Connects to data-controller="toast"
export default class extends Controller {
  connect() {
    new bootstrap.Toast(this.element).show()
  }
}
