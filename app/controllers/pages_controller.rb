class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @wedding = Wedding.last
    @guests = Guest.where(wedding: @wedding, confirmed: nil)
    @gifts = Gift.where(wedding: @wedding)
    @tips = Tip.where(wedding: @wedding)
    @wedding_guests_messages = Guest.where(wedding: @wedding).where.not(confirmation_message: nil).where.not(confirmation_message: "")
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
    @no_show = true
  end
end
