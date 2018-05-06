class KitchenController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = Order.all.order(created_at: :desc)
    @orders = @orders.paginate( :per_page => 5, :page => params[:page])
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to kitchen_index_path, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:table, :status, :name)
    end

end
