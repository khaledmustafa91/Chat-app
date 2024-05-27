class Consumer::Chats < Rabbitmq::Consumer
  subscription_queue 'chats'

  def on_receive(properties, payload, delivery_info = nil)
    return if payload.nil?

    attributes = payload.with_indifferent_access
    application = Application.find_by_token!(attributes[:application_token])
    chat = application.chats.new

    raise StandardError, chat.errors.messages unless chat.save

    rescue ActiveRecord::RecordNotUnique
      Rails.logger.error 'The record is not unique, please try again'
    rescue ActiveRecord::RecordNotFound
      Rails.logger.error 'The application not found'
  end
end