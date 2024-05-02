class AddAmountToOrders < ActiveRecord::Migration[7.1]
  def change
    add_monetize :orders, :amount, currency: { present: false }
  end
end
