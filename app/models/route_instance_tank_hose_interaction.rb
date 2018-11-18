class RouteInstanceTankHoseInteraction < ApplicationRecord
    belongs_to :route_instance, :class_name => "RouteInstance"
end
