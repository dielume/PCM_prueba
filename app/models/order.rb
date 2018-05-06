class Order < ApplicationRecord
  has_many :food_orders, dependent: :destroy
  validates :table, :status, :name, presence: true


  TABLES = 1..20
  WAITERS = ["Mozo1","Mozo2","Mozo3","Mozo4","Mozo5"]

end
