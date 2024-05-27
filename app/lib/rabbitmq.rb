# frozen_string_literal: true

class Rabbitmq
  def self.initialize_connection_pool
    @connection_pools = ConnectionPool.new(size: 5) do
      connection = new_connection
      channel = connection.create_channel
      channel.confirm_select
      channel
    end
  end

  def self.connection_pools
    initialize_connection_pool unless @connection_pools.present?
    @connection_pools
  end

  def self.new_channel(pool_size)
    new_connection.create_channel(nil, pool_size)
  end

  def self.new_connection
    connection = Bunny.new(
      host: ENV.fetch('RABBITMQ_HOST', 'rabbitmq'),
      port: ENV.fetch('RABBITMQ_PORT', 5672),
      user: ENV.fetch('RABBITMQ_DEFAULT_USER', 'guest'),
      pass: ENV.fetch('RABBITMQ_DEFAULT_PASS', 'guest'),
      vhost: ENV.fetch('RABBITMQ_VHOST', '/'),
      tls: ENV.fetch('RABBITMQ_TLS', false) ? true : false,
      verify_peer: ENV.fetch('RABBITMQ_VERIFY_PEER', false) ? true : false,
      heartbeat: 5
    )
    connection.start
  rescue Bunny::TCPConnectionFailed
    sleep 5.0
    new_connection
  end
end
