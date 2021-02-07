class WelcomeController < ApplicationController
  before_action :authenticate_tenant!
  before_action :set_current_companies

  def index
    @current_companies = Company.joins(:employments)
                                .where("tenant_id = ?", current_tenant.id)
    @books = Book.all.where(company_id:  session[:current_companies])
  end

  def set_current_year
    session[:return_to] = request.referer
    session[:current_year] = welcome_params['year']
    redirect_to session[:return_to]
  end

  #---2021-01-27----
  def roles
    @tenants = Tenant.all
  end

  def set_role
    #
    @tenant = Tenant.find_by_id(params[:tenant_id])
    #binding.pry
    #
    respond_to do |format|
      if @tenant.update_attribute(:role, params[:tenant][:role])
        format.html { redirect_to tenants_roles_path, notice: '费项更新成功.' }
      end
    end

  end

  private

  def set_current_companies
    #@current_companies =
    session[:current_companies] = Company.joins(:employments)
                                         .where("tenant_id = ?", current_tenant.id)
                                         .collect(&:id)
    #binding.pry
  end

  def welcome_params
    params.require(:welcome).permit(:year, :role, :tenant_id)
  end

end


