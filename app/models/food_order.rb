class FoodOrder < ApplicationRecord
  belongs_to :food
  belongs_to :order
  validates :quantity, :status, presence: true
end
