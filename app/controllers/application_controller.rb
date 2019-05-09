# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken

  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters, if: :devise_controller?

  # GET /status
  def status
    render json: { online: true }
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[gender])
  end
end
