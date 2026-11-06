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
  
  # GET /updateCampRoutePosition?campId={camp_id}&routeId={routeId}&position={position}
  def updateCampRoutePosition
    #if LocationCamp.where('id = ?', params[:campId]).update(route_id: params[:routeId], position: params[:position])
    @camp_to_update = LocationCamp.find(params[:campId])
    if @camp_to_update.update(route_id: params[:routeId], position: params[:position])
      render json: @camp_to_update
    else
      render json: @camp_to_update.errors, status: :unprocessable_entity
    end
  end

  # DELETE /location_camps/1
  def destroy
    @location_camp.destroy
  end
  
  # GET /campsForRoute?routeId={route_id}
  def getCampsForRoute
    camps = []
    LocationCamp.where('route_id = ? AND is_active = ?', params[:routeId], true).find_each do |camp|
      camps.push(camp)
    end
    @camps = camps
    
    render json: @camps
  end
  
  # GET /clientCountForRoute?routeId={route_id}
  def getClientCountForRoute
    clients = []
    
    Client.joins('JOIN location_camps lc ON clients.current_camp_id = lc.id').where('lc.route_id = ? AND status = ? AND lc.is_active = ?', params[:routeId], 'Active', true).find_each do |client|
      clients.push(client)
    end
    @clientCount = clients.count
    
    render json: @clientCount
  end
  
  # GET /clientsForCamp?locationCampId={location_camp_id}
  def getClientsForCamp
    clients = [];
    Client.where('current_camp_id = ? AND status = ?', params[:locationCampId], 'Active').order(first_name: :asc).find_each do |client|
      clients.push(client)
    end
    @clients = clients
    
    render json: @clients
  end

  # GET /getClientsForCampSummary?locationCampId={location_camp_id}
  def getClientsForCampSummary
    client_columns = (Client.column_names - ['client_picture', 'dwelling']).map { |column| "clients.#{column}" }
    clients = Client.where(current_camp_id: params[:locationCampId], status: 'Active')
                    .select(
                      *client_columns,
                      "(COALESCE(clients.client_picture, '') <> '') AS has_picture, " \
                      '(SELECT client_dwellings.dwelling FROM client_dwellings ' \
                      'WHERE client_dwellings.client_id = clients.id ' \
                      'ORDER BY client_dwellings.created_at DESC, client_dwellings.id DESC LIMIT 1) AS current_dwelling, ' \
                      "(BTRIM(COALESCE(clients.admin_notes, '')) <> '' OR EXISTS (" \
                      "SELECT 1 FROM client_notes WHERE client_notes.client_id = clients.id " \
                      "AND client_notes.source IN ('PINNED NOTE', 'WARNING', 'RESOURCE CENTER ALERT'))) AS has_attention_note, " \
                      '(EXISTS (SELECT 1 FROM heaters WHERE heaters.current_client_id = clients.id AND heaters.heater_status_id = 2) ' \
                      'OR EXISTS (SELECT 1 FROM client_tank_interactions WHERE client_tank_interactions.client_id = clients.id AND client_tank_interactions.status_id = 2) ' \
                      'OR EXISTS (SELECT 1 FROM client_hose_interactions WHERE client_hose_interactions.client_id = clients.id AND client_hose_interactions.heater_status_id = 2)) AS has_heating_equipment, ' \
                      '(EXISTS (SELECT 1 FROM requested_items WHERE requested_items.client_id = clients.id ' \
                      'AND requested_items.fulfilled = TRUE AND requested_items.has_received = FALSE)) AS has_fulfilled_items'
                    )
                    .order(first_name: :asc, last_name: :asc, id: :asc)

    render json: clients
  end
  
  # /getRouteCampsLongLat?routeId={id}
  def getRouteCampsLongLat
    @routeCampsLongLat = LocationCamp.where('route_id = ? AND is_active = ?', params[:routeId], true).select("location_camps.name, location_camps.longitude, location_camps.latitude")
    
    render json: @routeCampsLongLat
  end
  
  # /getCampListing
  def getCampListing
    #apiToken = request.headers['Authorization']
    #passwordAndToken = PassToken.find(1)
    #if passwordAndToken.api_token != apiToken
    #  return render json: {message: 'invalid-token'}
    #end
    location_camps = []
    LocationCamp.joins('LEFT JOIN routes r ON location_camps.route_id = r.id').select('location_camps.id, location_camps.name as camp_name, location_camps.location_id, location_camps.is_active, location_camps.route_id, location_camps.position, location_camps.notes, location_camps.longitude, location_camps.latitude, location_camps.parking_longitude, location_camps.parking_latitude, location_camps.expected_arrival_time, location_camps.admin_notes, location_camps.remain_on_route, r.name as route_name, location_camps.heat_route_only').find_each do |camp|
      location_camps.push(camp)
    end
    @location_camps = location_camps
    
    render json: @location_camps
  end

  # GET /getPaginatedCampListing?page=1&page_size=50&query=
  def getPaginatedCampListing
    page = [params[:page].to_i, 1].max
    requested_page_size = params[:page_size].to_i
    page_size = (1..100).cover?(requested_page_size) ? requested_page_size : 50
    query = params[:query].to_s.strip

    camps = LocationCamp.joins('LEFT JOIN routes r ON location_camps.route_id = r.id')
    unless query.blank?
      camps = camps.where(
        "concat_ws(' ', location_camps.name, r.name, location_camps.notes) ILIKE :term",
        term: "%#{query}%"
      )
    end

    total = camps.distinct.count('location_camps.id')
    sort_columns = {
      'camp_name' => 'location_camps.name',
      'route_name' => 'r.name',
      'position' => 'location_camps.position',
      'is_active' => 'location_camps.is_active',
      'remain_on_route' => 'location_camps.remain_on_route'
    }
    sort_column = sort_columns.fetch(params[:sort_by], 'location_camps.name')
    sort_direction = params[:sort_direction] == 'desc' ? 'DESC' : 'ASC'

    camp_page = camps
                .select(
                  'location_camps.id, location_camps.name AS camp_name, location_camps.location_id, ' \
                  'location_camps.is_active, location_camps.route_id, location_camps.position, ' \
                  'location_camps.notes, location_camps.longitude, location_camps.latitude, ' \
                  'location_camps.parking_longitude, location_camps.parking_latitude, ' \
                  'location_camps.expected_arrival_time, location_camps.admin_notes, ' \
                  'location_camps.remain_on_route, r.name AS route_name, location_camps.heat_route_only'
                )
                .order(Arel.sql("#{sort_column} #{sort_direction} NULLS LAST, location_camps.id ASC"))
                .limit(page_size)
                .offset((page - 1) * page_size)

    render json: { camps: camp_page, total: total }
  end

  # GET /getRouteListing
  def getRouteListing
    routes = Route.where(is_active: true)
                  .select(
                    'routes.*, ' \
                    '(SELECT COUNT(*) FROM location_camps WHERE location_camps.route_id = routes.id ' \
                    'AND location_camps.is_active = TRUE) AS number_stops, ' \
                    '(SELECT COUNT(*) FROM clients ' \
                    'INNER JOIN location_camps ON clients.current_camp_id = location_camps.id ' \
                    'WHERE location_camps.route_id = routes.id AND clients.status = \'Active\' ' \
                    'AND location_camps.is_active = TRUE) AS number_clients'
                  )
                  .order(:name)

    render json: routes
  end

  # GET /getRouteOverviewSummary?routeId={route_id}&heatRoute=true
  def getRouteOverviewSummary
    route = Route.find(params[:routeId])
    heat_route = ActiveModel::Type::Boolean.new.cast(params[:heatRoute])
    client_count_condition = "clients.current_camp_id = location_camps.id AND clients.status = 'Active'"
    if heat_route
      latest_dwelling = '(SELECT client_dwellings.dwelling FROM client_dwellings ' \
                        'WHERE client_dwellings.client_id = clients.id ' \
                        'ORDER BY client_dwellings.created_at DESC, client_dwellings.id DESC LIMIT 1)'
      client_count_condition += " AND #{latest_dwelling} IN ('Tent', 'Garage', 'Shack', 'Camper', 'Broken Down Van')"
    end

    camps = LocationCamp.where(route_id: route.id, is_active: true)
                        .select(
                          'location_camps.id, location_camps.route_id, location_camps.name, ' \
                          'location_camps.position, location_camps.heat_route_only, ' \
                          "(SELECT COUNT(*) FROM clients WHERE #{client_count_condition}) AS number_clients_at_camp"
                        )

    pet_counts = ClientPet.joins('INNER JOIN clients ON clients.id = client_pets.client_id')
                          .joins('INNER JOIN location_camps ON location_camps.id = clients.current_camp_id')
                          .where(
                            location_camps: { route_id: route.id, is_active: true },
                            clients: { status: 'Active' }
                          )
                          .group('client_pets.pet_type')
                          .sum('COALESCE(client_pets.quantity, 1)')
                          .each_with_object(Hash.new(0)) do |(pet_type, quantity), totals|
      key = pet_type.blank? ? 'unknown' : pet_type.to_s.strip.downcase.pluralize
      totals[key] += quantity
    end

    render json: {
      route: route,
      camps: camps,
      pet_counts: { totals: pet_counts }
    }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location_camp
      @location_camp = LocationCamp.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def location_camp_params
      params.require(:location_camp).permit(:route_id, :location_id, :name, :position, :notes, :longitude, :latitude, :is_active, :expected_arrival_time, :admin_notes, :parking_latitude, :parking_longitude, :remain_on_route, :heat_route_only)
    end
end
