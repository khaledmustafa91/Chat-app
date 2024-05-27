class Applications::BaseController < ApplicationController
  before_action :set_application
 
  def set_application
    @application = Application.find_by_token!(params[:application_token])
  end
end
