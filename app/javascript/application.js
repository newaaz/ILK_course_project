// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

import './custom/add_jquery'

import * as bootstrap from "bootstrap"
document.addEventListener("turbo:load", () => {
  const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
  const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))

  const toastElList = document.querySelectorAll('.toast')
  const toastList = [...toastElList].map(toastEl => new bootstrap.Toast(toastEl).show())
})

//import { Fancybox } from "@fancyapps/ui/src/Fancybox/Fancybox.js";

// Fileuploader move to PreviewController
//import "./custom/plugins/fileuploader.min.js"

// Fotorama
import "./custom/plugins/fotorama"

// Parallax
import "./custom/plugins/parallax"

// functions of theme
import "./custom/theme_functions"

// fotorama, parallax
import "./custom/custom_functions"
