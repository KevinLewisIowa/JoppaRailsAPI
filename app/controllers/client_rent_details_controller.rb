class ClientRentDetailsController < ApplicationController
  before_action :authorize_admin!
  before_action :set_client_rent_detail, only: [:update]

  def create
    client = Client.find(client_rent_detail_params[:client_id])
    @client_rent_detail = client.build_client_rent_detail(client_rent_detail_params.except(:client_id))

    if @client_rent_detail.save
      render json: @client_rent_detail, status: :created
    else
      render json: @client_rent_detail.errors, status: :unprocessable_entity
    end
  end

  def update
    if @client_rent_detail.update(client_rent_detail_update_params)
      render json: @client_rent_detail
    else
      render json: @client_rent_detail.errors, status: :unprocessable_entity
    end
  end

  def getClientRentDetails
    client = Client.find(params[:clientId])
    @client_rent_detail = client.client_rent_detail

    if @client_rent_detail
      render json: @client_rent_detail
    else
      render json: { error: "Rent details not found for client" }, status: :not_found
    end
  end

  private

  def set_client_rent_detail
    @client_rent_detail = ClientRentDetail.find(params[:id])
  end

  def client_rent_detail_params
    params.require(:client_rent_detail).permit(
      :client_id, :rent_cost, :utilities_included, :utilities_cost, :who_is_paying, :note
    )
  end

  def client_rent_detail_update_params
    params.require(:client_rent_detail).permit(
      :rent_cost, :utilities_included, :utilities_cost, :who_is_paying, :note
    )
  end
end
