class ClientHeaterInteractionsController < ApplicationController
  before_action :set_client_heater_interaction, only: [:show, :update, :destroy]

  # GET /client_heater_interactions
  def index
    @client_heater_interactions = ClientHeaterInteraction.all

    render json: @client_heater_interactions
  end

  # GET /client_heater_interactions/1
  def show
    render json: @client_heater_interaction
  end

  # POST /client_heater_interactions
  def create
    @client_heater_interaction = ClientHeaterInteraction.new(client_heater_interaction_params)

    if @client_heater_interaction.save
      render json: @client_heater_interaction, status: :created, location: @client_heater_interaction
    else
      render json: @client_heater_interaction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /client_heater_interactions/1
  def update
    if @client_heater_interaction.update(client_heater_interaction_params)
      render json: @client_heater_interaction
    else
      render json: @client_heater_interaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /client_heater_interactions/1
  def destroy
    @client_heater_interaction.destroy
  end
  
  def getHosesLoanedToClient
    @interactions = ClientHoseInteraction.where('heater_status_id = ? AND client_id = ?', 2, params[:clientId])
    
    render json: @interactions
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_heater_interaction
      @client_heater_interaction = ClientHeaterInteraction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def client_heater_interaction_params
      params.require(:client_heater_interaction).permit(:client_id, :heater_id)
    end
end
