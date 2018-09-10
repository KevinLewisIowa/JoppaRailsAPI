Rails.application.routes.draw do
  resources :heater_statuses
  resources :client_tank_interactions
  resources :client_header_interactions
  resources :tanks
  resources :heater_types
  resources :heaters
  resources :health_concerns
  resources :location_camps
  resources :client_interactions
  get       'locationsForRoute'   => 'locations#locationsForRoute'
  get       'getClientLikes'      => 'clients#getClientLikes'
  get       'getClientDislikes'   => 'clients#getClientDislikes'
  get       'getClientGoals'      => 'clients#getClientGoals'
  get       'getClientPrayerRequests' => 'clients#getClientPrayerRequests'
  get       'getClientHealthConcerns' => 'health_concerns#getClientHealthConcerns'
  get       'getClientRequestedItem' => 'clients#getClientRequestedItem'
  get       'getClientsForLocationCampA'  =>  'locations#getClientsForLocationCampA'
  get       'getClientsForLocationCampB'  =>  'locations#getClientsForLocationCampB'
  get       'getClientsForLocationCampC'  =>  'locations#getClientsForLocationCampC'
  get       'getClientsForLocationCampD'  =>  'locations#getClientsForLocationCampD'
  get       'getClientsByName'    => 'clients#getClientsByName'
  get       'recentReceivedItems'   =>  'requested_items#recentReceivedItems'
  get       'getCampsForLocation' => 'location_camps#getCampsForLocation'
  get       'prayerRequestsForClient' => 'prayer_request_and_needs#prayerRequestsForClient'
  get       'likesForClient'        =>  'client_likes#likesForClient'
  get       'dislikesForClient'     =>  'client_dislikes#dislikesForClient'
  get       'goalsForClient'      => 'goals_and_next_steps#goalsForClient'
  get       'receivedRequestedItem' => 'requested_items#receivedRequestedItem'
  get       'getAdminRouteNumberMeals'      => 'admin#getAdminRouteNumberMeals'
  get       'getAdminRouteUndeliveredItems'      => 'admin#getAdminRouteUndeliveredItems'
  get       'getAdminRouteUnfulfilledPrayerRequestsNeeds'      => 'admin#getAdminRouteUnfulfilledPrayerRequestsNeeds'
  get       'getAdminRouteUnfulfilledGoalsNextSteps'      => 'admin#getAdminRouteUnfulfilledGoalsNextSteps'
  get       'getHeaterTypes' => 'heater_types#getHeaterTypes'
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
  resources :locations
  resources :routes
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end