class Guest < ApplicationRecord
  belongs_to :wedding
  has_many :companions, class_name: "Guest", foreign_key: "primary_guest_id", inverse_of: :primary_guest
  belongs_to :primary_guest, class_name: "Guest", inverse_of: :companions, optional: true

  validates :full_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :phone, presence: true, uniqueness: true, length: { minimum: 10, maximum: 15 }
end
