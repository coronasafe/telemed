class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :verifications_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :password_confirmation, :remember_me, :panchayat_id, :role, :name, :source])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username, :email, :password, :remember_me])
  end

  def verifications_controller?
    is_a?(::VerificationsController)
  end
end
