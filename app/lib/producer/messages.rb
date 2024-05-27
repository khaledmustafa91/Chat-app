class Producer::Messages < Rabbitmq::Producer
  queue_name 'messages'
end