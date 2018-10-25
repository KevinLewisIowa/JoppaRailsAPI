class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :update, :destroy]

  # GET /clients
  def index
    @clients = Client.all

    render json: @clients
  end

  # GET /clients/1
  def show
    render json: @client
  end

  # POST /clients
  def create
    @client = Client.new(client_params)

    if @client.save
      render json: @client, status: :created, location: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end
  
  # GET /clientLikes?clientId={id}
  def getClientLikes
    @likes = ClientLike.find_by(client_id: params[:clientId])
    
    render json: @likes
  end
  
  def getNewClients
    twoWeeksAgo = Date.today - 14
    
    @clients = Client.where('created_at > ?', twoWeeksAgo)
    
    render json: @clients
  end
  
  # GET /getClientDislikes?clientId={id}
  def getClientDislikes
    @dislikes = ClientDislike.find_by(client_id: params[:clientId])
    
    render json: @dislikes
  end
  
  # GET /getClientGoals?clientId={id}
  def getClientGoals
    @goals = GoalsAndNextStep.find_by(client_id: params[:clientId])
    
    render json: @dislikes
  end
  
  # GET /getClientPrayerRequests?clientId={id}
  def getClientPrayerRequests
    @requests = PrayerRequestAndNeed.find_by(client_id: params[:clientId])
    
    render json: @dislikes
  end
  
  # GET /getClientRequestedItem?clientId={id}
  def getClientRequestedItem
    @items = RequestedItem.where("client_id = ?", params[:clientId])
    
    render json: @items
  end

  # PATCH/PUT /clients/1
  def update
    if @client.update(client_params)
      render json: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  # DELETE /clients/1
  def destroy
    @client.destroy
  end
  
  def getClientsByName
    @clientName = params[:name];
    
    @clientList = [];
    if @clientName == 'ALLCLIENTS'
      @clientList = Client.all
    else
      @clientList = Client.where('preferred_name ILIKE ?', '%' + @clientName + '%')
    end
    
    render json: @clientList
  end
  
  def getClientsNewToCamps
    @clients = Client.where('current_camp_id <> previous_camp_id')
    
    render json: @clients
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def client_params
      params.require(:client).permit(:preferred_name, :is_veteran, :previous_camp_id, :current_camp_id, :deceased, :inactive, :inactive_description, :dwelling, :birth_date, :is_aftercare, :shoe_size, :boot_size, :number_meals, :phone, :joppa_apartment_umber)
    end
end
