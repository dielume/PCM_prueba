class KitchenController < ApplicationController

  def index
    @orders = Order.all.order(created_at: :desc)
    @orders = @orders.paginate( :per_page => 5, :page => params[:page])
  end

end
