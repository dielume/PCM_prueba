class KitchenChannel < ApplicationCable::Channel
  def subscribed
    stream_from params['kitchen_id']
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    # process data sent from the page
  end
end
