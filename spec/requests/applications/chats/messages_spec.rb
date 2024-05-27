# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Applications::Chats::MessagesController, type: :request do
  let(:application) { create(:application) }
  let(:chat) { create(:chat, application: application) }
  let(:valid_attributes) { attributes_for(:message) }
  let(:invalid_attributes) { attributes_for(:message, :invalid) }
  let(:message) { create(:message, chat: chat) }
  describe 'GET /index' do
    before do
      message
    end
    it 'renders a successful response' do
      get application_chat_messages_url(application.token, chat.chat_number), as: :json
      expect(response).to be_successful
      expect(parsed_response_body[:messages].count).to eq(1)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get application_chat_message_url(application.token, chat.chat_number, message.message_number), as: :json
      expect(response).to be_successful
      expect(parsed_response_body[:message][:message_number]).to eq(message.message_number)
    end
  end
end
