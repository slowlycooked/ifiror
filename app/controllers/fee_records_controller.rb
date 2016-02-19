class FeeRecordsController < ApplicationController
  def create

    @fee = Fee.find(params[:fee_id])
    @record =  @fee.fee_records.create(record_params)
    @fee.update_attribute("updated_at", record_params[:updated_at])
    redirect_to book_fee_path(@fee.book_id,@fee.id)
  end

  def destroy
    @fee = Fee.find(params[:fee_id])
    @record = @fee.fee_records.find(params[:id])
    @record.destroy
    redirect_to book_fee_path(@fee.book_id,@fee.id)
  end

  def edit
    @book = Book.find(params[:book_id])
    @fee = @book.fees.find(params[:fee_id])
    @record = @fee.fee_records.find(params[:id])
  end

  def update
    @book = Book.find(params[:book_id])
    @fee = @book.fees.find(params[:fee_id])
    @record = @fee.fee_records.find(params[:id])

    if @record.update(record_params)
      redirect_to book_fee_path(@fee.book_id,@fee.id)
    else
      render 'edit'
    end
  end


  private
  def record_params
    params.require(:fee_record).permit(:fee_id,:updated_at, :credit, :debit,:comment)
  end

end
