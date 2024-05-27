# frozen_string_literal: true

class Message < ApplicationRecord
  searchkick word_middle: [:body]

  belongs_to :chat

  validates_presence_of :body
  validates_uniqueness_of :message_number, scope: :chat_id

  before_validation :set_message_number, on: :create

  def set_message_number
    return unless chat_id.present?

    max_number = self.class.where(chat_id: chat_id).maximum(:message_number) || 0

    self.message_number = max_number + 1
  end

  def search_data
    {
      body: body
    }
  end
end
