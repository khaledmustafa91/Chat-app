class Consumer::Messages < Rabbitmq::Consumer
  subscription_queue 'messages'

  def on_receive(properties, payload, delivery_info = nil)
    return if payload.nil?

    attributes = payload.with_indifferent_access
    message = Message.find_or_initialize_by(attributes.except(:body))
    message.body = attributes[:body]

    raise StandardError, message.errors.messages unless message.save
    message.reindex

    rescue ActiveRecord::RecordNotUnique
      Rails.logger.error 'The record is not unique, please try again'
  end
end