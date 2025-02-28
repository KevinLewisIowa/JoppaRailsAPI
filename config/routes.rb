Rails.application.routes.draw do
  resources :client_health_insurances
  resources :client_next_of_kins
  resources :client_incomes
  resources :client_homeless_histories
  resources :client_circle_of_friends
  resources :client_dwellings
  resources :location_camp_notes
  resources :client_referrals
  resources :client_tents
  resources :client_pets
  resources :route_instance_tank_hose_interactions
  resources :pass_tokens
  resources :route_instance_heater_interactions
  resources :client_hose_interactions
  resources :route_instances
  resources :heater_statuses
  resources :client_tank_interactions
  resources :client_heater_interactions
  resources :tanks
  resources :heater_types
  resources :heaters
  resources :health_concerns
  resources :location_camps
  resources :client_interactions
  resources :client_notes
  get       'getRouteCampsLongLat' => 'location_camps#getRouteCampsLongLat'
  get       'getClientLikes'      => 'clients#getClientLikes'
  get       'getClientHealthInsurance'      => 'client_health_insurances#getClientHealthInsurance'
  get       'getClientDislikes'   => 'clients#getClientDislikes'
  get       'getClientGoals'      => 'clients#getClientGoals'
  get       'getClientPrayerRequests' => 'clients#getClientPrayerRequests'
  get       'getClientHealthConcerns' => 'health_concerns#getClientHealthConcerns'
  get       'getClientRequestedItem' => 'clients#getClientRequestedItem'
  get       'getClientPets' => 'clients#getClientPets'
  get       'getFriendsForClient' => 'clients#getFriendsForClient'
  get       'getHousehold' => 'clients#getHousehold'
  get       'getClientReferrals' => 'clients#getClientReferrals'
  get       'getClientsForCamp'  =>  'location_camps#getClientsForCamp'
  get       'getClientCountForRoute'  =>  'location_camps#getClientCountForRoute'
  get       'getClientsByName'    => 'clients#getClientsByName'
  get       'getClientNotesForRoute'  => 'client_notes#getClientNotesForRoute'
  get       'getClientNotesForClient'  => 'client_notes#getClientNotesForClient'
  get       'getNotesForRouteInstance'  => 'client_notes#getNotesForRouteInstance'
  get       'getRouteSummaryInfoForRoute'  => 'route_instances#getRouteSummaryInfoForRoute'
  get       'getRouteInstancesForDate'  => 'route_instances#getRouteInstancesForDate'
  get       'getActiveRouteInstanceForRoute'     => 'route_instances#getActiveRouteInstanceForRoute'
  get       'recentReceivedItems'   =>  'requested_items#recentReceivedItems'
  get       'getClientHasFulfilledItems' => 'requested_items#getClientHasFulfilledItems'
  get       'getItemsByClientAndDate' => 'requested_items#getItemsByClientAndDate'
  get       'getCampsForRoute' => 'location_camps#getCampsForRoute'
  get       'getCampListing' => 'location_camps#getCampListing'
  get       'prayerRequestsForClient' => 'prayer_request_and_needs#prayerRequestsForClient'
  get       'likesForClient'        =>  'client_likes#likesForClient'
  get       'dislikesForClient'     =>  'client_dislikes#dislikesForClient'
  get       'goalsForClient'      => 'goals_and_next_steps#goalsForClient'
  get       'getTentsForClient'   => 'client_tents#getTentsForClient'
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
  get       'getTankListing' => 'client_tank_interactions#getTankListing'
  get       'getHoseListing' => 'client_hose_interactions#getHoseListing'
  get       'seen_and_serviced_report' => 'client_interactions#seen_and_serviced_report'
  get       'clientAttendanceHistory' => 'client_interactions#clientAttendanceHistory'
  get       'getClientAttendanceForRoute' => 'client_interactions#getClientAttendanceForRoute'
  get       'client_referrals_report' => 'client_referrals#client_referrals_report'
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
  get       'getHosesForClient'  => 'client_hose_interactions#getHosesForClient'
  get       'getHeatersNotReturnedForClient'  => 'client_heater_interactions#getHeatersNotReturnedForClient'
  get       'getTanksNotReturnedForClient'  => 'client_tank_interactions#getTanksNotReturnedForClient'
  get       'getTanksForClient'  => 'client_tank_interactions#getTanksForClient'
  get       'getNewClients'               => 'clients#getNewClients'
  get       'getClientsNewToCamps'        => 'clients#getClientsNewToCamps'
  get       'getClientBatches'            => 'clients#getClientBatches'
  get       'getClientIncomes'            => 'clients#getClientIncomes'
  get       'getClientNextOfKins'            => 'clients#getClientNextOfKins'
  get       'updateHeaterInteraction'     => 'client_heater_interactions#updateHeaterInteraction'
  get       'attemptLogin'                => 'pass_tokens#attemptLogin'
  get       'setNewPassword'              => 'pass_tokens#setNewPassword'
  get       'getFirstTimeHomelessnessReport'  => 'admin#getFirstTimeHomelessnessReport'
  get       'removeDuplicateClient'  => 'admin#removeDuplicateClient'
  get       'getCampNotes'                => 'location_camp_notes#getCampNotes'
  get      'updateCampRoutePosition'     => 'location_camps#updateCampRoutePosition'
  get       'getDwellingsForClient'       => 'client_dwellings#getDwellingsForClient'
  get       'getDwellingsForClients'     => 'client_dwellings#getDwellingsForClients'
  get       'getDwellingHistoriesForClient'       => 'client_homeless_histories#getDwellingHistoriesForClient'
  get       'getDwellingHistoriesForClients'     => 'client_homeless_histories#getDwellingHistoriesForClients'
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
  resources :client_tents
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
