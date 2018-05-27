# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

routes = [{city: 'Des Moines', name: 'Red', is_active: true},
           {city: 'Des Moines', name: 'Orange', is_active: true},
           {city: 'Des Moines', name: 'Yellow', is_active: true},
           {city: 'Des Moines', name: 'Green', is_active: true},
           {city: 'Des Moines', name: 'Blue', is_active: true},
           {city: 'Des Moines', name: 'Indigo', is_active: true},
           {city: 'Des Moines', name: 'Violet', is_active: true}]
           
locations = [{route_id: 1, name: 'First Stop', position: 1, notes: '', latitude: 8743.32, longitude: 9283.38, is_active: true},
{route_id: 1, name: 'First Stop', position: 1, notes: 'This is the note', latitude: 8743.32, longitude: 9283.38, is_active: true},
{route_id: 1, name: 'First Stop', position: 2, notes: 'This is another test', latitude: 8743.32, longitude: 9283.38, is_active: true},
{route_id: 1, name: 'First Stop', position: 3, notes: 'This is text', latitude: 8743.32, longitude: 9283.38, is_active: true},
{route_id: 1, name: 'First Stop', position: 4, notes: 'Sample text', latitude: 8743.32, longitude: 9283.38, is_active: true},
{route_id: 2, name: 'First Stop', position: 1, notes: 'Vague text', latitude: 8743.32, longitude: 9283.38, is_active: true},
{route_id: 2, name: 'First Stop', position: 2, notes: 'This is a location', latitude: 8743.32, longitude: 9283.38, is_active: true},
{route_id: 2, name: 'First Stop', position: 3, notes: 'This is another location', latitude: 8743.32, longitude: 9283.38, is_active: true},
{route_id: 2, name: 'First Stop', position: 4, notes: 'This is a description of notes', latitude: 8743.32, longitude: 9283.38, is_active: true},
{route_id: 3, name: 'First Stop', position: 1, notes: 'Some more text', latitude: 8743.32, longitude: 9283.38, is_active: true},
{route_id: 3, name: 'First Stop', position: 2, notes: 'I am still going here', latitude: 8743.32, longitude: 9283.38, is_active: true},
{route_id: 3, name: 'First Stop', position: 3, notes: 'There is a lot of seed data', latitude: 8743.32, longitude: 9283.38, is_active: true},
{route_id: 3, name: 'First Stop', position: 4, notes: 'Some more seed data', latitude: 8743.32, longitude: 9283.38, is_active: true},
{route_id: 4, name: 'First Stop', position: 1, notes: 'And some more', latitude: 8743.32, longitude: 9283.38, is_active: true},
{route_id: 4, name: 'First Stop', position: 2, notes: 'Someday I will be done', latitude: 8743.32, longitude: 9283.38, is_active: true},
{route_id: 4, name: 'First Stop', position: 3, notes: 'Might be half way done', latitude: 8743.32, longitude: 9283.38, is_active: true},
{route_id: 4, name: 'First Stop', position: 4, notes: 'Definitely halfway done now', latitude: 8743.32, longitude: 9283.38, is_active: true},
{route_id: 4, name: 'First Stop', position: 5, notes: 'I am listening to mt joyj', latitude: 8743.32, longitude: 9283.38, is_active: true},
{route_id: 4, name: 'First Stop', position: 6, notes: 'The music is really good', latitude: 8743.32, longitude: 9283.38, is_active: true},
{route_id: 5, name: 'First Stop', position: 1, notes: 'Four left to write', latitude: 8743.32, longitude: 9283.38, is_active: true},
{route_id: 5, name: 'First Stop', position: 2, notes: 'I am very close now', latitude: 8743.32, longitude: 9283.38, is_active: true},
{route_id: 5, name: 'First Stop', position: 3, notes: 'Almost there', latitude: 8743.32, longitude: 9283.38, is_active: true},
{route_id: 6, name: 'First Stop', position: 1, notes: 'This is some more notes on a location', latitude: 8743.32, longitude: 9283.38, is_active: true},
{route_id: 7, name: 'First Stop', position: 1, notes: 'This is the last one', latitude: 8743.32, longitude: 9283.38, is_active: true}]

camps = [{location_id: 1, name: 'A Camp 1', is_active: true},
{location_id: 2, name: 'A Camp location 2', is_active: true},
{location_id: 3, name: 'Another camp', is_active: true},
{location_id: 4, name: 'Here is a camp', is_active: true},
{location_id: 5, name: 'Another camp', is_active: true},
{location_id: 6, name: 'This is a camp', is_active: true},
{location_id: 7, name: 'This is another camp', is_active: true},
{location_id: 8, name: 'This is a camp', is_active: true},
{location_id: 9, name: 'Inside a location', is_active: true},
{location_id: 10, name: 'This is another camp', is_active: true},
{location_id: 11, name: 'This is another camp', is_active: true},
{location_id: 12, name: 'This is also a camp', is_active: true},
{location_id: 13, name: 'First camp here', is_active: true},
{location_id: 14, name: 'First camp here too', is_active: true},
{location_id: 15, name: 'This is the first', is_active: true},
{location_id: 16, name: 'First one now', is_active: true},
{location_id: 17, name: 'Now the first', is_active: true},
{location_id: 18, name: 'Now the first one', is_active: true},
{location_id: 19, name: 'This is first one for the location', is_active: true},
{location_id: 20, name: 'First of location', is_active: true},
{location_id: 21, name: 'The first', is_active: true},
{location_id: 22, name: 'First camp', is_active: true},
{location_id: 23, name: 'First one here', is_active: true},
{location_id: 1, name: 'This is the second camp', is_active: true},
{location_id: 2, name: 'Second camp', is_active: true},
{location_id: 3, name: 'Second camp', is_active: true},
{location_id: 4, name: 'The Second camp', is_active: true},
{location_id: 5, name: 'The second camp', is_active: true},
{location_id: 1, name: 'This is the third', is_active: true},
{location_id: 2, name: 'This is third camp', is_active: true},
{location_id: 3, name: 'This is a third camp', is_active: true}];

clients = [{preferredName: 'Kevin Lewis', isVeteran: false, isAfterCare: false, birthDate: '07/10/1993', shoeSize: '9', phone: '6417999450', joppaApartmentNumber: ''},
{preferredName: 'Tim Wilson', isVeteran: false, isAfterCare: false, birthDate: '02/14/1973', shoeSize: '11', phone: '4759284829', joppaApartmentNumber: ''},
{preferredName: 'Ryan Rutherford', isVeteran: false, isAfterCare: false, birthDate: '09/18/1990', shoeSize: '10', phone: '2983981711', joppaApartmentNumber: ''},
{preferredName: 'Andrea Toppin', isVeteran: false, isAfterCare: false, birthDate: '10/07/1985', shoeSize: '9', phone: '8372649304', joppaApartmentNumber: ''}]

interactions = [{location_camp_id: 1, client_id: 1, was_seen: true, serviced: true, still_lives_here: true},
{location_camp_id: 1, client_id: 2, was_seen: true, serviced: true, still_lives_here: true},
{location_camp_id: 1, client_id: 3, was_seen: false, serviced: true, still_lives_here: true},
{location_camp_id: 1, client_id: 4, was_seen: true, serviced: false, still_lives_here: true}]

routes.each do |route|
        Route.create!(route)
    end
    
locations.each do |location|
        Location.create!(location)
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