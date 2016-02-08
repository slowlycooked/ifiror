class WelcomeController < ApplicationController

  def index
    @books = Book.all.where(tenant_id: current_tenant.id)
  end
end

