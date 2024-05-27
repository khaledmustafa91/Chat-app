# frozen_string_literal: true

class MessageSerializer < ActiveModel::Serializer
  attributes :body, :message_number
end
