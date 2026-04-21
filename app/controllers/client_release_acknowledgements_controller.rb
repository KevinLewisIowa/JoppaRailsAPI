class ClientReleaseAcknowledgementsController < ApplicationController
  before_action :set_client_release_acknowledgement, only: [:show, :update, :destroy]

  # GET /client_release_acknowledgements
  def index
    @client_release_acknowledgements = ClientReleaseAcknowledgement.all

    render json: @client_release_acknowledgements
  end

  # GET /client_release_acknowledgements/1
  def show
    render json: @client_release_acknowledgement
  end

  # POST /client_release_acknowledgements
  def create
    @client_release_acknowledgement = ClientReleaseAcknowledgement.new(client_release_acknowledgement_params)

    if @client_release_acknowledgement.save
      render json: @client_release_acknowledgement, status: :created, location: @client_release_acknowledgement
    else
      render json: @client_release_acknowledgement.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /client_release_acknowledgements/1
  def update
    if @client_release_acknowledgement.update(client_release_acknowledgement_params)
      render json: @client_release_acknowledgement
    else
      render json: @client_release_acknowledgement.errors, status: :unprocessable_entity
    end
  end

  # DELETE /client_release_acknowledgements/1
  def destroy
    @client_release_acknowledgement.destroy
  end
  
  # GET /getClientReleaseAcknowledgements?clientId={id}
  def getClientReleaseAcknowledgements
    @acknowledgements = ClientReleaseAcknowledgement.where('client_id = ?', params[:clientId])
    
    render json: @acknowledgements
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_release_acknowledgement
      @client_release_acknowledgement = ClientReleaseAcknowledgement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_release_acknowledgement_params
      params.require(:client_release_acknowledgement).permit(:client_id, :date_acknowledged, :notes)
    end
end
