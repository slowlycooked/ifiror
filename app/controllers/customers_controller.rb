class CustomersController < ApplicationController
  def index
    @customers = Customer.all.joins('LEFT OUTER JOIN records on customers.id = records.customer_id').order('records.updated_at DESC').uniq

    @debit_sum = Record.sum('debit')
    @credit_sum = Record.sum('credit')
    @bad_sum = Record.sum('bad')

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
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])

    if @customer.update(customer_params)
      redirect_to @customer
    else
      render 'edit'
    end
  end

  def show
    @customer = Customer.find(params[:id])
    @records = @customer.records
    @debit_sum = @customer.records.sum("debit")
    @credit_sum = @customer.records.sum("credit")
    @bad_sum = @customer.records.sum("bad")
    @remain_sum = @credit_sum - @debit_sum + @bad_sum

  end

  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    redirect_to customers_path
  end


  private
  def customer_params
    params.require(:customer).permit(:cname, :phone_no)
  end

end
