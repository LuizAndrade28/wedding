class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @wedding = Wedding.last
    @guests = Guest.where(wedding: @wedding)
    @gifts = Gift.where(wedding: @wedding)
    @tips = Tip.where(wedding: @wedding)
    @wedding_guests_messages = Guest.where(wedding: @wedding, confirmation_message: true)
    @days_left = (@wedding.date - Date.today).to_i
    @month = I18n.l(@wedding.date, format: "%B").capitalize
    @day = @wedding.date.strftime("%d")
    @year = @wedding.date.strftime("%Y")
    @date = "#{@day} de #{@month}, #{@year} | #{@wedding.time.strftime('%H:%M')}h"
    @markers = [{
      lat: @wedding.latitude,
      lng: @wedding.longitude,
      info_window_html: render_to_string(
        partial: "weddings/info_window",
        locals: { wedding: @wedding }
      ),
      marker_html: render_to_string(partial: "weddings/marker")
    }] if @wedding.latitude && @wedding.longitude
  end
end
