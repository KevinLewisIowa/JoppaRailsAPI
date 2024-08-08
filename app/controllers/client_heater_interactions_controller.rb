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
  
  def getHeatersNotReturnedForClient
    nowDate = DateTime.current
    startingDate = nowDate.days_ago(30)
    heaters = ClientHeaterInteraction.where('client_id = ? AND updated_at > ? AND status_id IN (?)', params[:clientId], startingDate, [3,4,5,6,7])
    
    render json: heaters
  end
  
  def updateHeaterInteraction
    #interactionId is actually the heaterId
    @interactions = ClientHeaterInteraction.where('heater_id = ?', params[:interactionId])
    @interaction = @interactions.last
    @interaction.status_id = params[:statusId].to_i
    @interaction.updated_at = DateTime.current
    
    @interaction.save
    
    @heater = Heater.find(params[:interactionId])
    @heater.heater_status_id = params[:statusId]
    @heater.save
    
    render json: @interaction
  end

  # DELETE /client_heater_interactions/1
  def destroy
    @client_heater_interaction.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_heater_interaction
      @client_heater_interaction = ClientHeaterInteraction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def client_heater_interaction_params
      params.require(:client_heater_interaction).permit(:client_id, :heater_id, :updated_at)
    end
end
