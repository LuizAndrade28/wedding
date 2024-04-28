class Order < ApplicationRecord
  belongs_to :gift
  
  delegate :wedding, to: :gift
  delegate :value, to: :gift

  monetize :amount_cents

  validates :full_name, presence: true
end
