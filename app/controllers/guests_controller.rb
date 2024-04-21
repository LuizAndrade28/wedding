class GuestsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[update]
  before_action :set_wedding, only: %i[create new edit update]

  def new
    @guest = Guest.new
  end

  def create
    @guest = Guest.new(guest_params)
    @guest.wedding = @wedding

    respond_to do |format|
      if params[:save_and_create_guest].present? && @guest.save
        format.html { redirect_to new_wedding_guest_path(@wedding), notice: 'Convidado criado com sucesso.' }
      elsif params[:save_guest_and_return].present? && @guest.save
        format.html { redirect_to user_profile_path(current_user), notice: 'Convidado criado com sucesso.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @guest = @wedding.guests.find(params[:id])
    respond_to do |format|
      if @guest.update(guest_params)
        format.json { render json: { status: :success, message: "Presença confirmada com sucesso!" } }
      else
        format.json { render json: { status: :error, errors: @guest.errors.full_messages } }
      end
    end
  end

  private

  def set_wedding
    @wedding = Wedding.find(params[:wedding_id])
  end

  def guest_params
    params.require(:guest).permit(:full_name, :email, :phone, :confirmed, :confirmation_message)
  end
end
