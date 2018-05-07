class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @status = pendiente_finalizado_params
    @orders = Order.where(status: @status).order(updated_at: :desc)
    @orders = @orders.paginate( :per_page => 10, :page => params[:page])
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @foods = Food.all.order(:name)
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
    @foods = Food.all.order(:name)
    @food_orders = @order.food_orders
  end

  # POST /orders
  # POST /orders.json
  def create
    if get_food_order_params == true
      @foods = Food.all.order(:name)
      @order = Order.new(order_params)
      flash[:error] = "La orden no puede estar vacía"
      render :new
    else
      if order_params.to_h["status"] != "Cancelado"
        @order = Order.new(order_params)
        @food_order = get_food_order_params
        @food_order.each{ |food_order| @order.food_orders.build(food_order)}
      end


      respond_to do |format|
        if @order.save
          format.html { redirect_to action: "index", notice: 'Order was successfully created.' }
          format.json { render :show, status: :created, location: @order }
        else
          format.html { render :new }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end


  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    if get_food_order_params_update == true
      @foods = Food.all.order(:name)
      @order = Order.new(order_params)
      flash[:error] = "Debe agregar por lo menos un plato"
      render :new
    else
      if order_params.to_h["status"] != "Cancelado"
        @food_order = get_food_order_params
        @food_order.each{ |food_order| @order.food_orders.build(food_order)}
      end

      respond_to do |format|
        if @order.update(order_params)
          format.html { redirect_to action: "index", notice: 'Order was successfully updated.' }
          format.json { render :show, status: :ok, location: @order }
        else
          format.html { render :edit }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:table, :status, :name)
    end

    def food_order_params
      food_order_params = params.require(:order).permit({:food_orders => {}}).to_h
    end

    def get_food_order_params_update
      if food_order_params["food_orders"].to_h == {} && order_params.to_h["status"] == "Pendiente"
        true
      else
        false
      end
    end

    def get_food_order_params
      if food_order_params["food_orders"].to_h == {} && order_params.to_h["status"] == "Pendiente"
        return true
      end
      quantity = food_order_params["food_orders"]["quantity"].select{|quantity| quantity.to_i > 0}
      food_id = food_order_params["food_orders"]["food"]
      food_id.each_with_index.map{|id, index| {"food_id" => id, "quantity" => quantity[index], "status" => "Pendiente"}}
    end

    def pendiente_finalizado_params
      if params[:status]
        params[:status]
      else
        "Pendiente"
      end
    end

end
