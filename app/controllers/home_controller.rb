class HomeController < ApplicationController
  # GET /foods
  # GET /foods.json
  def index
    @foods = Food.all
  end

end
