import { Controller } from "@hotwired/stimulus"

// LightPicker
import "../custom/plugins/litepicker"

// Connects to data-controller="lite-pickers"
export default class extends Controller {
  connect() {
    console.log('LitePicker connected')

    new Litepicker({
      element: this.element.querySelector('.start-date'),
      elementEnd: this.element.querySelector('.end-date'),
      plugins: ['mobilefriendly'],
      format: 'YYYY-MM-DD',
      resetButton: true,
      minDate: Date.now(),
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
}
