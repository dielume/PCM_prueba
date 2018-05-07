module OrdersHelper
  def food_id_exist?(food, food_orders)
    food_orders.each do |food_order|
      if food_order.food_id == food.id
        return true
      end
    end
    false
  end
  def food_order_quantity(food, food_orders)
    food_orders.each do |food_order|
      if food_order.food_id == food.id
        return food_order.quantity
      end
    end
  end
end
