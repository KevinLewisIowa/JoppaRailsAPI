class ClientDwellingsController < ApplicationController
  before_action :set_client_dwelling, only: [:show, :update, :destroy]

  # GET /client_dwellings
  def index
    @client_dwellings = ClientDwelling.all

    render json: @client_dwellings
  end

  # GET /client_dwellings/1
  def show
    render json: @client_dwelling
  end

  # POST /client_dwellings
  def create
    @client_dwelling = ClientDwelling.new(client_dwelling_params)

    if @client_dwelling.save
      render json: @client_dwelling, status: :created, location: @client_dwelling
    else
      render json: @client_dwelling.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /client_dwellings/1
  def update
    if @client_dwelling.update(client_dwelling_params)
      render json: @client_dwelling
    else
      render json: @client_dwelling.errors, status: :unprocessable_entity
    end
  end

  # DELETE /client_dwellings/1
  def destroy
    @client_dwelling.destroy
  end
  
  # GET /getDwellingsForClient?clientId={id}
  def getDwellingsForClient
    @dwellings = ClientDwelling.where(:client_id => params[:clientId])
    
    render json: @dwellings
  end
  
  # POST /dwellingsForClients
  def dwellingsForClients
    @clientIds = JSON.parse(client_list_params)
    @dwellings = ClientDwelling.where('client_id IN ?', @clientIds)
    
    render json: @dwellings
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_dwelling
      @client_dwelling = ClientDwelling.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_dwelling_params
      params.require(:client_dwelling).permit(:client_id, :date_became_homeless, :dwelling, :notes, :homeless_reason, :first_time_homeless)
    end
    
    # Get client_list which has a string of client ids to get dwellings for
    def client_list_params
      params.require(:client_list).permit(:clients)
    end
end
