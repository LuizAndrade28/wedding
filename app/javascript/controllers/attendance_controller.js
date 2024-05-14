import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["formGuestElement", "guestForm", "guestPhone", "errorMessages", "guestPhoneError", "successMessages", "confirmationMessages", "confirmationMessage", "divSubmit", "input", "guestCompanions", "guestCompanionsAccept", "guestCompanionsDecline"];
  static values = { guests: String };

  connect() {
    // Oculta mensagens de sucesso e mensagens de confirmação
    this.successMessagesTarget.classList.add('d-none');
    this.confirmationMessagesTarget.classList.add('d-none');
    // Mostra a lista de todos os guests
    // console.log(this.guestsValue);
  }

  guestName(event) {
    let guestName = event.target.value;
  }

  searchGuest(event) {
    // Obtém o nome do convidado digitado no formulário
    const guestName = this.formGuestElementTarget.querySelector('input').value;

    // Procura o convidado na lista de convidados
    const guests = JSON.parse(this.guestsValue);
    const filteredGuests = guests.filter(guest => guest.full_name.toUpperCase().startsWith(guestName.toUpperCase()) && guest.confirmed === null && guest.primary_guest_id === null);

    // Verifica se foram encontrados convidados
    if (filteredGuests.length === 1) {
      // Se houver apenas um convidado encontrado, prossiga como antes
      const foundGuest = filteredGuests[0];
      // console.log('Convidado encontrado:', foundGuest);
      if (foundGuest.confirmed === null) {
        // Oculta o formulário de busca e mostra o formulário de confirmação
        this.formGuestElementTarget.classList.add('d-none');
        this.guestFormTarget.classList.remove('d-none');
        // Armazena os dados do convidado para verificação posterior
        this.foundGuest = foundGuest;
        // Mostra os acompanhantes do convidado
        const foundCompanions = guests.filter(g => g.primary_guest_id === foundGuest.id);

        // Adiciona os acompanhantes do convidado ao formulário
        if (foundCompanions.length > 0) {
          this.guestCompanionsTarget.classList.remove('d-none');
          foundCompanions.forEach(companion => {

            // Adiciona div para inserir elementos de confirmação
            const companionElementDivConfirm = document.createElement('div');
            companionElementDivConfirm.classList.add('form-check', 'form-check-inline');
            companionElementDivConfirm.setAttribute('data-target', 'guestCompanionsAccept');
            this.guestCompanionsTarget.appendChild(companionElementDivConfirm);

            // Adiciona o nome do acompanhante
            const companionElement = document.createElement('p');
            companionElement.textContent = companion.full_name;
            companionElement.classList.add('m-0', 'p-0');
            companionElementDivConfirm.appendChild(companionElement);

            // Adiciona o radio button para confirmar a presença
            const companionElementConfirmation = document.createElement('input');
            companionElementConfirmation.type = 'radio';
            companionElementConfirmation.name = 'attendance' + companion.id;
            companionElementConfirmation.value = 'confirm';
            companionElementConfirmation.dataset.companionId = companion.id;
            companionElementConfirmation.classList.add('form-check-input', 'radio-wed');
            companionElementDivConfirm.appendChild(companionElementConfirmation);

            // Adiciona o label para o radio button de confirmação
            const companionElementConfirmationLabel = document.createElement('label');
            companionElementConfirmationLabel.textContent = 'Confirmar presença';
            companionElementConfirmationLabel.classList.add('form-check-label');
            companionElementDivConfirm.appendChild(companionElementConfirmationLabel);

            // Adiciona div para inserir elementos de recusa
            const companionElementDivDecline = document.createElement('div');
            companionElementDivDecline.classList.add('form-check', 'form-check-inline');
            companionElementDivDecline.setAttribute('data-target', 'guestCompanionsDecline');
            this.guestCompanionsTarget.appendChild(companionElementDivDecline);

            // Adiciona o radio button para declinar a presença
            const companionElementDecline = document.createElement('input');
            companionElementDecline.type = 'radio';
            companionElementDecline.name = 'attendance' + companion.id;
            companionElementDecline.value = 'decline';
            companionElementDecline.dataset.companionId = companion.id;
            companionElementDecline.classList.add('form-check-input', 'radio-wed');
            companionElementDivDecline.appendChild(companionElementDecline);

            // Adiciona o label para o radio button de recusa
            const companionElementDeclineLabel = document.createElement('label');
            companionElementDeclineLabel.textContent = 'Não irá comparecer';
            companionElementDeclineLabel.classList.add('form-check-label');
            companionElementDivDecline.appendChild(companionElementDeclineLabel);
          });
        }
        // Esconde a mensagem de erro
        this.hideError();
      }
    } else if (filteredGuests.length > 1) {
      // Se houver mais de um convidado encontrado, exiba uma lista para seleção
      this.inputTarget.classList.add("d-none");
      this.divSubmitTarget.classList.add("d-none");
      // console.log('Vários convidados encontrados:', filteredGuests);
      // Exibe a lista de convidados na tela para seleção
      this.showGuestSelection(filteredGuests);
    } else {
      // console.log('Nenhum convidado encontrado');
      // Trate o caso em que nenhum convidado foi encontrado
    }
  }

  showGuestSelection(filteredGuests) {
    // Cria uma lista HTML de convidados para seleção
    const guestList = document.createElement('ul');
    guestList.classList.add('guest-list', 'd-flex', 'flex-wrap', 'justify-content-center', 'm-0', 'p-0', 'w-100');

    // Para cada convidado na lista filtrada, cria um item de lista e adiciona à lista
    filteredGuests.forEach(guest => {
      const listItem = document.createElement('li');
      listItem.textContent = guest.full_name;
      listItem.classList.add('guest-item', 'btn', 'scroll-card-wed');
      listItem.addEventListener('click', () => this.selectGuest(guest));
      guestList.appendChild(listItem);
    });

    // Adiciona a lista de convidados à div de busca
    const searchForm = this.formGuestElementTarget.querySelector('.form');
    searchForm.appendChild(guestList);
  }

  selectGuest(guest) {
    // Ao selecionar um convidado, atualiza o formulário com os dados do convidado selecionado
    this.inputTarget.classList.remove("d-none");
    this.divSubmitTarget.classList.remove("d-none");
    this.foundGuest = guest;
    this.formGuestElementTarget.querySelector('input').value = guest.full_name;
    // Remove a lista de convidados da tela
    const guestList = this.formGuestElementTarget.querySelector('.guest-list');
    if (guestList) {
      guestList.remove();
    }
    // Esconde a mensagem de erro
    this.hideError();
  }

  radioSelection(event) {
    const selectedValue = event.target.value;
    if (selectedValue === 'confirm') {
    } else if (selectedValue === 'decline') {
    }
  }

  async submitAttendance() {
    const phone = this.guestPhoneTarget.value;
    const selectedValue = this.element.querySelector('input[name="attendance"]:checked').value;
    const message = this.confirmationMessageTarget.value;

    if (phone !== this.foundGuest.phone) {
      this.showError('Telefone incorreto');
      return;
    }

    const weddingId = this.foundGuest.wedding_id;
    const guestId = this.foundGuest.id;
    const url = `/weddings/${weddingId}/guests/${guestId}`;
    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

    const guestResponse = await fetch(url, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify({
        confirmed: selectedValue === 'confirm',
        confirmation_message: message
      }),
    });

    if (guestResponse.ok) {
      // Se a requisição foi bem-sucedida, faça o que for necessário, como mostrar uma mensagem de sucesso
      // Esconde a mensagem de erro e mostra a mensagem de sucesso ou confirmação
      this.hideError();
      if (selectedValue === 'confirm') {
        this.showSuccessMessage('Sua presença foi atualizada com sucesso! Nos vemos no casamento.');
      } else {
        this.showConfirmationMessage('Nós entendemos que nem todos podem comparecer, mas agradecemos muito a sua sinceridade, ajuda muito na organização do casamento!');
      }
    } else {
      // Se a requisição falhar
    }

    // Atualização dos acompanhantes
    await this.updateCompanions(weddingId, csrfToken);
  }

  async updateCompanions(weddingId, csrfToken) {
    const companions = this.element.querySelectorAll('input[name^="attendance"]:checked:not([value=""])');

    companions.forEach(async companion => {
      const companionId = companion.dataset.companionId;
      if (companionId !== undefined) {
        const companionUrl = `/weddings/${weddingId}/guests/${companionId}`;

        const companionResponse = await fetch(companionUrl, {
          method: 'PATCH',
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': csrfToken
          },
          body: JSON.stringify({
            confirmed: companion.value === 'confirm',
          }),
        });

        if (!companionResponse.ok) {
          // Lidar com o erro na atualização do acompanhante, se necessário
        }
      }
    });
  }

  showError(message) {
    // Exibe a mensagem de erro
    this.errorMessagesTarget.textContent = message;
    this.errorMessagesTarget.classList.remove('d-none');
  }

  hideError() {
    // Esconde a mensagem de erro
    this.errorMessagesTarget.textContent = '';
    this.errorMessagesTarget.classList.add('d-none');
  }

  showSuccessMessage(message) {
    // Exibe a mensagem de sucesso
    this.successMessagesTarget.textContent = message;
    this.successMessagesTarget.classList.remove('d-none');
    this.guestFormTarget.classList.add('d-none');
  }

  showConfirmationMessage(message) {
    // Exibe a mensagem de confirmação
    this.confirmationMessagesTarget.textContent = message;
    this.confirmationMessagesTarget.classList.remove('d-none');
    this.guestFormTarget.classList.add('d-none');
  }
}
