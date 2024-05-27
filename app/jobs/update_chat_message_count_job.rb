# frozen_string_literal: true

class UpdateChatMessageCountJob < ApplicationJob
  queue_as :default

  def perform
    Chat::UpdateMessageCount.call
  end
end
