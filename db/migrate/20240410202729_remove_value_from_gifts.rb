class RemoveValueFromGifts < ActiveRecord::Migration[7.1]
  def change
    remove_column :gifts, :value, :integer
  end
end
