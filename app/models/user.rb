class User < ApplicationRecord
  # :confirmable, :lockable, :timeoutable, :trackable, :omniauthable, :registerable, :recoverable
  devise :database_authenticatable, :rememberable, :validatable
  validates :phone, uniqueness: true, length: { minimum: 10, maximum: 15 }
  has_one_attached :photo
  has_one :wedding, dependent: :destroy
end
