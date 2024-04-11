class GiftsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @my = Wedding.last
    @wedding = Wedding.find(@my.id)
    @gifts = Gift.where(wedding: @wedding)
    @order = Order.new
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
    @couple = "#{@wedding.user.first_name}&#{@wedding.partner_first_name}"
    @wedding_guests_messages = Guest.where(wedding: @wedding).select { |guest| guest.confirmation_message.present? }
    @user_wedding_tips = Tip.where(wedding: @wedding)
  end

  def new
    @gift = Gift.new
    @wedding = Wedding.find(params[:wedding_id])
  end

  def delete_all
    @wedding = Wedding.find(params[:wedding_id])
    @gifts = Gift.where(wedding: @wedding)
    @gifts.each do |gift|
      gift.destroy
    end
    redirect_to user_profile_path(current_user)
  end

  def create
    @gift = Gift.new(gift_params)
    @wedding = Wedding.find(params[:wedding_id])
    @gift.wedding = @wedding
    @gift.save

    redirect_to user_profile_path(current_user)
  end

  def edit
    @gift = Gift.find(params[:id])
    @wedding = Wedding.find(params[:wedding_id])
  end

  def update
    @gift = Gift.find(params[:id])
    @gift.update(gift_params)
    redirect_to user_profile_path(current_user)
  end

  def destroy
    @gift = Gift.find(params[:id])
    @gift.destroy
    redirect_to user_profile_path(current_user)
  end

  private

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
