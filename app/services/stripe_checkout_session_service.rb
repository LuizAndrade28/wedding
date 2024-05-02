class StripeCheckoutSessionService
  def call(event)
    order = Order.find_by(checkout_session_id: event.data.object.id)
    order.update(state: 'paid')
    order.gift.update(total_quota: order.gift.total_quota - 1)
  end
end
