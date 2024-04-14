class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :phone, uniqueness: true, length: { minimum: 10, maximum: 15 }
  has_one_attached :photo
  has_one :wedding, dependent: :destroy
end
