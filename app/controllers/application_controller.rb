class ApplicationController < ActionController::Base
    before_action :authenticate_request
    attr_reader :current_client

  private
  def authenticate_request
    @current_employee = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_employee
  end

  include Pundit

  protect_from_forgery with: :null_session    
end
