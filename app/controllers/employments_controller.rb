class EmploymentsController < ApplicationController
  before_action :set_employment, only: [:show, :edit, :update, :destroy]
  before_action :set_companies, only: [:new]


  # GET /employments
  # GET /employments.json
  def index
    #@employments = Employment.all

    @employments = Employment.select('employments.id,tenant_id,company_id, t.name as tenant_name, com.name as company_name ')
                             .joins('INNER JOIN tenants t on tenant_id = t.id')
                             .joins('INNER JOIN companies com on company_id = com.id ')
                             .where('employments.tenant_id = ? ', params[:tenant_id])
  end

  # GET /employments/1
  # GET /employments/1.json
  def show
    @employments = Employment.all
  end

  # GET /employments/new
  def new
    @employment = Employment.new
  end

  # GET /employments/1/edit
  def edit
  end

  # POST /employments
  # POST /employments.json
  def create
    @employment = Employment.new(employment_params)

    respond_to do |format|
      if @employment.save
        format.html {  redirect_to employments_path(:tenant_id => @employment.tenant_id), notice: 'Employment was successfully created.' }
        format.json { render :show, status: :created, location: @employment }
      else
        format.html { render :new }
        format.json { render json: @employment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employments/1
  # PATCH/PUT /employments/1.json
  def update

  end

  # DELETE /employments/1
  # DELETE /employments/1.json
  def destroy
    @employment.destroy
    respond_to do |format|
      format.html { redirect_to employments_path(:tenant_id => @employment.tenant_id) , notice: 'Employment was successfully Destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  #
  def set_employment
    @employment=Employment.find(params[:id])
  end

  def set_companies
    @companies=Company.all
    #binding.pry
  end

  # Only allow a list of trusted parameters through.
  def employment_params
    params.fetch(:employment, {})
    params.require(:employment).permit(:tenant_id,:company_id)

  end

end
