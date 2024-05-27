# frozen_string_literal: true

require 'active_support/concern'
module ExceptionsHandler
  extend ActiveSupport::Concern

  included do
    include ActiveSupport::Rescuable
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response
  end

  def record_not_found_response(message)
    render json: { error: [message] }, status: :not_found
  end
end
