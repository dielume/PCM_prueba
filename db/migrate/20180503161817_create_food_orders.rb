class CreateFoodOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :food_orders do |t|
      t.references :food, foreign_key: true
      t.references :order, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
