# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationsController, type: :request do
  let(:valid_attributes) { attributes_for(:application) }
  let(:invalid_attributes) { attributes_for(:application, :invalid) }
  let(:application) { create(:application) }

  describe 'GET /index' do
    before do
      application
    end
    it 'renders a successful response' do
      get applications_url, as: :json
      expect(response).to be_successful
      expect(parsed_response_body[:applications].count).to eq(1)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get application_url(application.token), as: :json
      expect(response).to be_successful
      expect(parsed_response_body[:application][:token]).to eq(application.token)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Application' do
        expect do
          post applications_url, params: { application: valid_attributes }, as: :json
        end.to change(Application, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'fail and return errors' do
        post applications_url, params: { application: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_response_body[:name]).to be_present
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'updates the requested application' do
        patch application_url(application.token), params: { application: { name: 'New' } }, as: :json
        application.reload
        expect(response).to have_http_status(:ok)
        expect(application.name).to eq('New')
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the application' do
        patch application_url(application.token), params: { application: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_response_body[:name]).to be_present
      end
    end
  end
end
