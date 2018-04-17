Rails.application.routes.draw do
  get       'locationsForRoute'   => 'locations#locationsForRoute'
  get       'getClientLikes'      => 'clients#getClientLikes'
  get       'getClientDislikes'   => 'clients#getClientDislikes'
  get       'getClientGoals'      => 'clients#getClientGoals'
  get       'getClientPrayerRequests' => 'clients#getClientPrayerRequests'
  get       'getClientRequestedItem' => 'clients#getClientRequestedItem'
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
