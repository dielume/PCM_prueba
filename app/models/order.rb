class Order < ApplicationRecord
  has_many :food_orders, dependent: :destroy
  validates :table, :status, presence: true


  TABLES = 1..20
  
end
