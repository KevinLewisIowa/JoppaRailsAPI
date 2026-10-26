class ClientDisabilityAndDisordersController < ApplicationController
  before_action :authorize_admin!
  before_action :set_client_disability_and_disorder, only: [:show, :update, :destroy]

  def index
    @client_disability_and_disorders = ClientDisabilityAndDisorder.order(:category)
    render json: @client_disability_and_disorders
  end

  def show
    render json: @client_disability_and_disorder
  end

  def create
    @client_disability_and_disorder = ClientDisabilityAndDisorder.new(client_disability_and_disorder_params)

    if @client_disability_and_disorder.save
      render json: @client_disability_and_disorder, status: :created, location: @client_disability_and_disorder
    else
      render json: @client_disability_and_disorder.errors, status: :unprocessable_entity
    end
  end

  def update
    if @client_disability_and_disorder.update(client_disability_and_disorder_params)
      render json: @client_disability_and_disorder
    else
      render json: @client_disability_and_disorder.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @client_disability_and_disorder.destroy
  end

  def getClientDisabilityAndDisorders
    @client_disability_and_disorders = ClientDisabilityAndDisorder.where(client_id: params[:clientId]).order(:category)
    render json: @client_disability_and_disorders
  end

  private

  def set_client_disability_and_disorder
    @client_disability_and_disorder = ClientDisabilityAndDisorder.find(params[:id])
  end

  def client_disability_and_disorder_params
    params.require(:client_disability_and_disorder).permit(:client_id, :category, :diagnosis_status, :type_name, :year_diagnosed, :clinically_diagnosed, :note)
  end
end
