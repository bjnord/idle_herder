class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    accounts_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { render json: {status: 'error', error: 'Access denied'}, status: :unauthorized }
      format.html { render '/errors/401', status: :unauthorized }
    end
  end

  # https://jtway.co/5-steps-to-add-remote-modals-to-your-rails-app-8c21213b4d0c
  def respond_modal_with(*args, &blk)
    options = args.extract_options!
    options[:responder] = ModalResponder
    respond_with *args, options, &blk
  end

protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:player_name, :invitation_code])
    #devise_parameter_sanitizer.permit(:account_update, keys: [:last_name, :first_name])
  end
end
