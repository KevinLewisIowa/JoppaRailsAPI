class RouteInstanceHeaterInteraction < ApplicationRecord
    belongs_to :route_instance, :class_name => "RouteInstance"
    belongs_to :heater, :class_name => "Heater"
end
