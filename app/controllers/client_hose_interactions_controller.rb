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
    @interaction.updated_at = DateTime.current
    @interaction.save
    
    render json: @interaction
  end
  
  # GET /getHoseListing
  def getHoseListing
    @hoses = ClientHoseInteraction.joins(:client)
                         .joins('JOIN heater_statuses hs ON hs.id = client_hose_interactions.heater_status_id')
                         .select('client_hose_interactions.*, hs.*, clients.first_name, clients.last_name, clients.preferred_name');
    
    render json: @hoses
  end
  
  def getHosesLoanedToClient
    @interactions = ClientHoseInteraction.where('heater_status_id = ? AND client_id = ?', 2, params[:clientId])
    
    render json: @interactions
  end
  
  def getHosesNotReturnedForClient
    nowDate = DateTime.current
    startingDate = nowDate.days_ago(30)
    hoses = ClientHoseInteraction.where('client_id = ? AND updated_at > ? AND heater_status_id IN (?)', params[:clientId], startingDate, [3,4,5,6,7])
    
    render json: hoses
  end
  
  # GET /getHosesForClient?clientId={clientId}&fromDate={fromDate}&toDate={toDate}
  def getHosesForClient
    @clientId = params[:clientId];
    hose_list = [];
    if @clientId == 'ALLCLIENTS'
      ClientHoseInteraction.joins('JOIN clients as c on c.id = client_id').select('c.id, client_hose_interactions.heater_status_id, client_hose_interactions.created_at').where('client_hose_interactions.created_at BETWEEN ? AND ?', params[:fromDate], params[:toDate]).find_each do |hose|
        hose_list.push(hose)
      end
    else
      ClientHoseInteraction.joins('JOIN clients as c on c.id = client_id').select('c.id, client_hose_interactions.heater_status_id, client_hose_interactions.created_at').where('client_id = ? AND client_hose_interactions.created_at BETWEEN ? AND ?', params[:clientId], params[:fromDate], params[:toDate]).find_each do |hose|
        hose_list.push(hose)
      end
    end
    @hoseList = hose_list
    
    render json: @hoseList
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_hose_interaction
      @client_hose_interaction = ClientHoseInteraction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def client_hose_interaction_params
      params.require(:client_hose_interaction).permit(:client_id, :heater_status_id, :updated_at)
    end
end
