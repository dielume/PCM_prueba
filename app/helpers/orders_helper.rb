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
  def flash_class(level)
    case level
        when "notice" then "alert alert-info"
        when "success" then "alert alert-success"
        when "error" then "alert alert-danger"
        when "alert" then "alert alert-danger"
    end
  end
  def custom_bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      type = 'success' if type == 'notice'
      type = 'error'   if type == 'alert'
      text = "<script>toastr.#{type}('#{message}');</script>"
      flash_messages << text.html_safe if message
    end
      flash_messages.join("\n").html_safe
  end
end
