class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    if Wedding.last.present?
      @my = Wedding.last
      @wedding = Wedding.find(@my.id)
      @guests = Guest.where(wedding: @wedding)
      @gifts = Gift.where(wedding: @wedding)
      @user_wedding = Wedding.where(user: @wedding.user_id).to_a
      @user_wedding_tips = Tip.where(wedding: @user_wedding)
      @wedding_guests_messages = Guest.where(wedding: @wedding).select { |guest| guest.confirmation_message.present? }
      @partner_name = @user_wedding.map { |partner| "#{ partner.partner_first_name }" }.first
      @days_left = (@wedding.date - Date.today).to_i
      @month = @wedding.date.strftime("%B")
      @month =
      case @month
        when "January" then "Janeiro"
        when "February" then "Fevereiro"
        when "March" then "Março"
        when "April" then "Abril"
        when "May" then "Maio"
        when "June" then "Junho"
        when "July" then "Julho"
        when "August" then "Agosto"
        when "September" then "Setembro"
        when "October" then "Outubro"
        when "November" then "Novembro"
        when "December" then "Dezembro"
      end
      @day = @wedding.date.strftime("%d")
      @year = @wedding.date.strftime("%Y")
      @date = "#{@day} de #{@month}, #{@year} | #{@wedding.time.strftime("%H:%M")}h"
      @markers = [{
                  lat: @wedding.latitude,
                  lng: @wedding.longitude,
                  info_window_html: render_to_string(
                                                    partial: "weddings/info_window",
                                                    locals: { wedding: @wedding }),
                  marker_html: render_to_string(partial: "weddings/marker")
                                                    }] if @wedding.latitude && @wedding.longitude
    end
  end
end
