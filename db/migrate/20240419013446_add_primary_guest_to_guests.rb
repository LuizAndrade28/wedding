class AddPrimaryGuestToGuests < ActiveRecord::Migration[7.1]
  def change
    add_reference :guests, :primary_guest, foreign_key: { to_table: :guests }
  end
end
