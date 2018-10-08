class ClientHoseInteractionsController < ApplicationController
  before_action :set_client_hose_interaction, only: [:show, :update, :destroy]

  # GET /client_hose_interactions
  def index
    @client_hose_interactions = ClientHoseInteraction.all

    render json: @client_hose_interactions
  end

  # GET /client_hose_interactions/1
  def show
    render json: @client_hose_interaction
  end

  # POST /client_hose_interactions
  def create
    @client_hose_interaction = ClientHoseInteraction.new(client_hose_interaction_params)

    if @client_hose_interaction.save
      render json: @client_hose_interaction, status: :created, location: @client_hose_interaction
    else
      render json: @client_hose_interaction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /client_hose_interactions/1
  def update
    if @client_hose_interaction.update(client_hose_interaction_params)
      render json: @client_hose_interaction
    else
      render json: @client_hose_interaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /client_hose_interactions/1
  def destroy
    @client_hose_interaction.destroy
  end
  
  def updateHoseInteraction
    @interaction = ClientHoseInteraction.find(params[:interactionId])
    @interaction.heater_status_id = params[:statusId].to_i
    @interaction.save
    
    renter json: @interaction
  end
  
  def getHosesLoanedToClient
    @interactions = ClientHoseInteraction.where('heater_status_id = ? AND client_id = ?', 2, params[:clientId])
    
    render json: @interactions
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_hose_interaction
      @client_hose_interaction = ClientHoseInteraction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def client_hose_interaction_params
      params.require(:client_hose_interaction).permit(:client_id, :heater_status_id)
    end
end
