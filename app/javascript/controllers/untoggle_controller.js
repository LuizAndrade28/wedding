import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="untoggle"
export default class extends Controller {
  static targets = ["togglableElement"];

  connect() {
  }

  show() {
    this.togglableElementTarget.classList.toggle("d-none");
  }
}
