class Producer::Chats < Rabbitmq::Producer
  queue_name 'chats'
end