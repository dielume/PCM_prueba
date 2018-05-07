class AddStatusToFoodOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :food_orders, :status, :string
  end
end
