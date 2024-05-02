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
      redirect_to purchase_gift_path(@gift.id, @order.id)
    # if @order.save
    #   session = Stripe::Checkout::Session.create({
    #     line_items: [{
    #       price_data: {
    #         currency: 'brl',
    #         product_data: {
    #           name: @gift.title,
    #           images: [@gift.photo.key]
    #         },
    #         unit_amount: @gift.value_cents,
    #       },
    #       quantity: 1,
    #     }],
    #     mode: 'payment',
    #     # These placeholder URLs will be replaced in a following step.
    #     success_url: root_url,
    #     cancel_url: root_url
    #     # locale: 'pt-BR'
    #   })
    #   @order.update(checkout_session_id: session.id)
    #   redirect_to purchase_gift_path(@gift.id, @order.id)
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
