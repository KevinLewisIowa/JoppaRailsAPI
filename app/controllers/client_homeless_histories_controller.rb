class ClientHomelessHistoriesController < ApplicationController
  before_action :set_client_homeless_history, only: [:show, :update, :destroy]

  # GET /client_homeless_histories
  def index
    @client_homeless_histories = filtered_client_homeless_histories

    render json: @client_homeless_histories
  end

  # GET /client_homeless_histories/1
  def show
    render json: @client_homeless_history
  end

  # POST /client_homeless_histories
  def create
    @client_homeless_history = ClientHomelessHistory.new(client_homeless_history_params)

    if @client_homeless_history.save
      render json: @client_homeless_history, status: :created, location: @client_homeless_history
    else
      render json: @client_homeless_history.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /client_homeless_histories/1
  def update
    if @client_homeless_history.update(client_homeless_history_params)
      render json: @client_homeless_history
    else
      render json: @client_homeless_history.errors, status: :unprocessable_entity
    end
  end

  # DELETE /client_homeless_histories/1
  def destroy
    @client_homeless_history.destroy
  end
  
  # GET /getDwellingsForClient?clientId={id}
  def getDwellingHistoriesForClient
    @dwellings = ClientHomelessHistory.where(:client_id => params[:clientId])
    
    render json: @dwellings
  end
  
  # GET /getDwellingsForClients?clientList={comma-separated list of client ids}
  def getDwellingHistoriesForClients
    @list_of_clients = params[:clientList]
    @array_of_client_ids = @list_of_clients.split(',').map(&:to_i)
      
    @dwellings = ClientHomelessHistory.where('client_id IN (?)', @array_of_client_ids)
    
    render json: @dwellings
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_homeless_history
      @client_homeless_history = ClientHomelessHistory.find(params[:id])
    end

    def filtered_client_homeless_histories
      relation = ClientHomelessHistory.all

      start_date = parse_date_param(params[:fromDate] || params[:from_date])
      end_date = parse_date_param(params[:toDate] || params[:to_date])

      if start_date && end_date && start_date > end_date
        return relation.none
      end

      relation = relation.where('date_became_homeless >= ?', start_date) if start_date
      relation = relation.where('date_became_homeless <= ?', end_date) if end_date

      client_id_filter = params[:clientId] || params[:client_id]
      unless client_id_filter.blank? || client_id_filter.to_s.casecmp('ALLCLIENTS').zero?
        relation = relation.where(client_id: client_id_filter)
      end

      relation.order(date_became_homeless: :desc, created_at: :desc)
    end

    def parse_date_param(value)
      return if value.blank?

      Date.parse(value.to_s)
    rescue ArgumentError
      nil
    end

    # Only allow a list of trusted parameters through.
    def client_homeless_history_params
      params.require(:client_homeless_history).permit(:client_id, :first_time_homeless, :date_became_homeless, :reason_for_homelessness, :note)
    end
end
