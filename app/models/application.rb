# frozen_string_literal: true

class Application < ApplicationRecord
  has_many :chats

  validates_presence_of :name, :token
  validates_uniqueness_of :name, :token, case_sensitive: false
  before_validation :set_token
  before_validation :strip_whitespace

  def set_token
    return unless name.present?

    self.token = Digest::SHA1.hexdigest(name)[0..24]
  end

  def strip_whitespace
    return unless name.present?

    self.name = self.name.strip 
  end
end
