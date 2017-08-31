class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { render json: {status: 'error', error: 'Access denied'}, status: :unauthorized }
      format.html { redirect_to root_url, alert: exception.message }
    end
  end

protected

  def configure_permitted_parameters
    #devise_parameter_sanitizer.permit(:account_update, keys: [:last_name, :first_name])
  end
end
