class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :is_admin, presence: true
  has_many :likes, dependent: :destroy
  has_many :price_logs
end
