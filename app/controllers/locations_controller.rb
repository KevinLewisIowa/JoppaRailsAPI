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
    @locations = Location.where(:route_id => params[:routeId]) #maybe Location.where('route_id = ?', params[:routeId])
    
    render json: @locations
  end
  
  def getClientsForLocationCamp
   # results = Array.new
   # @clientIds = ClientInteraction.where(:location_camp_id => params[:locationCampId])
    
   # @clientIds.each do |clientId|
   #     tempClient = Client.find(clientId.client_id)
   #     if tempClient != nil
   #       results.push(tempClient);
   #     end
    #end
    
    #render json: @clientIds
    results = Array.new
    @locationCamp = LocationCamp.find(params[:locationCampId]);
    
    @locationCamp.client_interactions.each do |interaction|
      results.push(interaction.client)
    end
    
    render json: results
    
   # @resultSet = Client.joins("INNER JOIN (SELECT * FROM client_interactions) ON 
   #                           client_interactions.client_id = clients.id 
    #                          WHERE client_interactions.still_lives_here = true 
    #                          AND client_interactions.created_at = (SELECT MAX(created_at) 
    #                              from client_interactions WHERE client_id = clients.id)")
    #                        .where(:location_camp_id => params[:locationCampId])
    
    #render json: @resultSet
    
    #SELECT * FROM clients JOIN client_interactions ON 
    #clients.id = client_interactions.client_id 
    #WHERE client_interactions.still_lives_here 
      #AND client_interactions.created_date = (SELECT MAX(created_date) from client_interactions WHERE client_id = clients.id) 
        #AND client_interactions.location_camp_id = locationCampId
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
