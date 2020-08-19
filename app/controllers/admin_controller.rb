class AdminController < ApplicationController
  
  # GET /getAdminSumNumberMeals 
  def getAdminRouteNumberMeals
    @routeMeals = ClientInteraction.joins('INNER JOIN location_camps as lc on lc.id = location_camp_id')
                        .joins('INNER JOIN clients as c on c.id = client_id')
                        .joins('INNER JOIN routes as r on r.id = lc.route_id')
                        .select('r.name, sum(c.number_meals) as totalNumberMeals')
                        .where('client_interactions.still_lives_here = ? AND 
                            client_interactions.created_at = 
                            (SELECT MAX(created_at) from client_interactions 
                            where client_id = c.id and location_camp_id = lc.id) AND 
                            r.is_active = ? AND lc.is_active = ?', true, true, true)
                        .group('r.name')
    
     #ClientInteraction.where('client_id = ? AND location_camp_id = ?', 2, 3).maximum(:created_at))
    
   # @routeMeals = ClientInteraction.joins('INNER JOIN location_camps as lc on lc.id = location_camp_id')
    #                    .joins('INNER JOIN clients as c on c.id = client_id')
     #                   .joins('INNER JOIN routes as r on r.id = lc.route_id')
       #                 .select('r.name, sum(c.number_meals) as totalNumberMeals')
        #                .where('still_lives_here = ?', true)
         #               .group('r.name')
    
    render json: @routeMeals 
  end
  
  # GET /getAdminRouteUndeliveredItems 
  def getAdminRouteUndeliveredItems
    @routeUndeliveredItems = ClientInteraction.joins({client: :requested_item}, {location_camp: :route}).select("routes.name, clients.first_name, clients.preferred_name, clients.last_name, requested_items.item_description, requested_items.date_requested").where("requested_items.has_received = ?", false).group("routes.name, clients.first_name, clients.preferred_name, clients.last_name, requested_items.item_description, requested_items.date_requested")
    
    render json: @routeUndeliveredItems
  end
  
  # GET /getAdminRouteUnfulfilledGoalsNextSteps
  def getAdminRouteUnfulfilledGoalsNextSteps
    @routeUnfulfilledGoalsNextSteps = ClientInteraction.joins({client: :goals_and_next_steps}, {location_camp: :route}).select("routes.name, clients.first_name, clients.preferred_name, clients.last_name, goals_and_next_steps.description").where("goals_and_next_steps.is_completed = ?", false).group("routes.name, clients.first_name, clients.preferred_name, clients.last_name, goals_and_next_steps.description")
    
    render json: @routeUnfulfilledGoalsNextSteps
  end
  
  # GET /getAdminRouteUnfulfilledPrayerRequestsNeeds
  def getAdminRouteUnfulfilledPrayerRequestsNeeds
    @routeUnfulfilledPrayerRequestsNeeds = ClientInteraction.joins({client: :prayer_request_and_needs}, {location_camp: :route}).select("routes.name, clients.first_name, clients.preferred_name, clients.last_name, prayer_request_and_needs.detail").where("prayer_request_and_needs.is_completed = ?", false).group("routes.name, clients.first_name, clients.preferred_name, clients.last_name, prayer_request_and_needs.detail")
    
    render json: @routeUnfulfilledPrayerRequestsNeeds
  end
  
  # GET /getAdminInventoryReport
  def getAdminInventoryReport
      @tanksOut = Client.sum(:number_tanks)
      @hosesOut = Client.sum(:number_hoses)
      @heatersOut = Heater.where(heater_status_id: 2).count
      @brokenHeaters = Heater.where(heater_status_id: 7).count
      @lostHeaters = Heater.where(heater_status_id: 5).count
      @destroyedHeaters = Heater.where(heater_status_id: 6).count
      @stolenHeaters = Heater.where(heater_status_id: 4).count
      @heaterList = Heater.joins('INNER JOIN clients as cl on cl.id = current_client_id').where(heater_status_id:2).select('heaters.serial_number, cl.first_name, cl.preferred_name, cl.last_name')
      
      render json: { tanksOut: @tanksOut, hosesOut: @hosesOut, heatersOut: @heatersOut, brokenHeaters: @brokenHeaters, lostHeaters: @lostHeaters, destroyedHeaters: @destroyedHeaters, stolenHeaters: @stolenHeaters, heaterList: @heaterList}
  end
  
  # GET /getOverallAttendanceReport?startDate&endDate
  def getOverallAttendanceReport
      @startDate = Date.strptime(params[:startDate], '%m/%d/%y');
      @endDate = Date.strptime(params[:endDate], '%m/%d/%y') + 1;
      
      @servicedIndividual = ClientInteraction.where('serviced = ?', true).where('client_interactions.created_at > ?', @startDate).where('client_interactions.created_at <= ?',@endDate).count
      @householdsServiced = ClientInteraction.joins('LEFT JOIN clients as c on c.id = client_id').where('serviced = ?', true).where('client_interactions.created_at > ?', @startDate).where('client_interactions.created_at <= ?',@endDate).select('DISTINCT c.household_id').count
      
      render json: { individualsServiced: @servicedIndividual, householdsServiced: @householdsServiced}
  end

  private
    
end