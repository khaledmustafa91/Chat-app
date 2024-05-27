# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:message) { build_stubbed(:message) }
  let(:invalid_message) { build_stubbed(:message, chat: nil) }

  context 'with valid attributes' do
    it 'returns success' do
      expect(message).to be_valid
    end
  end

  context 'with invalid attributes' do
    it 'returns success' do
      expect(invalid_message).to be_invalid
    end
  end

  describe '#validations' do
    context 'without chat' do
      it 'fails and return errors' do
        message.chat = nil
        expect(message).to be_invalid
        expect(message.errors.messages[:chat]).to be_present
      end
    end
  end
end
