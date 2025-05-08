class AdminController < ApplicationController
  
  # GET /getAdminRouteNumberMeals 
  def getAdminRouteNumberMeals
    @routeMeals = Client.joins('JOIN location_camps as lc on lc.id = current_camp_id')
    .joins('JOIN routes as r on r.id = lc.route_id')
    .select('r.name, sum(clients.number_meals) as totalNumberMeals')
    .where('clients.current_camp_id IS NOT NULL AND clients.current_camp_id > 0 AND clients.current_camp_id <> 449 AND
        r.is_active = ? AND lc.is_active = ?', true, true)
    .group('r.name')
    
    render json: @routeMeals 
  end
  
  # GET /getAdminRouteUndeliveredItems 
  def getAdminRouteUndeliveredItems
    @routeUndeliveredItems = Client.joins('JOIN requested_items AS ri ON clients.id = ri.client_id')
    .joins('JOIN location_camps AS lc ON clients.current_camp_id = lc.id')
    .joins('JOIN routes AS r ON lc.route_id = r.id')
    .select("r.name, clients.first_name, clients.preferred_name, clients.last_name, ri.id, ri.client_id, ri.item_description, ri.date_requested, ri.fulfilled, ri.created_at").where("ri.has_received = ?", false)
    .group("r.name, clients.first_name, clients.preferred_name, clients.last_name, ri.id, ri.client_id, ri.item_description, ri.date_requested, ri.created_at, ri.fulfilled")
    .order("r.name, clients.last_name, clients.first_name")
    
    render json: @routeUndeliveredItems
  end
  
  # GET /getAdminRouteUnfulfilledGoalsNextSteps
  def getAdminRouteUnfulfilledGoalsNextSteps
    @routeUnfulfilledGoalsNextSteps = ClientInteraction.joins({client: :goals_and_next_steps}, {location_camp: :route}).select("routes.name, clients.first_name, clients.preferred_name, clients.last_name, goals_and_next_steps.description").where("goals_and_next_steps.is_completed = ?", false).group("routes.name, clients.first_name, clients.preferred_name, client_interactions.id, clients.last_name, goals_and_next_steps.description")
    
    render json: @routeUnfulfilledGoalsNextSteps
  end
  
  # GET /getAdminRouteUnfulfilledPrayerRequestsNeeds
  def getAdminRouteUnfulfilledPrayerRequestsNeeds
    @routeUnfulfilledPrayerRequestsNeeds = PrayerRequestAndNeed.joins('JOIN clients ON clients.id = prayer_request_and_needs.client_id').select("clients.first_name, clients.preferred_name, clients.last_name, prayer_request_and_needs.detail, prayer_request_and_needs.created_at").group("clients.first_name, clients.preferred_name, clients.last_name, prayer_request_and_needs.detail, prayer_request_and_needs.created_at")
    
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
  
  # GET /getFirstTimeHomelessnessReport
  def getFirstTimeHomelessnessReport
      @homelessnessInfo = Client.select('first_name, preferred_name, last_name, birth_date, phone, first_time_homeless, date_became_homeless, homeless_reason')
      
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