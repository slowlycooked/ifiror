class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /fees
  # GET /fees.json
  def index
    @book = Book.all


  end

  # GET /fees/1
  # GET /fees/1.json
  def show
    @book = Book.find(params[:id])
    @fees = @book.fees
    @debit_sum = @book.fee_records.sum('debit')
    @credit_sum = @book.fee_records.sum('credit')

  end

  # GET /fees/new
  def new
    @book = Book.new
  end

  # GET /fees/1/edit
  def edit
    @book = Book.find(params[:id])

  end

  # POST /fees
  # POST /fees.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: '创建成功.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fees/1
  # PATCH/PUT /fees/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: '更新成功.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fees/1
  # DELETE /fees/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: '账本删除成功.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def book_params
    params.require(:book).permit(:book_name)
  end
end
