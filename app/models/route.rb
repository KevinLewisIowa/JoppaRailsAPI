class Route < ApplicationRecord
    has_many :location_camps, class_name: "LocationCamp",
                        foreign_key: "route_id",
                        dependent: :destroy
end
