class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :login_required
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def login_required
    unless user_signed_in?
      redirect_to unauthenticated_root_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :affiliation_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :affiliation_id])
  end
end