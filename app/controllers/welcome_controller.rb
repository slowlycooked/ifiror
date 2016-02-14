class WelcomeController < ApplicationController
  before_action :set_year

  def index
    @books = Book.all.where(tenant_id: current_tenant.id)

  end

  def set_current_year
    session[:return_to] = request.referer
    session[:current_year] = welcome_params['year']
    redirect_to session[:return_to]
  end

  private
  def welcome_params
    params.require(:welcome).permit(:year)
  end

  def set_year
    if session[:current_year] == nil
      session[:current_year] = Date.today.year.to_s
    end



  end

end


