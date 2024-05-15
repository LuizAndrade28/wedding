class OrdersController < ApplicationController
  before_action :set_wedding, only: [:new, :create]
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @order = Order.new
    @gift = Gift.find_by(id: params[:gift_id])
  end

  def create
    @gift = Gift.find_by(id: params[:gift_id])
    @order = Order.new(order_params)
    @order.amount = @gift.value
    @order.state = 'pending'
    @order.gift = @gift

    if @order.save
      flash[:notice] = "Obrigado(a) pela sua contribuição!"
      redirect_to root_path
    else
      flash[:alert] = "A compra não foi realizada! Tente novamente."
      render :new
    end
  end

  private

  def set_wedding
    @wedding = Wedding.last
  end

  def order_params
    params.require(:order).permit(:full_name, :message)
  end
end
