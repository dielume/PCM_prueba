class KitchenController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @status = pendiente_finalizado_params
    @orders = Order.where(status: @status).order(updated_at: :desc)
    @orders = @orders.paginate( :per_page => 10, :page => params[:page])
  end

  def show

  end

  def update
    @order.food_orders.each do |food_order|
      food_order.update(status: "Finalizado")
    end
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

    def pendiente_finalizado_params
      if params[:status]
        params[:status]
      else
        "Pendiente"
      end
    end

end
