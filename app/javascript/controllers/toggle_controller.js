// controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["togglableElement"];

  connect() {
    if (this.element.dataset.firePresentesInfo !== undefined) {
      this.firePresentesInfo();
    } else if (this.element.dataset.fireConvidadosInfo !== undefined) {
      this.fireConvidadosInfo();
    } else if (this.element.dataset.firePresentesRecebidos !== undefined) {
      this.firePresentesRecebidos();
    }
  }

  firePresentesInfo() {
    this.toggleVisibility("presentesInfo");
  }

  fireConvidadosInfo() {
    this.toggleVisibility("convidadosInfo");
  }

  firePresentesRecebidos() {
    this.toggleVisibility("presentesRecebidos");
  }

  toggleVisibility(type) {
    this.togglableElementTargets.forEach(target => {
      if (target.dataset.toggleElement === type) {
        target.classList.remove("d-none");
      } else {
        target.classList.add("d-none");
      }
    });
  }
}
