import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="price-from"
export default class extends Controller {
  connect() {
    console.log(this.element.querySelector('#min_price'))

    const prices = document.querySelectorAll('[data-price]')
    if (prices.length > 0) {
      const minPrice = Array.from(prices).reduce((min, price) => {
        const priceValue = parseInt(price.dataset.price)
        return priceValue < min ? priceValue : min
      }, Infinity)
    
      console.log(minPrice)
      console.log(prices[0].dataset.daysCount)

      this.element.querySelector('#min_price').innerText = minPrice
    }
  }
  
}
