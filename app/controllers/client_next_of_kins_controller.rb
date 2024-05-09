class ClientNextOfKinsController < ApplicationController
  before_action :set_client_next_of_kin, only: [:show, :update, :destroy]

  # GET /client_next_of_kins
  def index
    @client_next_of_kins = ClientNextOfKin.all

    render json: @client_next_of_kins
  end

  # GET /client_next_of_kins/1
  def show
    render json: @client_next_of_kin
  end

  # POST /client_next_of_kins
  def create
    @client_next_of_kin = ClientNextOfKin.new(client_next_of_kin_params)

    if @client_next_of_kin.save
      render json: @client_next_of_kin, status: :created, location: @client_next_of_kin
    else
      render json: @client_next_of_kin.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /client_next_of_kins/1
  def update
    if @client_next_of_kin.update(client_next_of_kin_params)
      render json: @client_next_of_kin
    else
      render json: @client_next_of_kin.errors, status: :unprocessable_entity
    end
  end

  # DELETE /client_next_of_kins/1
  def destroy
    @client_next_of_kin.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_next_of_kin
      @client_next_of_kin = ClientNextOfKin.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_next_of_kin_params
      params.require(:client_next_of_kin).permit(:client_id, :name, :relation_to_client, :phone_number, :street_address, :email, :note)
    end
end
