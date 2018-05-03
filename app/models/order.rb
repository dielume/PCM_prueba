class Order < ApplicationRecord
  has_many :food_orders
  validates :table, :status, presence: true
end
