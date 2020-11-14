class RouteInstancesController < ApplicationController
  before_action :set_route_instance, only: [:show, :update, :destroy]

  # GET /route_instances
  def index
    @route_instances = RouteInstance.all

    render json: @route_instances
  end

  # GET /route_instances/1
  def show
    render json: @route_instance
  end
  
  # GET /getRouteInstancesForDate?date={date}&routeId={routeId}
  def getRouteInstancesForDate
    @date = params[:date]
    @routeId = params[:routeId].to_i
    @route_instances = RouteInstance.where('start_time >= ? AND start_time < ? AND route_id = ?', @date, Date.parse(@date) + 1, @routeId.to_i)
    render json: @route_instances
  end
  
  # GET /getRouteSummaryInfoForRoute?routeInstanceId={route_instance_id}
  def getRouteSummaryInfoForRoute
    @routeInstanceId = params[:routeInstanceId].to_i
    
    
    @latest_route_instance_info = RouteInstance.where('id = (?)', @routeInstanceId).select('route_instances.*, 
    (SELECT COUNT(*) FROM client_interactions WHERE created_at >= route_instances.start_time AND created_at <= route_instances.end_time AND location_camp_id IN (SELECT location_camps.id FROM routes LEFT JOIN location_camps ON routes.id = location_camps.route_id WHERE routes.id = (SELECT route_id FROM route_instances WHERE id = ' + @routeInstanceId.to_s + ')) AND was_seen = true AND serviced = true) AS SeenAndServiced, 
    (SELECT COUNT(*) FROM client_interactions WHERE created_at >= route_instances.start_time AND created_at <= route_instances.end_time AND location_camp_id IN (SELECT location_camps.id FROM routes LEFT JOIN location_camps ON routes.id = location_camps.route_id WHERE routes.id = (SELECT route_id FROM route_instances WHERE id = ' + @routeInstanceId.to_s + ')) AND was_seen = false AND serviced = true) AS ServicedNotSeen,
    (SELECT COUNT(*) FROM (SELECT DISTINCT c.household_id FROM client_interactions ci LEFT JOIN clients c ON ci.client_id = c.id WHERE ci.created_at >= route_instances.start_time AND ci.created_at <= route_instances.end_time AND location_camp_id IN (SELECT location_camps.id FROM routes LEFT JOIN location_camps ON routes.id = location_camps.route_id WHERE routes.id = (SELECT route_id FROM route_instances WHERE id = ' + @routeInstanceId.to_s + ')) AND was_seen = true AND serviced = true) AS t) AS HouseholdsSeenAndServiced,
    (SELECT COUNT(*) FROM (SELECT DISTINCT c.household_id FROM client_interactions ci LEFT JOIN clients c ON ci.client_id = c.id WHERE ci.created_at >= route_instances.start_time AND ci.created_at <= route_instances.end_time AND location_camp_id IN (SELECT location_camps.id FROM routes LEFT JOIN location_camps ON routes.id = location_camps.route_id WHERE routes.id = (SELECT route_id FROM route_instances WHERE id = ' + @routeInstanceId.to_s + ')) AND was_seen = false AND serviced = true) AS t) AS HouseholdsServicedNotSeen')
    
    render json: @latest_route_instance_info
  end 

  # POST /route_instances
  def create
    @route_instance = RouteInstance.new(route_instance_params)

    if @route_instance.save
      render json: @route_instance, status: :created, location: @route_instance
    else
      render json: @route_instance.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /route_instances/1
  def update
    if @route_instance.update(route_instance_params)
      render json: @route_instance
    else
      render json: @route_instance.errors, status: :unprocessable_entity
    end
  end

  # DELETE /route_instances/1
  def destroy
    @route_instance.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_route_instance
      @route_instance = RouteInstance.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def route_instance_params
      params.require(:route_instance).permit(:route_id, :leader_name, :leader_phone, :number_route_members, :heat_route, :start_time, :end_time)
    end
end
