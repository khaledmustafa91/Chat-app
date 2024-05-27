module Rabbitmq::Helpers

  def set_variable(variable, value)
    instance_variable_set("@#{variable}", value)
    define_method(variable.to_sym) do
      self.class.instance_variable_get("@#{variable}")
    end
  end

  def queue_name(value)
    set_variable('queue_name', value)
  end

  def subscription_queue(value)
    set_variable('subscription_queue', value)
  end

  def pool_size(value)
    set_variable('pool_size', value)
  end
end