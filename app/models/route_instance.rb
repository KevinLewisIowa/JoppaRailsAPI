class RouteInstance < ApplicationRecord
    has_one  :route_instance_heater_interaction, class_name: "RouteInstanceHeaterInteraction",
                                         foreign_key: "route_instance_id",
                                         dependent: :destroy
end
