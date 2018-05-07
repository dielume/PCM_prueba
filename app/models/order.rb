class Order < ApplicationRecord
  has_many :food_orders, dependent: :destroy
  validates :table, :status, :name, presence: true
  after_create_commit :broadcast_create_order
  after_update_commit :broadcast_update_order

  TABLES = 1..20
  WAITERS = ["Mozo1","Mozo2","Mozo3","Mozo4","Mozo5"]



  def broadcast_create_order
    @order = Order.find(self.id)
    ActionCable.server.broadcast "web_notifications_channel",
                                 message: html_new_order_chef(@order)
  end

  def broadcast_update_order
    @order = Order.find(self.id)
    case @order.status
    when "Finalizado"
      ActionCable.server.broadcast "web_notifications_channel", message: html_update_finalizado(@order)
    when "Pendiente"
      ActionCable.server.broadcast "web_notifications_channel", message: html_update_agregar(@order)
    when "Cancelado"
      ActionCable.server.broadcast "web_notifications_channel", message: html_cancelar_pedido(@order)
    end



  end


  private

    def html_new_order_chef(order)
      'chef<div class="alert alert-success alert-dismissible" role="alert"><a aria-label="close" class="close" data-dismiss="alert" href="#"> ×</a><h2>Nuevo pedido '+order.id.to_s+'</h2></div>
       <div id="accordion">
        <div class="card">
          <div class="card-header" id="headingOne">
            <h5 class="mb-0"><div class="title-card">
              <b>N:</b> <span>'+ order.id.to_s + '&nbsp; </span><b>Mozo:</b> <span>'+ order.name + '&nbsp; </span><b>Mesa:</b> <span>' + order.table.to_s + '&nbsp; </span> <b>Estado:</b> <span>' + order.status + '&nbsp; </span> <b>Actualizado</b> <span>'+ order.updated_at.strftime('%H:%M %d-%m-%y')+'</span>
            </div>
            <span>&nbsp; </span>' +
            ActionController::Base.helpers.link_to("Finalizar orden", Rails.application.routes.url_helpers.kitchen_path(order, order: {status: "Finalizado"}), class: "btn btn-success", remote: true, method: :put) +
          '</h5>
        </div>
        <div aria-labelledby="headingOne" class="collapse show" data-parent="#accordion" id="collapseOne">
          <div class="card-body">
            <table class="table table-striped table-hover">
              <thead>
                <tr>
                  <th>Plato</th>
                  <th>Cantidad</th>
                </tr>
              </thead>' + food_order_select(order) +
            '</table>
          </div>
        </div>
       </div>
      </div>'
    end
    def food_order_select(order)
      strings = order.food_orders.map do |food_order|
        '<tbody> <tr>
            <th>' + food_order.food.name + '</th>
            <th>' + food_order.quantity.to_s + ' </th>
        </tbody>'
      end
      strings.join
    end
    def html_update_finalizado(order)
      'mozo<div class="alert alert-success alert-dismissible" role="alert"><a aria-label="close" class="close" data-dismiss="alert" href="#"> ×</a><h2>Pedido ' +order.id.to_s+ ' Finalizado</h2>
        <h4><b>N:</b> <span>'+ order.id.to_s + '&nbsp; </span><b>Mozo:</b> <span>'+ order.name + '&nbsp; </span><b>Mesa:</b> <span>' + order.table.to_s + '&nbsp; </span> <b>Estado:</b> <span>' + order.status + '&nbsp; </span> <b>Actualizado</b> <span>'+ order.updated_at.strftime('%H:%M %d-%m-%y')+'</span></h3>
      </div>'
    end
    def html_update_agregar(order)
      'chef<div class="alert alert-success alert-dismissible" role="alert"><a aria-label="close" class="close" data-dismiss="alert" href="#"> ×</a><h2>Se agregan platos a la orden ' + order.id.to_s + '</h2></div>
       <div id="accordion">
        <div class="card">
          <div class="card-header" id="headingOne">
            <h5 class="mb-0"><div class="title-card">
              <b>N:</b> <span>'+ order.id.to_s + '&nbsp; </span><b>Mozo:</b> <span>'+ order.name + '&nbsp; </span><b>Mesa:</b> <span>' + order.table.to_s + '&nbsp; </span> <b>Estado:</b> <span>' + order.status + '&nbsp; </span> <b>Actualizado</b> <span>'+ order.updated_at.strftime('%H:%M %d-%m-%y')+'</span>
            </div>
            <span>&nbsp; </span>' +
            ActionController::Base.helpers.link_to("Finalizar orden", Rails.application.routes.url_helpers.kitchen_path(order, order: {status: "Finalizado"}), class: "btn btn-success", remote: true, method: :put) +
          '</h5>
        </div>
        <div aria-labelledby="headingOne" class="collapse show" data-parent="#accordion" id="collapseOne">
          <div class="card-body">
            <table class="table table-striped table-hover">
              <thead>
                <tr>
                  <th>Plato</th>
                  <th>Cantidad</th>
                </tr>
              </thead>' + food_order_select_status_pendiente(order) +
            '</table>
          </div>
        </div>
       </div>
      </div>'
    end
    def food_order_select_status_pendiente(order)
      strings = order.food_orders.where(status: "Pendiente").map do |food_order|
        '<tbody> <tr>
            <th>' + food_order.food.name + '</th>
            <th>' + food_order.quantity.to_s + ' </th>
        </tbody>'
      end
      strings.join
    end
    def html_cancelar_pedido(order)
      'chef<div class="alert alert-danger alert-dismissible" role="alert"><a aria-label="close" class="close" data-dismiss="alert" href="#"> ×</a><h2>Pedido ' +order.id.to_s+ ' Cancelado!! Detener su preparación</h2>
        <h4><b>N:</b> <span>'+ order.id.to_s + '&nbsp; </span><b>Mozo:</b> <span>'+ order.name + '&nbsp; </span><b>Mesa:</b> <span>' + order.table.to_s + '&nbsp; </span> <b>Estado:</b> <span>' + order.status + '&nbsp; </span> <b>Actualizado</b> <span>'+ order.updated_at.strftime('%H:%M %d-%m-%y')+'</span></h3>
      </div>'
    end
end
