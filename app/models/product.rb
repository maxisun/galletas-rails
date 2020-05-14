class Product < ApplicationRecord
    scope :name_asc, -> { order(name: :ASC) }
    scope :name_desc, -> { order(name: :DESC) }
    #scope :likes_asc, -> { order('likes_count')}
    validates :name, presence: true, length: { minimum: 3, maximun: 50 }
    validates :description, presence: true, length: { minimum: 3, maximun: 300 }
    validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0}
    has_many :likes, dependent: :destroy
    has_many :price_logs
end