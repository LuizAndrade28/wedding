class Gift < ApplicationRecord
  belongs_to :wedding
  has_many :orders, dependent: :destroy
  has_one_attached :photo

  monetize :value_cents

  validates :total_quota, presence: true
  validates :title, presence: true, uniqueness: true
  validates :category, presence: true
  validates :value, presence: true
  validates :photo, presence: true

  scope :with_positive_quota, ->(wedding) { where(wedding: wedding, total_quota: 1..Float::INFINITY) }
end
