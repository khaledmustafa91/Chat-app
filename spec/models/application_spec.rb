# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Application, type: :model do
  let(:application) { build(:application) }
  let(:invalid_application) { build(:application, name: nil) }

  context 'with valid attributes' do
    it 'returns success' do
      expect(application).to be_valid
    end
  end

  context 'with invalid attributes' do
    it 'returns success' do
      expect(invalid_application).to be_invalid
    end
  end

  describe '#validations' do
    context 'without name' do
      it 'fails and return errors' do
        application.name = nil
        expect(application).to be_invalid
        expect(application.errors.messages[:name]).to be_present
      end
    end
  end
end
