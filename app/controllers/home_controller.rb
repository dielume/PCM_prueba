class HomeController < ApplicationController
  # GET /foods
  # GET /foods.json
  def index
    @foods = Food.all.order(:name)
    @order = Order.new

    # @orders = @foods.each{ |food| @order.food_orders << @order.food_orders.build(food_id: food.id)}
    # @order.food_orders << @order.food_orders.build(food_id: 1, quantity: 0)
    # @order.food_orders << @order.food_orders.build(food_id: 2, quantity: 0)


  end

end
