class LocationsController < ApplicationController
  #before_action :set_location, only: [:show, :update, :destroy]

  # GET /locations
  #def index
  #  @locations = Location.all

  #  render json: @locations
  #end

  # GET /locations/1
  #def show
  #  render json: @location
  #end

  # POST /locations
  #def create
  #  @location = Location.new(location_params)

  #  if @location.save
  #    render json: @location, status: :created, location: @location
  #  else
  #    render json: @location.errors, status: :unprocessable_entity
  #  end
  #end

  # PATCH/PUT /locations/1
  #def update
  #  if @location.update(location_params)
  #    render json: @location
  #  else
  #    render json: @location.errors, status: :unprocessable_entity
  #  end
  #end

  # DELETE /locations/1
  #def destroy
  #  @location.destroy
  #end
  
  # GET /locationsForRoute?routeId={id}
  #def locationsForRoute
  #  apiToken = request.headers['Authorization']
  #  passwordAndToken = PassToken.find(1)
  #  if passwordAndToken.api_token != apiToken
  #    return render json: {message: 'invalid-token'}
  #  end
  #  @locations = Location.where('route_id = ? AND is_active = ?', params[:routeId], true)
    
  #  render json: @locations
  #end
  
  #def getClientsForLocationCampB
  #  results = Array.new
  #  @locationCamp = LocationCamp.find(params[:locationCampId]);
    
  #  @locationCamp.client_interactions.each do |interaction|
  #    results.push(interaction.client)
  #  end
    
  #  render json: results
  #end
  
  #this is the one that is used
  #def getClientsForLocationCampC
  #  results = Array.new
  #  #@maybeDates = ClientInteraction.where(:location_camp_id => params[:locationCampId]).group("client_id").order(:created_at).last # .maximum(:created_at)
  #  #@results = ClientInteraction.where(:created_at => @maybeDates)
    
  #  @maybeDates = ClientInteraction.where(:location_camp_id => params[:locationCampId]).distinct.pluck(:client_id);
  #  @maybeDates.each do |theId|
  #    mostRecent = ClientInteraction.where('client_id = ? AND location_camp_id = ?', theId, params[:locationCampId]).last
  #    if mostRecent.still_lives_here
  #      results.push(mostRecent.client)
  #      results.last.updated_at = mostRecent.created_at
  #    end
  #  end
    
  #  render json: results;
  #end
  
  # /getRouteLocationsLongLat?routeId={id}
  #def getRouteLocationsLongLat
  #  apiToken = request.headers['Authorization']
  #  passwordAndToken = PassToken.find(1)
  #  if passwordAndToken.api_token != apiToken
  #    return render json: {message: 'invalid-token'}
  #  end
  #  @routeLocationsLongLat = Location.where('route_id = ? AND is_active = ?', params[:routeId], true).select("locations.name, locations.longitude, locations.latitude")
    
  #  render json: @routeLocationsLongLat
  #end

  #private
    # Use callbacks to share common setup or constraints between actions.
  #  def set_location
  #    @location = Location.find(params[:id])
  #  end

    # Only allow a trusted parameter "white list" through.
  #  def location_params
  #    params.require(:location).permit(:route_id, :name, :position, :notes, :longitude, :latitude, :is_active)
  #  end
end
