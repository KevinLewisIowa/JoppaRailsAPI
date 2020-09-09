class LocationCampsController < ApplicationController
  before_action :set_location_camp, only: [:show, :update, :destroy]

  # GET /location_camps
  def index
    @location_camps = LocationCamp.all

    render json: @location_camps
  end

  # GET /location_camps/1
  def show
    render json: @location_camp
  end

  # POST /location_camps
  def create
    @location_camp = LocationCamp.new(location_camp_params)

    if @location_camp.save
      render json: @location_camp, status: :created, location: @location_camp
    else
      render json: @location_camp.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /location_camps/1
  def update
    if @location_camp.update(location_camp_params)
      render json: @location_camp
    else
      render json: @location_camp.errors, status: :unprocessable_entity
    end
  end

  # DELETE /location_camps/1
  def destroy
    @location_camp.destroy
  end
  
  # GET /campsForRoute?routeId={route_id}
  def getCampsForRoute
    apiToken = request.headers['Authorization']
    passwordAndToken = PassToken.find(1)
    if passwordAndToken.api_token != apiToken
      return render json: {message: 'invalid-token'}
    end
    @camps = LocationCamp.where('route_id = ? AND is_active = ?', params[:routeId], true);
    
    render json: @camps
  end
  
  # GET /clientsForCamp?locationCampId={location_camp_id}
  def getClientsForCamp
    apiToken = request.headers['Authorization']
    passwordAndToken = PassToken.find(1)
    if passwordAndToken.api_token != apiToken
      return render json: {message: 'invalid-token'}
    end
    @clients = Client.where('current_camp_id = ? AND status = ?', params[:locationCampId], 'Active').order(first_name: :asc);
    
    render json: @clients
  end
  
  # /getRouteCampsLongLat?routeId={id}
  def getRouteCampsLongLat
    apiToken = request.headers['Authorization']
    passwordAndToken = PassToken.find(1)
    if passwordAndToken.api_token != apiToken
      return render json: {message: 'invalid-token'}
    end
    @routeCampsLongLat = LocationCamp.where('route_id = ? AND is_active = ?', params[:routeId], true).select("location_camps.name, location_camps.longitude, location_camps.latitude")
    
    render json: @routeCampsLongLat
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location_camp
      @location_camp = LocationCamp.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def location_camp_params
      params.require(:location_camp).permit(:route_id, :location_id, :name, :position, :notes, :longitude, :latitude, :is_active, :expected_arrival_time)
    end
end
