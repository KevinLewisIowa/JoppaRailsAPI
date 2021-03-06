class HeatersController < ApplicationController
  before_action :set_heater, only: [:show, :update, :destroy]

  # GET /heaters
  def index
    @heaters = Heater.all

    render json: @heaters
  end

  # GET /heaters/1
  def show
    render json: @heater
  end
  
  def getHeaterListing
    @heaterListing = Heater.joins("LEFT JOIN clients ON heaters.current_client_id = clients.id LEFT JOIN location_camps as lc on lc.id = clients.current_camp_id LEFT JOIN routes r ON lc.route_id = r.id").joins(:heater_type, :heater_status).select("heaters.id, heater_types.type_description, heaters.serial_number, heater_statuses.status_name, heaters.status_reason, heaters.is_active, heaters.updated_at, clients.preferred_name, clients.first_name, clients.last_name, r.name  ")
    
    render json: @heaterListing
  end

  # POST /heaters
  def create
    @heater = Heater.new(heater_params)

    if @heater.save
      render json: @heater, status: :created, location: @heater
    else
      render json: @heater.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /heaters/1
  def update
    if @heater.update(heater_params)
      render json: @heater
    else
      render json: @heater.errors, status: :unprocessable_entity
    end
  end

  # DELETE /heaters/1
  def destroy
    @heater.destroy
  end
  # GET /updateHeaterClient?clientId={id}&heaterId={id}&status={id}
  def updateHeaterClient
    @clientId = params[:clientId];
    @heaterId = params[:heaterId];
    @status = params[:status];
    
    @heater = Heater.find(@heaterId);
    @heater.current_client_id = @clientId
    
    @interaction = ClientHeaterInteraction.new();
    @interaction.client_id = @clientId
    @interaction.heater_id = @heaterId
    @interaction.status_id = @status
    @interaction.save
    
    @heater.heater_status_id = @status;
    @heater.save;
    
    render json: @heater;
  end
  
  # GET /getCurrentHeatersForClient?clientId={id}
  def getCurrentHeatersForClient
    
    @heaters = Heater.joins(:heater_type, :heater_status).select("heaters.id, heater_types.type_description, heaters.serial_number, heater_statuses.status_name, heaters.status_reason, heaters.is_active, heaters.updated_at").where("current_client_id = ? AND heater_status_id = ?", params[:clientId], 2)
    
    render json: @heaters
  end
  
  # GET /getHeatEquipmentPerRoute
  def getHeatEquipmentPerRoute
    routes = Route.all
    details = Array.new
    routes.each do |theRoute|
      heaters = Heater.joins("INNER JOIN clients ON heaters.current_client_id = clients.id")
              .joins("INNER JOIN location_camps ON clients.current_camp_id = location_camps.id")
              .select("heaters.id, clients.first_name, clients.preferred_name, clients.last_name, location_camps.name")
              .where("heater_status_id = ? AND location_camps.route_id = ?", 2, theRoute.id)
              
      tankInteractions = ClientTankInteraction.joins("INNER JOIN clients ON client_tank_interactions.client_id = clients.id")
                      .joins("INNER JOIN location_camps ON clients.current_camp_id = location_camps.id")
                      .select("client_tank_interactions.id, clients.first_name, clients.preferred_name, clients.last_name, location_camps.name")
                      .where("client_tank_interactions.status_id = ? AND location_camps.route_id = ?", 2, theRoute.id)
                      
      hoseInteractions = ClientHoseInteraction.joins("INNER JOIN clients ON client_hose_interactions.client_id = clients.id")
                      .joins("INNER JOIN location_camps ON clients.current_camp_id = location_camps.id")
                      .select("client_hose_interactions.id, clients.first_name, clients.preferred_name, clients.last_name, location_camps.name")
                      .where("client_hose_interactions.heater_status_id = ? AND location_camps.route_id = ?", 2, theRoute.id)
                      
      details << { name: theRoute.name, heaterCount: heaters.length, tankCount: tankInteractions.length, hoseCount: hoseInteractions.length }
    end
    render json: details
  end
  
  def getHeatEquipmentPerRoute2
    interactions = ClientTankInteraction.joins("INNER JOIN clients ON client_tank_interactions.client_id = clients.id")
                      .joins("INNER JOIN location_camps ON clients.current_camp_id = location_camps.id")
                      .select("client_tank_interactions.id, clients.first_name, clients.preferred_name, clients.last_name, location_camps.name")
                      .where("client_tank_interactions.status_id = ?", 2)
              
    render json: interactions
  end
  
  def getHeatEquipmentPerRoute3
    interactions = ClientHoseInteraction.joins("INNER JOIN clients ON client_hose_interactions.client_id = clients.id")
                      .joins("INNER JOIN location_camps ON clients.current_camp_id = location_camps.id")
                      .select("client_hose_interactions.id, clients.first_name, clients.preferred_name, clients.last_name, location_camps.name")
                      .where("client_hose_interactions.heater_status_id = ?", 2)
              
    render json: interactions
  end
  
  def getHeatEquipmentPerRoute4
    routes = Route.all
    routes.each do |route|
      heaters = Heater.joins("INNER JOIN clients ON heaters.current_client_id = clients.id")
              .joins("INNER JOIN location_camps ON clients.current_camp_id = location_camps.id")
              .select("heaters.id, clients.first_name, clients.preferred_name, clients.last_name, location_camps.name")
              .where("heater_status_id = ?", 2)
      route.heaterCount = heaters.length
    end
    render json: routes
  end
  
  def getHeatEquipmentPerRoute5
    routes = Route.all
    routes.each do |route|
      heaters = Heater.joins("INNER JOIN clients ON heaters.current_client_id = clients.id")
              .joins("INNER JOIN location_camps ON clients.current_camp_id = location_camps.id")
              .select("heaters.id, clients.first_name, clients.preferred_name, clients.last_name, location_camps.name, location_camps.name")
              .where("heater_status_id = ?", 2)
    end
    render json: routes
  end
  
  def getHeatEquipmentPerRoute6
    @routes = Route.all
    heaters = Heater.joins("INNER JOIN clients ON heaters.current_client_id = clients.id")
              .joins("INNER JOIN location_camps ON clients.current_camp_id = location_camps.id")
              .select("heaters.id, clients.first_name, clients.preferred_name, clients.last_name, location_camps.name")
              .where("heater_status_id = ?", 2)
      
    render json: heaters
  end
  
  # GET /getAvailableHeaters?routeInstanceId={id}
  def getAvailableHeaters
    if (params[:routeInstanceId]) then
      @checkedOutHeaters = RouteInstanceHeaterInteraction.select('route_instance_heater_interactions.heater_id').where('route_instance_heater_interactions.is_checked_out = ? AND route_instance_heater_interactions.route_instance_id <> ?', true, params[:routeInstanceId]);  
    else
      @checkedOutHeaters = RouteInstanceHeaterInteraction.select('route_instance_heater_interactions.heater_id').where('route_instance_heater_interactions.is_checked_out = ? AND route_instance_heater_interactions.route_instance_id <> ?', true, 0);
    end
      
    
    @heaters = Heater.joins(:heater_type).select("heater_types.type_description, heaters.serial_number, heaters.id, heaters.heater_status_id").where("(heater_status_id = ? OR heater_status_id = ?) AND heaters.id NOT IN (?)", 1, 3, @checkedOutHeaters).uniq
    
    render json: @heaters
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_heater
      @heater = Heater.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def heater_params
      params.require(:heater).permit(:heater_type_id, :serial_number, :heater_status_id, :is_active)
    end
end
