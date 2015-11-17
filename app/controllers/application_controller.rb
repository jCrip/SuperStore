class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: 'Tu no tienes permiso para hacer esto!!! FUERAA'
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << [:name, :lastname, :username, :address, :latitude, :longitude]
      devise_parameter_sanitizer.for(:account_update) << [:name, :lastname, :username, :address, :latitude, :longitude]
    end

    def require_admin
      authenticate_user!
      redirect_to root_path unless current_user.admin?
    end
end
