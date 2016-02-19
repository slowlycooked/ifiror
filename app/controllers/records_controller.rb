class RecordsController < ApplicationController
  def create
    @customer = Customer.find(params[:customer_id])
    @record = @customer.records.new(record_params)
    @record.tenant_id = @customer.tenant_id
    respond_to do |format|
      if @record.save
        @customer.update_attribute('updated_at', Time.now)
        format.html { redirect_to customer_path(@customer), notice: '记录创建成功.' }
      else
        format.html { redirect_to customer_path(@customer), notice: @record.errors }
      end
    end
  end

  def destroy
    @customer = Customer.find(params[:customer_id])
    @record = @customer.records.find(params[:id])
    @record.destroy
    redirect_to customer_path(@customer)
  end

  def edit
    @record = Customer.find(params[:customer_id]).records.find(params[:id])
  end

  def update

    @customer = Customer.find(params[:customer_id])
    @record = @customer.records.find(params[:id])

    if @record.update(record_params)
      redirect_to customer_path(@customer)
    else
      render 'edit'
    end
  end



  private
  def record_params
    params.require(:record).permit(:book_id,:updated_at, :debit, :credit,:bad)
  end


end
