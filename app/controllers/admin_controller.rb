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
    @routeUndeliveredItems = Client.joins('INNER JOIN requested_items AS ri ON clients.id = ri.client_id')
        .joins('INNER JOIN location_camps AS lc ON clients.current_camp_id = lc.id')
        .joins('INNER JOIN routes AS r ON lc.route_id = r.id')
        .select("r.name, clients.first_name, clients.preferred_name, clients.last_name, ri.item_description, ri.date_requested, ri.created_at").where("ri.has_received = ?", false).group("r.name, clients.first_name, clients.preferred_name, clients.last_name, ri.item_description, ri.date_requested, ri.created_at")
    
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
        
      else
          render json: "No client with duplicate client id"
          return
      end
      
      @activeClientId = params[:activeClientId].to_i
      if @c = Client.find_by(id: @activeClientId)
        
      else
          render json: "No client with active client id"
          return
      end
      
      # Update tables with client_id fields from duplicateClientId to activeClientId
      if @cegd = CampingEquipmentGivenDate.find_by(client_id: @duplicateClientId)
        @cegd.update(client_id: @activeClientId)
      end
      
      if @cd = ClientDislike.find_by(client_id: @duplicateClientId)
        @cd.update(client_id: @activeClientId)
      end
      
      if @chi = ClientHeaterInteraction.find_by(client_id: @duplicateClientId)
        @chi.update(client_id: @activeClientId)
      end
      
      if @choi = ClientHoseInteraction.find_by(client_id: @duplicateClientId)
        @choi.update(client_id: @activeClientId)
      end
      
      if @ci = ClientInteraction.find_by(client_id: @duplicateClientId)
        @ci.update(client_id: @activeClientId)
      end
      
      if @cl = ClientLike.find_by(client_id: @duplicateClientId)
        @cl.update(client_id: @activeClientId)
      end
      
      if @cn = ClientNote.find_by(client_id: @duplicateClientId)
        @cn.update(client_id: @activeClientId)
      end
      
      if @cp = ClientPet.find_by(client_id: @duplicateClientId)
        @cp.update(client_id: @activeClientId)
      end
      
      if @cti = ClientTankInteraction.find_by(client_id: @duplicateClientId)
        @cti.update(client_id: @activeClientId)
      end
      
      if @gans = GoalsAndNextStep.find_by(client_id: @duplicateClientId)
        @gans.update(client_id: @activeClientId)
      end
      
      if @hc = HealthConcern.find_by(client_id: @duplicateClientId)
        @hc.update(client_id: @activeClientId)
      end
      
      if @pran = PrayerRequestAndNeed.find_by(client_id: @duplicateClientId)
        @pran.update(client_id: @activeClientId)
      end
      
      if @ri = RequestedItem.find_by(client_id: @duplicateClientId)
        @ri.update(client_id: @activeClientId)
      end
      
      # Delete duplicate client
      if @c = Client.find_by(id: @duplicateClientId)
        @c.destroy
      end
      
      render json: true
  end
    
end