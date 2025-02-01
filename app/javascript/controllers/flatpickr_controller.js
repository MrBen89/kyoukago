import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

export default class extends Controller {
  static targets = ["startDate"];

  connect() {
  console.log(this.startDateTarget);

  console.log("flatpickr controller connected");

    flatpickr(this.startDateTarget, {
      enableTime: false,
      dateFormat: "Y-m-d",
      altInput: true,
      minDate: "today",
    });
  }
}
