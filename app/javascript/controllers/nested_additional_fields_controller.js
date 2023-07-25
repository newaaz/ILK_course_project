import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="nested-additional-fields"
export default class extends Controller {
  static targets = [ "add_field", "template" ]

  add_association(event) {
    event.preventDefault()
    let content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().valueOf())
    this.add_fieldTarget.insertAdjacentHTML('beforebegin', content)
  }

  remove_association(event) {
    event.preventDefault()
    let item = event.target.closest(".nested-fields")
    item.querySelector("input[name*='_destroy']").value = 1
    item.style.display = 'none'
  }
}
