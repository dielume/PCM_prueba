class Food < ApplicationRecord
  has_many :food_orders
  validates :name, :price, :photo, presence: true

  def to_s
    "#{id}"
  end


end
