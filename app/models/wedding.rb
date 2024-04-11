class Wedding < ApplicationRecord
  belongs_to :user
  has_many :gifts, dependent: :destroy
  has_many :orders, through: :gifts, dependent: :destroy
  has_many :guests, dependent: :destroy
  has_one_attached :couple_photo
  has_one_attached :partner_one_photo
  has_one_attached :partner_two_photo
  has_many :tips, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :welcome_message, presence: true
  validates :address, presence: true
  validates :wedding_info, presence: true
  validates :date, presence: true
  validates :time, presence: true
  validates :partner_first_name, presence: true
  validates :partner_last_name, presence: true
  validates :couple_photo, presence: true

  def partner_initials
    "#{partner_first_name&.chars&.first}#{partner_last_name&.chars&.first}"
  end
end
