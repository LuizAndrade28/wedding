class UsersController < ApplicationController
  def show
    # User info
    @user_wedding = Wedding.includes(:guests, :gifts, orders: :gift).where(user: current_user).first

    # Gift info
    @wedding_gifts = @user_wedding&.gifts || []

    # Guest info
    @wedding_guests = @user_wedding&.guests || []
    @grouped_wedding_guests = @user_wedding&.guests&.group_by(&:confirmed) || []
    if @grouped_wedding_guests == true
      count_true = @grouped_wedding_guests[true]&.count
      @percentage_minus_not_attending = (count_true * 100) / @wedding_guests&.count if @wedding_guests.count != 0 && count_true != 0
    end
    @percentage = @percentage_minus_not_attending || 0

    # Orders info
    @orders = @user_wedding&.orders || []

    # Tips info
    @tips = Tip.where(wedding: @user_wedding)

    # Wedding info
    @couple = @user_wedding ? "#{current_user&.first_name}&#{@user_wedding&.partner_first_name&.capitalize}" : ""
  end
end
