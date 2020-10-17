Rails.application.routes.draw do
  resources :client_pets
  resources :route_instance_tank_hose_interactions
  resources :pass_tokens
  resources :route_instance_heater_interactions
  resources :client_hose_interactions
  resources :route_instances
  resources :heater_statuses
  resources :client_tank_interactions
  resources :client_header_interactions
  resources :tanks
  resources :heater_types
  resources :heaters
  resources :health_concerns
  resources :location_camps
  resources :client_interactions
  resources :client_notes
  get       'getRouteCampsLongLat' => 'location_camps#getRouteCampsLongLat'
  get       'getClientLikes'      => 'clients#getClientLikes'
  get       'getClientDislikes'   => 'clients#getClientDislikes'
  get       'getClientGoals'      => 'clients#getClientGoals'
  get       'getClientPrayerRequests' => 'clients#getClientPrayerRequests'
  get       'getClientHealthConcerns' => 'health_concerns#getClientHealthConcerns'
  get       'getClientRequestedItem' => 'clients#getClientRequestedItem'
  get       'getClientPets' => 'clients#getClientPets'
  get       'getHousehold' => 'clients#getHousehold'
  get       'getClientsForCamp'  =>  'location_camps#getClientsForCamp'
  get       'getClientsByName'    => 'clients#getClientsByName'
  get       'getClientNotesForRoute'  => 'client_notes#getClientNotesForRoute'
  get       'getClientNotesForClient'  => 'client_notes#getClientNotesForClient'
  get       'getNotesForRouteInstance'  => 'client_notes#getNotesForRouteInstance'
  get       'getRouteSummaryInfoForRoute'  => 'route_instances#getRouteSummaryInfoForRoute'
  get       'getRouteInstancesForDate'  => 'route_instances#getRouteInstancesForDate'
  get       'recentReceivedItems'   =>  'requested_items#recentReceivedItems'
  get       'getCampsForRoute' => 'location_camps#getCampsForRoute'
  get       'prayerRequestsForClient' => 'prayer_request_and_needs#prayerRequestsForClient'
  get       'likesForClient'        =>  'client_likes#likesForClient'
  get       'dislikesForClient'     =>  'client_dislikes#dislikesForClient'
  get       'goalsForClient'      => 'goals_and_next_steps#goalsForClient'
  get       'receivedRequestedItem' => 'requested_items#receivedRequestedItem'
  get       'getOverallAttendanceReport'      => 'admin#getOverallAttendanceReport'
  get       'getAdminRouteNumberMeals'      => 'admin#getAdminRouteNumberMeals'
  get       'getAdminRouteUndeliveredItems'      => 'admin#getAdminRouteUndeliveredItems'
  get       'getAdminRouteUnfulfilledPrayerRequestsNeeds'      => 'admin#getAdminRouteUnfulfilledPrayerRequestsNeeds'
  get       'getAdminInventoryReport'       => 'admin#getAdminInventoryReport'
  get       'getAdminRouteUnfulfilledGoalsNextSteps'      => 'admin#getAdminRouteUnfulfilledGoalsNextSteps'
  get       'getHeaterTypes' => 'heater_types#getHeaterTypes'
  get       'getHeaterStatuses' => 'heater_statuses#getHeaterStatuses'
  get       'getHeaterListing' => 'heaters#getHeaterListing'
  get       'seen_and_serviced_report' => 'client_interactions#seen_and_serviced_report'
  get       'clientAttendanceHistory' => 'client_interactions#clientAttendanceHistory'
  get       'updateHeaterClient'    => 'heaters#updateHeaterClient'
  get       'getHeatEquipmentPerRoute' => 'heaters#getHeatEquipmentPerRoute'
  get       'getHeatEquipmentPerRoute2' => 'heaters#getHeatEquipmentPerRoute2'
  get       'getHeatEquipmentPerRoute3' => 'heaters#getHeatEquipmentPerRoute3'
  get       'getHeatEquipmentPerRoute4' => 'heaters#getHeatEquipmentPerRoute4'
  get       'getHeatEquipmentPerRoute5' => 'heaters#getHeatEquipmentPerRoute5'
  get       'getHeatEquipmentPerRoute6' => 'heaters#getHeatEquipmentPerRoute6'
  get       'getCurrentHeatersForClient'  => 'heaters#getCurrentHeatersForClient'
  get       'getAvailableHeaters'          => 'heaters#getAvailableHeaters'
  get       'getTanksLoanedToClient'      => 'client_tank_interactions#getTanksLoanedToClient'
  get       'getHosesLoanedToClient'      => 'client_hose_interactions#getHosesLoanedToClient'
  get       'getClientsByBirthMonth'      => 'clients#getClientsByBirthMonth'
  get       'updateHoseInteraction'       => 'client_hose_interactions#updateHoseInteraction'
  get       'updateTankInteraction'       => 'client_tank_interactions#updateTankInteraction'
  get       'getCheckedOutHeaters'        => 'route_instance_heater_interactions#getCheckedOutHeaters'
  get       'isHeaterCheckedOutOnOtherRoute'        => 'route_instance_heater_interactions#isHeaterCheckedOutOnOtherRoute'
  get       'checkInAllHeaters' => 'route_instance_heater_interactions#checkInAllHeaters'
  get       'getHosesNotReturnedForClient'  => 'client_hose_interactions#getHosesNotReturnedForClient'
  get       'getHeatersNotReturnedForClient'  => 'client_heater_interactions#getHeatersNotReturnedForClient'
  get       'getTanksNotReturnedForClient'  => 'client_tank_interactions#getTanksNotReturnedForClient'
  get       'getNewClients'               => 'clients#getNewClients'
  get       'getClientsNewToCamps'        => 'clients#getClientsNewToCamps'
  get       'updateHeaterInteraction'     => 'client_heater_interactions#updateHeaterInteraction'
  get       'attemptLogin'                => 'pass_tokens#attemptLogin'
  get       'setNewPassword'              => 'pass_tokens#setNewPassword'
  get       'getFirstTimeHomelessnessReport'  => 'admin#getFirstTimeHomelessnessReport'
  resources :admin
  resources :volunteers
  resources :camping_equipment_given_dates
  resources :camping_equipments
  resources :goals_and_next_steps
  resources :requested_items
  resources :prayer_request_and_needs
  resources :client_likes
  resources :client_dislikes
  resources :clients
  resources :routes
  resources :users
  resources :route_instances
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end