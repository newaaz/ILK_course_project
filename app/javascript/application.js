// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

//import './custom/add_jquery'

import * as bootstrap from "bootstrap"
document.addEventListener("turbo:load", () => {
  const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
  const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))

  const toastElList = document.querySelectorAll('.toast')
  const toastList = [...toastElList].map(toastEl => new bootstrap.Toast(toastEl).show())
})


// functions of theme
import "./custom/theme_functions"


