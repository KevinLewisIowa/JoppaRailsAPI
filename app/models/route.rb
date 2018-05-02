class Route < ApplicationRecord
    has_many :locations, class_name: "Location",
                        foreign_key: "route_id",
                        dependent: :destroy
end
