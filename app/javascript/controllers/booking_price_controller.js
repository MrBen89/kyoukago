import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="booking-price"
export default class extends Controller {
  static targets = ["startDate", "endDate", "totalPrice"];

  connect() {
    this.calculateTotalPrice();
  }

  calculateTotalPrice() {
    const startDate = new Date(this.startDateTarget.value);
    const endDate = new Date(this.endDateTarget.value);
    const pricePerWeek = parseFloat(this.element.dataset.bookingPricePricePerWeekValue); // Get the price per week from data attribute

    if (startDate && endDate && endDate >= startDate) {
      const timeDiff = endDate - startDate;
      const weeksDiff = Math.ceil(timeDiff / (1000 * 3600 * 24 * 7));
      const totalPrice = weeksDiff * pricePerWeek;
      this.totalPriceTarget.value = totalPrice;
    } else {
      this.totalPriceTarget.value = '';
    }
  }
}
