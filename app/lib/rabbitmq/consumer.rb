class Rabbitmq::Consumer
  extend Rabbitmq::Helpers
  pool_size 5

  def subscribe
    queue = channel.queue(subscription_queue, durable: true)
    queue.subscribe(block: false) do |delivery_info, properties, payload|
      message = JSON.parse(payload)
      on_receive(properties, message, delivery_info)

      rescue StandardError => error
        Rails.logger.error error.message
    end
  end

  def channel
    @channel ||= Rabbitmq.new_channel(pool_size)
  end

  def on_receive(properties, payload, delivery_info = nil)
    raise NotImplementedError
  end
end