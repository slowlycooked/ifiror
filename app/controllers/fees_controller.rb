class FeesController < ApplicationController
  before_action :set_fee, only: [:show, :edit, :update, :destroy]

  # GET /fees
  # GET /fees.json
=begin
  def index
    @fees = Fee.all
    @book = Book.find(params[:book_id])
    @fee = Fee.find(params[:id])
    @debit_sum = FeeRecord.sum('debit')
    @credit_sum = FeeRecord.sum('credit')
  end
=end

  # GET /fees/1
  # GET /fees/1.json
  def show
    @book = Book.find(params[:book_id])
    @fee = @book.fees.find(params[:id])
    @records = @fee.fee_records.where('left(fee_records.updated_at,4) =?', session[:current_year])
    @debit_sum = @records.sum("debit")
    @credit_sum =@records.sum("credit")

  end

  # GET /fees/new
  def new
    @book = Book.find(params[:book_id])
    @fee = Fee.new
  end

  # GET /fees/1/edit
  def edit
    @book = Book.find(params[:book_id])
    @fee = @book.fees.find(params[:id])

  end

  def create
    @book = Book.find(params[:book_id])
    @fee =  @book.fees.create(fee_params)

      if @fee.save
        redirect_to book_path(@book)

      else
        render :new

      end
  end

  # PATCH/PUT /fees/1
  # PATCH/PUT /fees/1.json
  def update
    respond_to do |format|
      if @fee.update(fee_params)
        format.html { redirect_to book_fee_path(@book,@fee), notice: '费项更新成功.' }
        format.json { render :show, status: :ok, location: @fee }
      else
        format.html { render :edit }
        format.json { render json: @fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fees/1
  # DELETE /fees/1.json
  def destroy
    book_id = @fee.book_id
    @fee.destroy
    redirect_to  book_path(book_id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fee
      @book = Book.find(params[:book_id])
      @fee = @book.fees.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fee_params
      params.require(:fee).permit(:fee_name)
    end
end
