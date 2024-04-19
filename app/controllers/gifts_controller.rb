class GiftsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_wedding, only: %i[delete_all create edit update new]

  def index
    @wedding = Wedding.last
    @gifts = Gift.where(wedding: @wedding).where('total_quota > 0')
    case params[:sort_by]
    when "value_asc"
      @gifts = @gifts.order(value_cents: :asc)
    when "value_desc"
      @gifts = @gifts.order(value_cents: :desc)
    when "title_asc"
      @gifts = @gifts.order(title: :asc)
    when "title_desc"
      @gifts = @gifts.order(title: :desc)
    when "category"
      @gifts = @gifts.order(category: :asc)
    else
      @gifts
    end
    @wedding_guests_messages = Guest.where(wedding: @wedding).where.not(confirmation_message: nil)
    @tips = Tip.where(wedding: @wedding)
  end

  def new
    @gift = Gift.new
  end

  def delete_all
    @gifts = Gift.where(wedding: @wedding)
    @gifts.each(&:destroy)
    redirect_to user_profile_path(current_user)
  end

  def create
    @gift = Gift.new(gift_params)
    @gift.wedding = @wedding
    if @gift.save
      redirect_to user_profile_path(current_user)
    else
      render :new, status: :unprocessable_entity, flash: {
        error: "Por favor, verifique se preencheu corretamente todos os campos."
      }
    end
  end

  def edit
    @gift = Gift.find(params[:id])
  end

  def update
    @gift = @wedding.gifts.find(params[:id])
    if @gift.update(gift_params)
      redirect_to user_profile_path(current_user)
    else
      render :edit, status: :unprocessable_entity, flash: {
        error: "Por favor, verifique se preencheu corretamente todos os campos."
      }
    end
  end

  def destroy
    @gift = Gift.find(params[:id])
    @gift.destroy
    redirect_to user_profile_path(current_user)
  end

  private

  def set_wedding
    @wedding = Wedding.find(params[:wedding_id])
  end

  def sort_by_title_asc
    Gift.all.sort_by { |gift| [gift.title] }
  end

  def sort_by_value_asc
    Gift.all.sort_by { |gift| [gift.value] }
  end

  def gift_params
    params.require(:gift).permit(:title, :category, :value, :total_quota, :photo)
  end
end
