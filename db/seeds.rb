# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


routes = [{region: 'Central Iowa', name: 'Red', is_active: true},
           {region: 'Central Iowa', name: 'Orange', is_active: true},
           {region: 'Central Iowa', name: 'Yellow', is_active: true},
           {region: 'Central Iowa', name: 'Green', is_active: true},
           {region: 'Central Iowa', name: 'Blue', is_active: true}]
  
camps = [{route_id: 1, name: 'First Stop', position: 1, notes: '', latitude: 41.943513, longitude: -87.634554, is_active: true},
{route_id: 1, name: 'Second Stop', position: 2, notes: 'This is another test', latitude: 41.943513, longitude: -87.634554, is_active: true},
{route_id: 1, name: 'Third Stop', position: 3, notes: 'This is text', latitude: 41.943513, longitude: -87.634554, is_active: true},
{route_id: 1, name: 'Fourth Stop', position: 4, notes: 'Sample text', latitude: 41.943513, longitude: -87.634554, is_active: true},
{route_id: 2, name: 'Number 1 Stop', position: 1, notes: 'Vague text', latitude: 41.943513, longitude: -87.634554, is_active: true},
{route_id: 2, name: 'Number 2 Stop', position: 2, notes: 'This is a location', latitude: 41.943513, longitude: -87.634554, is_active: true},
{route_id: 2, name: 'The 3rd Stop', position: 3, notes: 'This is another location', latitude: 41.943513, longitude: -87.634554, is_active: true},
{route_id: 2, name: 'The 4th Stop', position: 4, notes: 'This is a description of notes', latitude: 41.943513, longitude: -87.634554, is_active: true},
{route_id: 3, name: '1st Stop', position: 1, notes: 'Some more text', latitude: 41.943513, longitude: -87.634554, is_active: true},
{route_id: 3, name: '2nd Stop', position: 2, notes: 'I am still going here', latitude: 41.943513, longitude: -87.634554, is_active: true},
{route_id: 3, name: 'The Third Stop', position: 3, notes: 'There is a lot of seed data', latitude: 41.943513, longitude: -87.634554, is_active: true},
{route_id: 3, name: 'The Fourth Stop', position: 4, notes: 'Some more seed data', latitude: 41.943513, longitude: -87.634554, is_active: true},
{route_id: 4, name: 'First Stop', position: 1, notes: 'And some more', latitude: 41.943513, longitude: -87.634554, is_active: true},
{route_id: 4, name: '2nd Stop', position: 2, notes: 'Someday I will be done', latitude: 41.943513, longitude: -87.634554, is_active: true},
{route_id: 4, name: '3rd Stop', position: 3, notes: 'Might be half way done', latitude: 41.943513, longitude: -87.634554, is_active: true},
{route_id: 4, name: '4th Stop', position: 4, notes: 'Definitely halfway done now', latitude: 41.943513, longitude: -87.634554, is_active: true},
{route_id: 4, name: '5th Stop', position: 5, notes: 'I am listening to mt joyj', latitude: 41.943513, longitude: -87.634554, is_active: true},
{route_id: 4, name: '6th Stop', position: 6, notes: 'The music is really good', latitude: 41.943513, longitude: -87.634554, is_active: true},
{route_id: 5, name: 'First Stop', position: 1, notes: 'Four left to write', latitude: 41.943513, longitude: -87.634554, is_active: true},
{route_id: 5, name: 'Second Stop', position: 2, notes: 'I am very close now', latitude: 41.943513, longitude: -87.634554, is_active: true},
{route_id: 5, name: 'Third Stop', position: 3, notes: 'Almost there', latitude: 41.943513, longitude: -87.634554, is_active: true}]

clients = [{preferred_name: 'Kevin Lewis', first_name: 'Kevin', last_name: 'Lewis', dwelling: 'Tent', is_veteran: false, is_aftercare: false, birth_date: '10/07/1993', shoe_size: '9', phone: '6417999450', joppa_apartment_number: '', number_meals: 1, current_camp_id: 3},
{preferred_name: 'Tim Wilson', first_name: 'Tim', last_name: 'Wilson', dwelling: 'Tent', is_veteran: false, is_aftercare: false, birth_date: '14/02/1973', shoe_size: '11', phone: '4759284829', joppa_apartment_number: '', number_meals: 1, current_camp_id: 2},
{preferred_name: 'Ryan Rutherford', first_name: 'Ryan', last_name: 'Rutherford', dwelling: 'Tent', is_veteran: false, is_aftercare: false, birth_date: '18/09/1990', shoe_size: '10', phone: '2983981711', joppa_apartment_number: '', number_meals: 1, current_camp_id: 1},
{preferred_name: 'Andrea Toppin', first_name: 'Andrea', last_name: 'Toppin', dwelling: 'Tent', is_veteran: false, is_aftercare: false, birth_date: '07/10/1985', shoe_size: '9', phone: '8372649304', joppa_apartment_number: '', number_meals: 1, current_camp_id: 1}]

interactions = [{location_camp_id: 1, client_id: 1, was_seen: true, serviced: true, still_lives_here: true},
{location_camp_id: 6, client_id: 2, was_seen: true, serviced: true, still_lives_here: true},
{location_camp_id: 1, client_id: 3, was_seen: false, serviced: true, still_lives_here: true},
{location_camp_id: 1, client_id: 4, was_seen: true, serviced: false, still_lives_here: false}]

heater_types = [{type_description: "Normal"},
{type_description: "Not Normal"}] 

# do not change these seeds for heater_status
heater_status = [{status_name: "Unassigned"},
{status_name: "Assigned"},
{status_name: "Retrieved"},
{status_name: "Stolen"},
{status_name: "Lost"},
{status_name: "Destroyed"},
{status_name: "Broken"},
{status_name: "Evicted"}]

heaters = [{heater_type_id: 1, serial_number: "012345", heater_status_id: 1, status_reason: "None", is_active: true, current_client_id: 1},
{heater_type_id: 1, serial_number: "987654", heater_status_id: 1, status_reason: "None", is_active: true}]

heater_types.each do |heater_type|
    HeaterType.create!(heater_type)
end

heater_status.each do |heater_stts|
    HeaterStatus.create!(heater_stts)
end

heaters.each do |heater|
    Heater.create!(heater)
end

routes.each do |route|
        Route.create!(route)
    end

camps.each do |camp|
        LocationCamp.create!(camp)
    end
    
clients.each do |client|
        Client.create!(client)
    end
    
interactions.each do |interaction|
        ClientInteraction.create!(interaction)
    end
    
# NOW ADD INDIVIDUAL CLIENT
# STUFF LIKE ITEMS AND LIKES AND NEEDS

items = [{client_id: 1, item_description: 'AA batteries', date_requested: '07/24/2018', has_received: false},
        {client_id: 1, item_description: 'AAA batteries', date_requested: '01/24/2018', has_received: false},
        {client_id: 2, item_description: 'dog food', date_requested: '07/17/2018', has_received: true},
        {client_id: 3, item_description: 'bug spray', date_requested: '07/24/2018', has_received: false},
        {client_id: 4, item_description: 'sunscreen', date_requested: '07/24/2018', has_received: false}]

goals = [{client_id: 1, description: 'get new license', is_completed: false},
        {client_id: 1, description: 'Apply for new job', is_completed: false},
        {client_id: 2, description: 'get a mailing address', is_completed: false},
        {client_id: 3, description: 'move into apartment', is_completed: false},
        {client_id: 3, description: 'open up bank account', is_completed: false},
        {client_id: 4, description: 'get interview clothes', is_completed: false}];

likes = [{client_id: 1, description: 'mashed potatoes'},
        {client_id: 1, description: 'funny jokes'},
        {client_id: 1, description: 'his dog'},
        {client_id: 2, description: 'apple juice'},
        {client_id: 3, description: 'cereal'},
        {client_id: 4, description: 'Oatmeal'},
        {client_id: 4, description: 'knock knock jokes'},
        {client_id: 4, description: 'hiking'}];

dislikes = [{client_id: 1, description: 'boring jokes'},
            {client_id: 1, description: 'asparagus'},
            {client_id: 2, description: 'tomatoes'},
            {client_id: 2, description: 'bad jokes'},
            {client_id: 3, description: 'coffee'},
            {client_id: 3, description: 'tea'},
            {client_id: 3, description: 'being called a certain name'},
            {client_id: 4, description: 'snow'}];

prayerRequests = [{client_id: 1, detail: 'family member will get healthy', is_completed: false},
                    {client_id: 1, detail: 'job interview goes well', is_completed: false},
                    {client_id: 2, detail: 'friend does not move away', is_completed: false},
                    {client_id: 3, detail: 'family member health', is_completed: true}];

items.each do |item|
    RequestedItem.create!(item)
end

goals.each do |goal|
    GoalsAndNextStep.create!(goal)
end
    
likes.each do |like|
    ClientLike.create!(like)
end

dislikes.each do |dislike|
    ClientDislike.create!(dislike)
end

prayerRequests.each do |prayer|
    PrayerRequestAndNeed.create!(prayer)
end

PassToken.create!({admin_password: 'J0ppa321', regular_password: 'regularPassword', api_token: 'firstTokenSeeded'})