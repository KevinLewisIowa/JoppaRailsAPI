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
    @routeUndeliveredItems = ClientInteraction.joins({client: :requested_item}, {location_camp: :route}).select("routes.name, clients.preferred_name, requested_items.item_description").where("requested_items.has_received = ?", false).group("routes.name, clients.preferred_name, requested_items.item_description")
    
    render json: @routeUndeliveredItems
  end
  
  # GET /getAdminRouteUnfulfilledGoalsNextSteps
  def getAdminRouteUnfulfilledGoalsNextSteps
    @routeUnfulfilledGoalsNextSteps = ClientInteraction.joins({client: :goals_and_next_steps}, {location_camp: :route}).select("routes.name, clients.preferred_name, goals_and_next_steps.description").where("goals_and_next_steps.is_completed = ?", false).group("routes.name, clients.preferred_name, goals_and_next_steps.description")
    
    render json: @routeUnfulfilledGoalsNextSteps
  end
  
  # GET /getAdminRouteUnfulfilledPrayerRequestsNeeds
  def getAdminRouteUnfulfilledPrayerRequestsNeeds
    @routeUnfulfilledPrayerRequestsNeeds = ClientInteraction.joins({client: :prayer_request_and_needs}, {location_camp: :route}).select("routes.name, clients.preferred_name, prayer_request_and_needs.detail").where("prayer_request_and_needs.is_completed = ?", false).group("routes.name, clients.preferred_name, prayer_request_and_needs.detail")
    
    render json: @routeUnfulfilledPrayerRequestsNeeds
  end
  
  # GET /getAdminInventoryReport
  def getAdminInventoryReport
      @tanksOut = Client.sum(:number_tanks)
      @hosesOut = Client.sum(:number_hoses)
      @heatersOut = Heater.where(heater_status_id: 2).count
      @brokenHeaters = Heater.where(heater_status_id: 7).count
      @lostHeaters = Heater.where(heater_status_id: 5).count
      @destroyedHeaters = Heaters.where(heater_status_id: 6).count
      @stolenHeaters = Heater.where(heater_status_id: 4).count
      @heaterList = Heater.joins('INNER JOIN clients as cl on cl.id = current_client_id').where(heater_status_id:2)
      
      render json: { tanksOut: @tanksOut, hosesOut: @hosesOut, heatersOut: @heatersOut, brokenHeaters: @brokenHeaters, lostHeaters: @lostHeaters, destroyedHeaters: @destroyedHeaters, stolenHeaters: @stolenHeaters, heaterList: @heaterList}
  end
  
  # GET /getAdminInventoryReport2
  def getAdminInventoryReport2
     render json: {tanksOut: 3, hosesOut: 4, heatersOut: 5} 
  end

  private
    
end