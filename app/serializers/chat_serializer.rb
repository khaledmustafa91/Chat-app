# frozen_string_literal: true

class ChatSerializer < ActiveModel::Serializer
  attributes :chat_number, :message_count
end
