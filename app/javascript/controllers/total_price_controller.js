import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="total-price"
export default class extends Controller {
  static targets = ["input", "weeks", "price", "total"]
  connect(){
    console.log(this.endTarget.value)
    this.inputTarget.value = this.priceTarget.innerText
    this.totalTarget.innerText = this.weeksTarget.value * this.priceTarget.innerText
  }
  update(){
    this.inputTarget.value = this.weeksTarget.value * this.priceTarget.innerText
    this.totalTarget.innerText = this.weeksTarget.value * this.priceTarget.innerText
  }
}
