class GuestsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[update]

  def new
    @guest = Guest.new
    @wedding = Wedding.find(params[:wedding_id])
  end

  def create
    @guest = Guest.new(guest_params)
    @wedding = Wedding.find(params[:wedding_id])
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

  def delete_all
    @wedding = Wedding.find(params[:id])
    @guests = Guest.where(wedding: @wedding)
    @guests.each(&:destroy)
    redirect_to user_profile_path(current_user)
  end

  def edit
    @guest = Guest.find(params[:id])
    @wedding = Wedding.find(params[:wedding_id])
  end

  def update
    @wedding = Wedding.find(params[:wedding_id])
    @guest = @wedding.guests.find(params[:id])
    respond_to do |format|
      if @guest.update(guest_params)
        format.json { render json: { status: :success, message: "Presença confirmada com sucesso!" } }
      else
        format.json { render json: { status: :error, errors: @guest.errors.full_messages } }
      end
    end
  end

  def destroy
    @guest = Guest.find(params[:id])
    @guest.destroy
    redirect_to user_profile_path(current_user)
  end

  private

  def guest_params
    params.require(:guest).permit(:full_name, :email, :phone, :confirmed, :confirmation_message)
  end
end
