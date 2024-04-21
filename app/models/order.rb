class Order < ApplicationRecord
  belongs_to :gift
  delegate :wedding, to: :gift
  delegate :value, to: :gift

  validates :full_name, presence: true
end
