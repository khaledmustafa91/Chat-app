# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Applications::ChatsController, type: :request do
  let(:valid_attributes) { attributes_for(:chat) }
  let(:invalid_attributes) { attributes_for(:chat, :invalid) }
  let(:application) { create(:application) }
  let(:chat) { create(:chat, application: application) }
  let(:invalid_token) { '123' }

  describe 'GET /index' do
    before do
      chat
    end
    it 'renders a successful response' do
      get application_chats_url(application.token), as: :json
      expect(response).to be_successful
      expect(parsed_response_body[:chats].count).to eq(1)
    end
  end

  describe 'GET /show' do
    before do
      chat
    end
    it 'renders a successful response' do
      get application_chat_url(application.token, chat.chat_number), as: :json
      expect(response).to be_successful
      expect(parsed_response_body[:chat][:chat_number]).to eq(chat.chat_number)
    end
  end
end
