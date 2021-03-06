class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_tenant!
  before_action  :set_year, :configure_devise_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception


  def after_sign_in_path_for(resource)
    root_path
    #user_url(current_tenant)
  end

  protected
  def set_year
    if session[:current_year] == nil
      session[:current_year] = Date.today.year.to_s
    end
  end


  def configure_devise_permitted_parameters

    registration_params = [:login, :name, :mobile, :invitation]

    #devise_parameter_sanitizer.permit(:sign_up)  { |u| u.permit(:name, :mobile, :invitation) }
    #devise_parameter_sanitizer.permit(:sign_up) <<  registration_params
    #devise_parameter_sanitizer.permit(:sign_in) << :login
    devise_parameter_sanitizer.permit(:sign_up, keys: [:login, :name, :mobile, :invitation])
    #devise_parameter_sanitizer.permit(:sign_in)
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login])

  end

end
