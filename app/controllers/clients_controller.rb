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
    @client.current_camp_id = 0
    @client.previous_camp_id = 0

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
  
  # GET /getClientsByBirthMonth?monthInt={id}
  def getClientsByBirthMonth
    @clients = Client.where("EXTRACT(MONTH FROM birth_date) = ?", params[:monthInt])
    
    render json: @clients
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
  
  # GET /getClientPets?clientId={id}
  def getClientPets
    @items = ClientPet.where("client_id = ?", params[:clientId])
    
    render json: @items
  end

  # PATCH/PUT /clients/1
  def update
    @client.touch
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
      @clientList = Client.joins('INNER JOIN location_camps as lc on lc.id = current_camp_id INNER JOIN routes r ON lc.route_id = r.id').order('r.name', :status).select('clients.id, clients.phone, clients.first_name, clients.preferred_name, clients.last_name, clients.status, clients.last_interaction_date, r.name as route_name, lc.name as camp_name')
    else
      @clientList = Client.joins('INNER JOIN location_camps as lc on lc.id = current_camp_id INNER JOIN routes r ON lc.route_id = r.id').where('preferred_name ILIKE ?', '%' + @clientName + '%').order('r.name', :status).select('clients.id, clients.phone, clients.first_name, clients.preferred_name, clients.last_name, clients.status, clients.last_interaction_date, r.name as route_name, lc.name as camp_name')
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
      params.require(:client).permit(:first_name, :last_name, :preferred_name, :is_veteran, :deceased, :inactive, :inactive_description, :dwelling, :current_camp_id,
                              :previous_camp_id, :birth_date, :is_aftercare, :shoe_size, :boot_size, :number_meals, :phone, :joppa_apartment_number, :status, :gender, :last_interaction_date, :admin_notes)
    end
end
