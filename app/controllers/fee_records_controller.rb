class FeeRecordsController < ApplicationController
  def create
    @fee = Fee.find(params[:fee_id])
    @record =  @fee.fee_records.create(record_params)
    redirect_to fee_path(@fee)
  end

  def destroy
    @fee = Fee.find(params[:fee_id])
    @record = @fee.fee_records.find(params[:id])
    @record.destroy
    redirect_to fee_path(@fee)
  end

  def edit
    @record = Fee.find(params[:fee_id]).fee_records.find(params[:id])
  end

  def update

    @fee = Fee.find(params[:fee_id])
    @record = @fee.fee_records.find(params[:id])

    if @record.update(record_params)
      redirect_to fee_path(@fee)
    else
      render 'edit'
    end
  end


  private
  def record_params
    params.require(:fee_record).permit(:book_id, :credit, :debit)
  end

end
