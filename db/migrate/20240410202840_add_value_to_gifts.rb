class AddValueToGifts < ActiveRecord::Migration[7.1]
  def change
    add_monetize :gifts, :value, currency: { present: false }
  end
end
