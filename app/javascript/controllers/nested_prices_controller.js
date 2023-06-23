import { Controller } from "@hotwired/stimulus"

// LightPicker
import "../custom/plugins/litepicker"

// Connects to data-controller="nested-prices" (https://youtu.be/qM4ZK0uuZUE)
export default class extends Controller {
  static targets = [ "add_price", "template" ]

  connect() {
    const dateForms = document.querySelectorAll(".nested-fields")
    dateForms.forEach(form => {
      requireLitepickerTo(form.querySelector('.start-date'), form.querySelector('.end-date'))
    })
  }

  add_association(event) {
    event.preventDefault()
    let content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().valueOf())
    this.add_priceTarget.insertAdjacentHTML('beforebegin', content)

    let nestedForms = document.querySelectorAll(".nested-fields")
    let item = nestedForms[nestedForms.length - 1]
    requireLitepickerTo(item.querySelector('.start-date'), item.querySelector('.end-date'))
  }

  remove_association(event) {
    event.preventDefault()
    let item = event.target.closest(".nested-fields")
    item.querySelector("input[name*='_destroy']").value = 1
    item.style.display = 'none'
  }
}

function requireLitepickerTo(startDateField, endDateField) {
  new Litepicker({
    element: startDateField,
    elementEnd: endDateField,
    plugins: ['mobilefriendly'],
    format: 'YYYY-MM-DD',
    resetButton: true,
    //minDate: Date.now(),
    numberOfColumns: 2,
    numberOfMonths: 2,
    lang: 'ru-RO',
    singleMode: false,
    tooltipText: {
      one: 'ночь',
      few: 'ночи',
      many: 'ночей',
      other: 'ночей'
    },
    tooltipNumber: (totalDays) => {
      return totalDays - 1;
    },
    allowRepick: true        
  });
}
