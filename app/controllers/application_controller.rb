class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :address1, :address2, :postcode, :phonenumber])
    devise_parameter_sanitizer.permit(:account_update, keys: [:firstname, :lastname, :address1, :address2, :postcode, :phonenumber])
  end
end
