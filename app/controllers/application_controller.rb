class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_tenant!, :set_year

  protect_from_forgery with: :exception


  def after_sign_in_path_for(resource)
    root_path
  end

  private
  def set_year
    if session[:current_year] == nil
      session[:current_year] = Date.today.year.to_s
    end
  end
end
