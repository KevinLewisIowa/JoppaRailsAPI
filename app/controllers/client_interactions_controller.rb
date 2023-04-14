class ClientInteractionsController < ApplicationController
  before_action :set_client_interaction, only: [:show, :update, :destroy]

  # GET /client_interactions
  def index
    @client_interactions = ClientInteraction.all

    render json: @client_interactions
  end

  # GET /client_interactions/1
  def show
    render json: @client_interaction
  end
  
  # GET /seen_and_serviced_report?fromDate={fromDate}&toDate={toDate}
  def seen_and_serviced_report
    #attendance_records = [];
    @seen_and_serviced_report = ClientInteraction.joins('LEFT JOIN clients c ON client_interactions.client_id = c.id LEFT JOIN location_camps lc ON client_interactions.location_camp_id = lc.id LEFT JOIN routes r ON lc.route_id = r.id').where('client_interactions.serviced_date BETWEEN ? AND ?', params[:fromDate], Date.parse(params[:toDate]).next_day(1)).select('r.name, client_interactions.client_id, c.first_name, c.preferred_name, c.last_name, client_interactions.created_at, client_interactions.was_seen, client_interactions.serviced, client_interactions.at_homeless_resource_center, client_interactions.location_camp_id, lc.name AS camp_name, client_interactions.serviced_date').order('r.id, client_interactions.serviced_date')
      
    render json: @seen_and_serviced_report
  end
  
  # GET /clientAttendanceHistory?clientId={clientId}&fromDate={fromDate}&toDate={toDate}
  def clientAttendanceHistory
    @seen_and_serviced_report = ClientInteraction.where('client_interactions.client_id = ? AND client_interactions.serviced_date BETWEEN ? AND ?', params[:clientId], params[:fromDate], Date.parse(params[:toDate]).next_day(1)).select('client_interactions.id, client_interactions.created_at, client_interactions.was_seen, client_interactions.serviced, client_interactions.at_homeless_resource_center, client_interactions.location_camp_id, client_interactions.serviced_date').order('client_interactions.serviced_date')
    
    render json: @seen_and_serviced_report
  end

  # POST /client_interactions
  def create
    @client_interaction = ClientInteraction.new(client_interaction_params)
    

    if @client_interaction.save
      if @client_interaction.still_lives_here == true
        @client = Client.find(@client_interaction.client_id)
        @client.current_camp_id = @client_interaction.location_camp_id
        @client.save
      end
      render json: @client_interaction, status: :created, location: @client_interaction
    else
      render json: @client_interaction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /client_interactions/1
  def update
    if @client_interaction.update(client_interaction_params)
      render json: @client_interaction
    else
      render json: @client_interaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /client_interactions/1
  def destroy
    @client_interaction.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_interaction
      @client_interaction = ClientInteraction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def client_interaction_params
      params.require(:client_interaction).permit(:client_id, :location_camp_id, :serviced, :was_seen, :still_lives_here, :at_homeless_resource_center, :serviced_date)
    end
end
