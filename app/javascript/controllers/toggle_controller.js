// controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["togglableElement", "togglableElementChoiceCasamento", "btnCasamento"];

  connect() {
    if (this.element.dataset.fireCasamentoInfo !== undefined) {
      this.fireCasamentoInfo();
    } else if (this.element.dataset.firePresentesInfo !== undefined) {
      this.firePresentesInfo();
    } else if (this.element.dataset.fireConvidadosInfo !== undefined) {
      this.fireConvidadosInfo();
    } else if (this.element.dataset.firePresentesRecebidos !== undefined) {
      this.firePresentesRecebidos();
    }
  }

  fireCasamentoInfo() {
    this.toggleVisibility("casamentoInfo");
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

  fireChoiceCasamento() {
    this.firePresentesRecebidos();
    this.fireConvidadosInfo();
    this.firePresentesInfo();
    this.fireCasamentoInfo();
  }
}
