class ClientInteraction < ApplicationRecord
    belongs_to :client, :class_name => "Client"
    belongs_to :location_camp, :class_name => "LocationCamp"
    
    ROUTE_MEALS_SQL = <<-SQL
      (select
       r.name,
       sum(c.number_meals) as totalNumberMeals
      from client_interactions as ci
      join clients as c on ci.client_id = c.id
      join location_camps as lc on lc.id = ci.location_camp_id
      join locations as l on l.id = lc.location_id
      join routes as r on r.id = l.route_id
      where ci.still_lives_here = true 
        AND ci.created_at = (Select max(created_at) from client_interactions location_camp_id = lc.id)
      group by r.name)
    SQL
    
    SIMPLE_SQL = <<-SQL
        select r.name, 5 as totalNumberMeals
        from routes as r
    SQL
end
