# frozen_string_literal: true

class ApplicationSerializer < ActiveModel::Serializer
  attributes :name, :token, :chats_count, :created_at, :updated_at
end
