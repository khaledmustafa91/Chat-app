class Rabbitmq::Producer
  extend Rabbitmq::Helpers

  def publish(body)
    Rabbitmq.connection_pools.with do |channel|
      queue = channel.queue(queue_name, durable: true)
      queue.publish(body&.to_json, routing_key: queue_name)
    end
  end
end
