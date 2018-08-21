class AdminController < ApplicationController
  
  # GET /getAdminSumNumberMeals 
  def getAdminRouteNumberMeals
    @routeMeals = ClientInteraction.joins('INNER JOIN location_camps as lc on lc.id = location_camp_id')
                        .joins('INNER JOIN clients as c on c.id = client_id')
                        .joins('INNER JOIN locations as l on l.id = lc.location_id')
                        .joins('INNER JOIN routes as r on r.id = l.route_id')
                        .select('r.name, sum(c.number_meals) as totalNumberMeals')
                        .where('client_interactions.still_lives_here = ? AND client_interactions.created_at = ?', true, Client.where(:id => 1).maximum(:created_at))
                        .group('r.name')
    
   # @routeMeals = ClientInteraction.joins('INNER JOIN location_camps as lc on lc.id = location_camp_id')
    #                    .joins('INNER JOIN clients as c on c.id = client_id')
     #                   .joins('INNER JOIN locations as l on l.id = lc.location_id')
      #                  .joins('INNER JOIN routes as r on r.id = l.route_id')
       #                 .select('r.name, sum(c.number_meals) as totalNumberMeals')
        #                .where('still_lives_here = ?', true)
         #               .group('r.name')
    
    render json: @routeMeals 
  end
  
  # GET /getAdminRouteUndeliveredItems 
  def getAdminRouteUndeliveredItems
    @routeUndeliveredItems = ClientInteraction.joins({client: :requested_item}, {location_camp: {location: :route}}).select("routes.name, clients.preferred_name, requested_items.item_description").where("requested_items.has_received = ?", false).group("routes.name, clients.preferred_name, requested_items.item_description")
    
    render json: @routeUndeliveredItems
  end
  
  # GET /getAdminRouteUnfulfilledGoalsNextSteps
  def getAdminRouteUnfulfilledGoalsNextSteps
    @routeUnfulfilledGoalsNextSteps = ClientInteraction.joins({client: :goals_and_next_steps}, {location_camp: {location: :route}}).select("routes.name, clients.preferred_name, goals_and_next_steps.description").where("goals_and_next_steps.is_completed = ?", false).group("routes.name, clients.preferred_name, goals_and_next_steps.description")
    
    render json: @routeUnfulfilledGoalsNextSteps
  end
  
  # GET /getAdminRouteUnfulfilledPrayerRequestsNeeds
  def getAdminRouteUnfulfilledPrayerRequestsNeeds
    @routeUnfulfilledPrayerRequestsNeeds = ClientInteraction.joins({client: :prayer_request_and_needs}, {location_camp: {location: :route}}).select("routes.name, clients.preferred_name, prayer_request_and_needs.detail").where("prayer_request_and_needs.is_completed = ?", false).group("routes.name, clients.preferred_name, prayer_request_and_needs.detail")
    
    render json: @routeUnfulfilledPrayerRequestsNeeds
  end

  private
    
end