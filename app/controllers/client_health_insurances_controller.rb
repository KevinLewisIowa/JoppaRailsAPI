class ClientHealthInsurancesController < ApplicationController
  before_action :set_client_health_insurance, only: [:show, :update, :destroy]

  # GET /client_health_insurances
  def index
    @client_health_insurances = ClientHealthInsurance.all

    render json: @client_health_insurances
  end

  # GET /client_health_insurances/1
  def show
    render json: @client_health_insurance
  end

  # POST /client_health_insurances
  def create
    @client_health_insurance = ClientHealthInsurance.new(client_health_insurance_params)

    if @client_health_insurance.save
      render json: @client_health_insurance, status: :created, location: @client_health_insurance
    else
      render json: @client_health_insurance.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /client_health_insurances/1
  def update
    if @client_health_insurance.update(client_health_insurance_params)
      render json: @client_health_insurance
    else
      render json: @client_health_insurance.errors, status: :unprocessable_entity
    end
  end

  # DELETE /client_health_insurances/1
  def destroy
    @client_health_insurance.destroy
  end
  
  # GET getClientHealthInsurance?clientId={cid}
  def getClientHealthInsurance
    @healthInsurances = ClientHealthInsurance.where(:client_id => params[:clientId])
    
    render json: @healthInsurances
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_health_insurance
      @client_health_insurance = ClientHealthInsurance.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_health_insurance_params
      params.require(:client_health_insurance).permit(:client_id, :has_health_insurance, :company)
    end
end
