class RouteInstance < ApplicationRecord
    has_one  :route_instance_heater_interaction, class_name: "RouteInstanceHeaterInteraction",
                                         foreign_key: "route_instance_id",
                                         dependent: :destroy
                                         
    has_one  :route_instance_tank_hose_interaction, class_name: "RouteInstanceTankHoseInteraction",
                                         foreign_key: "route_instance_id",
                                         dependent: :destroy
                                         
    has_many :client_note, class_name: "ClientNote",
                                         foreign_key: "client_id",
                                         dependent: :destroy
end
