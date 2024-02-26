class AdminController < ApplicationController
  
  # GET /getAdminSumNumberMeals 
  def getAdminRouteNumberMeals
    route_meals_list = [];
    @routeMeals = ClientInteraction.joins('INNER JOIN location_camps as lc on lc.id = location_camp_id')
                        .joins('INNER JOIN clients as c on c.id = client_id')
                        .joins('INNER JOIN routes as r on r.id = lc.route_id')
                        .select('r.name, sum(c.number_meals) as totalNumberMeals')
                        .where('client_interactions.still_lives_here = ? AND 
                            client_interactions.created_at = 
                            (SELECT MAX(created_at) from client_interactions 
                            where client_id = c.id and location_camp_id = lc.id) AND 
                            r.is_active = ? AND lc.is_active = ?', true, true, true)
                        .group('r.name').find_each do |meal|
      route_meals_list.push(meal)
    end
    @routeMeals = route_meals_list;
    
    render json: @routeMeals 
  end
  
  # GET /getAdminRouteUndeliveredItems 
  def getAdminRouteUndeliveredItems
    undelivered_items_list = [];
    Client.joins('INNER JOIN requested_items AS ri ON clients.id = ri.client_id')
    .joins('INNER JOIN location_camps AS lc ON clients.current_camp_id = lc.id')
    .joins('INNER JOIN routes AS r ON lc.route_id = r.id')
    .select("r.name, clients.first_name, clients.preferred_name, clients.last_name, ri.id, ri.client_id, ri.item_description, ri.date_requested, ri.fulfilled, ri.created_at").where("ri.has_received = ?", false)
    .group("r.name, clients.first_name, clients.preferred_name, clients.last_name, ri.id, ri.client_id, ri.item_description, ri.date_requested, ri.created_at, ri.fulfilled")
    .order("r.name, clients.last_name, clients.first_name").find_each do |item|
      undelivered_items_list.push(item)
    end
    @routeUndeliveredItems = undelivered_items_list
    
    render json: @routeUndeliveredItems
  end
  
  # GET /getAdminRouteUnfulfilledGoalsNextSteps
  def getAdminRouteUnfulfilledGoalsNextSteps
    unfulfilled_goals = [];
    ClientInteraction.joins({client: :goals_and_next_steps}, {location_camp: :route}).select("routes.name, clients.first_name, clients.preferred_name, clients.last_name, goals_and_next_steps.description").where("goals_and_next_steps.is_completed = ?", false).group("routes.name, clients.first_name, clients.preferred_name, clients.last_name, goals_and_next_steps.description").find_each do |goal|
      unfulfilled_goals.push(goal)
    end
    @routeUnfulfilledGoalsNextSteps = unfulfilled_goals
    
    render json: @routeUnfulfilledGoalsNextSteps
  end
  
  # GET /getAdminRouteUnfulfilledPrayerRequestsNeeds
  def getAdminRouteUnfulfilledPrayerRequestsNeeds
    unfulfilled_needs = [];
    ClientInteraction.joins({client: :prayer_request_and_needs}, {location_camp: :route}).select("routes.name, clients.first_name, clients.preferred_name, clients.last_name, prayer_request_and_needs.detail").where("prayer_request_and_needs.is_completed = ?", false).group("routes.name, clients.first_name, clients.preferred_name, clients.last_name, prayer_request_and_needs.detail").find_each do |prayer|
      unfulfilled_needs.push(prayer)
    end
    @routeUnfulfilledPrayerRequestsNeeds = unfulfilled_needs;
    
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
      
      heater_list = [];
      Heater.joins('INNER JOIN clients as cl on cl.id = current_client_id').where(heater_status_id:2).select('heaters.serial_number, cl.first_name, cl.preferred_name, cl.last_name').find_each do |heater|
        heater_list.push(heater)
      end
      @heaterList = heater_list;
      
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
  
  # GET /getFirstTimeHomelessnessReport
  def getFirstTimeHomelessnessReport
      first_time_homeless = [];
      Client.select('first_name, preferred_name, last_name, birth_date, phone, first_time_homeless, date_became_homeless, homeless_reason').find_each do |client|
        first_time_homeless.push(client)
      end
      @homelessnessInfo = first_time_homeless
      
      render json: @homelessnessInfo
  end
  
  # GET /removeDuplicateClient?duplicateClientId&activeClientId
  def removeDuplicateClient
      # retrieve params
      @duplicateClientId = params[:duplicateClientId].to_i
      if @c = Client.find_by(id: @duplicateClientId)
        # duplicate client found so continue
      else
        render json: false, status: 422
        return
      end
      
      @activeClientId = params[:activeClientId].to_i
      if @c = Client.find_by(id: @activeClientId)
        # active client found so continue
      else
        render json: false, status: 422
        return
      end
      
      # Update tables with client_id fields from duplicateClientId to activeClientId
      CampingEquipmentGivenDate.where(client_id: @duplicateClientId).update_all("client_id = #{@activeClientId}")
      ClientDislike.where(client_id: @duplicateClientId).update_all("client_id = #{@activeClientId}")
      ClientHeaterInteraction.where(client_id: @duplicateClientId).update_all("client_id = #{@activeClientId}")
      ClientHoseInteraction.where(client_id: @duplicateClientId).update_all("client_id = #{@activeClientId}")
      ClientInteraction.where(client_id: @duplicateClientId).update_all("client_id = #{@activeClientId}")
      ClientLike.where(client_id: @duplicateClientId).update_all("client_id = #{@activeClientId}")
      ClientNote.where(client_id: @duplicateClientId).update_all("client_id = #{@activeClientId}")
      ClientPet.where(client_id: @duplicateClientId).update_all("client_id = #{@activeClientId}")
      ClientTankInteraction.where(client_id: @duplicateClientId).update_all("client_id = #{@activeClientId}")
      GoalsAndNextStep.where(client_id: @duplicateClientId).update_all("client_id = #{@activeClientId}")
      HealthConcern.where(client_id: @duplicateClientId).update_all("client_id = #{@activeClientId}")
      PrayerRequestAndNeed.where(client_id: @duplicateClientId).update_all("client_id = #{@activeClientId}")
      RequestedItem.where(client_id: @duplicateClientId).update_all("client_id = #{@activeClientId}")
      
      # Delete duplicate client
      Client.find_by(id: @duplicateClientId).destroy
      
      render json: true
  end
    
end