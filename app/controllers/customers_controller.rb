class CustomersController < ApplicationController

  def index
    @customers = Customer
        .joins('LEFT OUTER JOIN records on customers.id = records.customer_id
            and left(records.updated_at,4) = ', session[:current_year])
        .where('customers.tenant_id= ? ', current_tenant.id)
                     .order('records.updated_at DESC').uniq

    @debit_sum = @customers.sum('debit')
    @credit_sum = @customers.sum('credit')
    @bad_sum = @customers.sum('bad')

  end

  def new
    @customer = Customer.new
  end

  def create
    #render plain: params[:customer].inspect
    @customer = Customer.new(customer_params)
    @customer.tenant_id = current_tenant.id
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
      @records = @customer.records.where('left(updated_at,4) =?', session[:current_year])
      @debit_sum = @records.sum("debit")
      @credit_sum = @records.sum("credit")
      @bad_sum = @records.sum("bad")
      @remain_sum = @credit_sum - @debit_sum + @bad_sum
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
  def customer_params
    params.require(:customer).permit(:cname, :phone_no)
  end

end
