class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :set_companies, only: [:new]

  # GET /fees
  # GET /fees.json
  def index
    @book = Book.all.where(company_id: session[:current_companies].collect(&:id))
    redirect_to root_path
  end

  def show
    if Book.find_by_id(params[:id])
      @book = Book.find_by_id(params[:id])
      @fees = @book.fees
      @debit_sum = @book.fee_records.where('left(fee_records.updated_at,4) =?', session[:current_year]).sum('debit').round(2)
      @credit_sum = @book.fee_records.where('left(fee_records.updated_at,4) =?', session[:current_year]).sum('credit').round(2)

      @group_by_fee = @fees.select('fees.book_id, fees.id, fees.fee_name,
                            sum(fee_records.debit) as debit, sum(fee_records.credit) as credit')
                           .joins("LEFT OUTER JOIN fee_records on fees.id=fee_records.fee_id
                                and left(fee_records.updated_at,4) = #{session[:current_year]}")
                           .group('fees.book_id, fees.id, fees.fee_name')
                           .order('fees.updated_at DESC')

    else
      redirect_to root_path
    end
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
    #@book.tenant_id = current_tenant.id
    #binding.pry
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

  def destroy

    @book.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: '账本删除成功.' }
      format.json { head :no_content }
    end
  end

  def show_monthly_report
    if Book.find_by_id(params[:book_id])
      @book = Book.find(params[:book_id])
      @records = @book.fee_records.where('year(fee_records.updated_at) =?', session[:current_year])
      @debit_sum = @records.sum("debit")
      @credit_sum = @records.sum("credit")
      @groupby_month = Book.get_monthly_sum(params[:book_id], session[:current_year])
    else
      redirect_to root_path
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_book
    if Book.find_by_id(params[:id])
      @book = Book.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def set_companies
    @companies = Company.where(id: session[:current_companies])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def book_params
    params.require(:book).permit(:book_name, :company_id)
  end

end
