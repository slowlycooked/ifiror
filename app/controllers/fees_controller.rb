class FeesController < ApplicationController
  before_action :set_fee, only: [:show, :edit, :update, :destroy]

  # GET /fees
  # GET /fees.json
  def index
    @fees = Fee.all
    @debit_sum = FeeRecord.sum('debit')
    @credit_sum = FeeRecord.sum('credit')
  end

  # GET /fees/1
  # GET /fees/1.json
  def show
    @fee = Fee.find(params[:id])
    @records = @fee.fee_records
    @debit_sum = @records.sum("debit")
    @credit_sum =@records.sum("credit")

  end

  # GET /fees/new
  def new
    @fee = Fee.new
  end

  # GET /fees/1/edit
  def edit
    @fee = Fee.find(params[:id])
  end

  # POST /fees
  # POST /fees.json
  def create
    @fee = Fee.new(fee_params)

    respond_to do |format|
      if @fee.save
        format.html { redirect_to @fee, notice: '费项创建成功.' }
        format.json { render :show, status: :created, location: @fee }
      else
        format.html { render :new }
        format.json { render json: @fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fees/1
  # PATCH/PUT /fees/1.json
  def update
    respond_to do |format|
      if @fee.update(fee_params)
        format.html { redirect_to @fee, notice: '费项更新成功.' }
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
    @fee.destroy
    respond_to do |format|
      format.html { redirect_to fees_url, notice: '费项删除成.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fee
      @fee = Fee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fee_params
      params.require(:fee).permit(:fee_name)
    end
end
