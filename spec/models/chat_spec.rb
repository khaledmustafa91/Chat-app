# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Chat, type: :model do
  let(:chat) { build_stubbed(:chat) }
  let(:invalid_chat) { build_stubbed(:chat, application: nil) }

  context 'with valid attributes' do
    it 'returns success' do
      expect(chat).to be_valid
    end
  end

  context 'with invalid attributes' do
    it 'returns success' do
      expect(invalid_chat).to be_invalid
    end
  end

  describe '#validations' do
    context 'without application' do
      it 'fails and return errors' do
        chat.application = nil
        expect(chat).to be_invalid
        expect(chat.errors.messages[:application]).to be_present
      end
    end
  end
end
