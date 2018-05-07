class Order < ApplicationRecord
  has_many :food_orders, dependent: :destroy
  validates :table, :status, :name, presence: true
  after_create_commit :broadcast_new_order
  after_update_commit :broadcast_message

  TABLES = 1..20
  WAITERS = ["Mozo1","Mozo2","Mozo3","Mozo4","Mozo5"]

  def broadcast_message
    ActionCable.server.broadcast "web_notifications_channel",
                                 message: '<p>Hello World!</p>'
  end

  def broadcast_new_order
    @order = Order.find(self.id)
    ActionCable.server.broadcast "web_notifications_channel",
                                 message: html_new_order_chef(@order)

  end

  private

    def html_new_order_chef(order)

      '<div class="alert alert-danger alert-dismissible" role="alert"><a aria-label="close" class="close" data-dismiss="alert" href="#"> ×</a><h2>Nuevo pedido</h2></div>
       <div id="accordion">
        <div class="card">
          <div class="card-header" id="headingOne">
            <h5 class="mb-0"><div class="title-card">
              <b>Mozo:</b> <span>'+ order.name + '&nbsp; &nbsp;</span><b>Mesa:</b> <span>' + order.table.to_s + '&nbsp; &nbsp;</span> <b>Estado:</b> <span>' + order.status + '&nbsp; &nbsp;</span> <b>Actualizado</b> <span>'+ order.updated_at.strftime('%H:%M %d-%m-%y')+'</span>
            </div>
            <span>&nbsp; &nbsp;</span>' +
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



end
