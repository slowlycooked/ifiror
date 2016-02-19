class FeesController < ApplicationController
  before_action :set_fee, only: [:show, :edit, :update, :destroy]

  def show
    if Book.find_by_id(params[:book_id])
      @book = Book.find(params[:book_id])
      @fee = @book.fees.find(params[:id])
      @records = @fee.fee_records.where('left(fee_records.updated_at,4) =?', session[:current_year]).order('updated_at')
      @debit_sum = @records.sum("debit")
      @credit_sum =@records.sum("credit")
    else
      redirect_to root_path
    end
  end

  def show_monthly_report


    if Book.find_by_id(params[:book_id])
      @book = Book.find(params[:book_id])
      @fee = @book.fees.find(params[:fee_id])
      @records = @fee.fee_records.where('year(fee_records.updated_at) =?', session[:current_year])
      @debit_sum = @records.sum("debit")
      @credit_sum =@records.sum("credit")

      @groupby_month = @records.select(' month(updated_at) as month,
                             sum(fee_records.debit) as debit, sum(fee_records.credit) as credit')
                           .group('month(updated_at)')
                           .order('month(updated_at) ASC')

    else
      redirect_to root_path
    end
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
