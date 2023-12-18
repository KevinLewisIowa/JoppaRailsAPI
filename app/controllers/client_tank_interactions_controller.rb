class ClientTankInteractionsController < ApplicationController
  before_action :set_client_tank_interaction, only: [:show, :update, :destroy]

  # GET /client_tank_interactions
  def index
    @client_tank_interactions = ClientTankInteraction.all

    render json: @client_tank_interactions
  end

  # GET /client_tank_interactions/1
  def show
    render json: @client_tank_interaction
  end

  # POST /client_tank_interactions
  def create
    @client_tank_interaction = ClientTankInteraction.new(client_tank_interaction_params)

    if @client_tank_interaction.save
      render json: @client_tank_interaction, status: :created, location: @client_tank_interaction
    else
      render json: @client_tank_interaction.errors, status: :unprocessable_entity
    end
  end
  
  def getTanksLoanedToClient
    @interactions = ClientTankInteraction.where('status_id = ? AND client_id = ?', 2, params[:clientId])
    
    render json: @interactions
  end

  # PATCH/PUT /client_tank_interactions/1
  def update
    if @client_tank_interaction.update(client_tank_interaction_params)
      render json: @client_tank_interaction
    else
      render json: @client_tank_interaction.errors, status: :unprocessable_entity
    end
  end
  
  def updateTankInteraction
    @interaction = ClientTankInteraction.find(params[:interactionId])
    @interaction.status_id = params[:statusId].to_i
    @interaction.updated_at = DateTime.current
    @interaction.save
    
    render json: @interaction
  end
  
  def getTanksNotReturnedForClient
    nowDate = DateTime.current
    startingDate = nowDate.days_ago(30)
    tanks = ClientTankInteraction.where('client_id = ? AND updated_at > ? AND status_id IN (?)', params[:clientId], startingDate, [3,4,5,6,7])
    
    render json: tanks
  end
  
  # GET /getTanksForClient?clientId={clientId}&fromDate={fromDate}&toDate={toDate}
  def getTanksForClient
    @clientId = params[:clientId];
    tank_list = [];
    if @clientId == 'ALLCLIENTS'
      ClientTankInteraction.joins('JOIN clients as c on c.id = client_id').select('c.id, client_tank_interactions.status_id, client_tank_interactions.created_at').where('created_at BETWEEN ? AND ?', params[:fromDate], params[:toDate]).find_each do |tank|
        tank_list.push(tank)
      end
    else
      ClientTankInteraction.joins('JOIN clients as c on c.id = client_id').select('c.id, client_tank_interactions.status_id, client_tank_interactions.created_at').where('client_id = ? AND created_at BETWEEN ? AND ?', params[:clientId], params[:fromDate], params[:toDate]).find_each do |tank|
        tank_list.push(tank)
      end
    end
    @tankList = tank_list
    
    render json: @tankList
  end

  # DELETE /client_tank_interactions/1
  def destroy
    @client_tank_interaction.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_tank_interaction
      @client_tank_interaction = ClientTankInteraction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def client_tank_interaction_params
      params.require(:client_tank_interaction).permit(:client_id, :status_id)
    end
end
