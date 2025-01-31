import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slider"
export default class extends Controller {
  static targets = ["slide", "box", "display"]
  connect() {
    console.log(this.slideTarget.value)
  }
  value(){
    console.log(this.slideTarget.value)
    this.boxTarget.value = this.slideTarget.value
    this.displayTarget.innerText = this.slideTarget.value
  }
}
