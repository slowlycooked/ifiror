class CustomersController < ApplicationController
  before_action :set_customer, only: [:new, :show, :edit, :update, :destroy]

  def index
    @companies = Company.joins(:employments)
                        .where("tenant_id = ?", current_tenant.id)

    @company_ids = @companies.collect(&:id)
    @customer_ids = Customer.where("company_id in (?) ", @company_ids).collect(&:id)

    @customer_total = Record.select('com.name, sum(credit) credit, sum(debit) debit, sum(bad) bad')
                            .joins('INNER JOIN customers c on records.customer_id = c.id')
                            .joins('INNER JOIN companies com on c.company_id = com.id ')
                            .where('customer_id in (?)  and left(records.updated_at,4) = ?',
                                   @customer_ids, session[:current_year])
                            .group('com.name')


    @customer_group = Customer.select('com.name, customers.id, customers.cname, sum(records.credit) as credit,
                                sum(records.debit) as debit, sum(records.bad) as bad')
                              .joins('LEFT OUTER JOIN records on customers.id = records.customer_id
                                  and left(records.updated_at,4) = ', session[:current_year])
                              .joins('INNER JOIN companies com on customers.company_id = com.id ')
                              .where('customers.company_id in (?) ', @company_ids)
                              .group('com.name, customers.id, customers.cname')
                              .order('customers.id asc')
    #binding.pry

  end

  def new
    @customer = Customer.new
  end

  def create

    #render plain: params[:customer].inspect
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: '客户创建成功.' }
        #format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        #format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end

  end

  def edit
    if Customer.find_by_id(params[:id])
      @customer = Customer.find(params[:id])
    else
      redirect_to customers_path
    end
  end

  def update
    if Customer.find_by_id(params[:id])
      @customer = Customer.find(params[:id])

      if @customer.update(customer_params)
        redirect_to @customer
      else
        render 'edit'
      end
    else
      redirect_to customers_path
    end
  end

  def show

    if Customer.find_by_id(params[:id])
      @customer = Customer.find(params[:id])
      @records = @customer.records.where('left(updated_at,4) =?', session[:current_year]).order("id DESC")
      @debit_sum = @records.sum("debit").round(2)
      @credit_sum = @records.sum("credit").round(2)
      @bad_sum = @records.sum("bad").round(2)
      @remain_sum = (@credit_sum - @debit_sum + @bad_sum).round(2)
    else
      redirect_to customers_path
    end
  end

  def destroy
    if Customer.find_by_id(params[:id])
      @customer = Customer.find(params[:id])
      @customer.destroy
    end

    redirect_to customers_path
  end

  private



  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    #binding.pry
    @companies = Company.joins(:employments).where("tenant_id = ?", current_tenant.id)
    @customer = Customer.find_by_id(params[:id])

  end

  def customer_params
    params.require(:customer).permit(:cname, :phone_no, :company_id)
  end

end
