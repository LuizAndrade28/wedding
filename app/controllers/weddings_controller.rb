class WeddingsController < ApplicationController
  before_action :set_wedding, only: %i[edit update destroy]

  def new
    @wedding = Wedding.new
  end

  def create
    @wedding = Wedding.new(wedding_params)
    @wedding.user = current_user
    if @wedding.save
      redirect_to new_wedding_tip_path(@wedding)
    else
      render :new, status: :unprocessable_entity, flash: {
        error: "Por favor, verifique se preencheu corretamente todos os campos."
      }
    end
  end

  def edit
  end

  def update
    if @wedding.update(wedding_params)
      redirect_to new_wedding_tip_path(@wedding)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @wedding.destroy
    redirect_to user_profile_path(current_user)
  end

  private

  def set_wedding
    @wedding = Wedding.find_by(id: params[:id])
  end

  def wedding_params
    params.require(:wedding).permit(:welcome_message,
                                    :address, :address_number, :address_location,
                                    :wedding_info, :date, :time, :partner_first_name,
                                    :partner_last_name, :couple_photo)
  end
end
