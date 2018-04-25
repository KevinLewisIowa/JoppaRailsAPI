class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :update, :destroy]

  # GET /locations
  def index
    @locations = Location.all

    render json: @locations
  end

  # GET /locations/1
  def show
    render json: @location
  end

  # POST /locations
  def create
    @location = Location.new(location_params)

    if @location.save
      render json: @location, status: :created, location: @location
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /locations/1
  def update
    if @location.update(location_params)
      render json: @location
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  # DELETE /locations/1
  def destroy
    @location.destroy
  end
  
  # GET /locationsForRoute?routeId={id}
  def locationsForRoute
    @locations = Location.find_by(route_id: params[:routeId]) #maybe Location.where('route_id = ?', params[:routeId])
    
    render json: @locations
  end
  
  def clientsForLocation
    results = Array.new
    @clientIds = ClientInteraction.find_by(location_id: params[:locationId])
    
    @clientIds.each do |clientId|
        tempClient = Client.find_by_id(clientId.client_id)
        if tempClient != nil
          results.push(tempClient);
        end
    end
    
    render json: results
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def location_params
      params.require(:location).permit(:route_id, :name, :position, :notes, :longitude, :latitude, :is_active)
    end
end
