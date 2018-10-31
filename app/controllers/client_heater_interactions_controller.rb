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
    nowDate = DateTime.now
    startingDate = nowDate << 6
    heaters = ClientHeaterInteraction.where('client_id = ? AND created_at > ? AND status_id IN (?)', params[:clientId], startingDate, [4,5,6,7,8])
    
    render json: heaters
  end
  
  def updateHeaterInteraction
    #interactionId is actually the heaterId
    @interaction = ClientHeaterInteraction.where('heater_id = ? AND created_at = (SELECT MAX(created_at) from client_heater_interactions 
                            where heater_id = ?)', params[:interactionId], params[:interactionId])
    @interaction.status_id = params[:statusId]
    
    @interaction.save
    
    @heater = Heater.find(@interaction.heater_id)
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
      params.require(:client_heater_interaction).permit(:client_id, :heater_id)
    end
end
