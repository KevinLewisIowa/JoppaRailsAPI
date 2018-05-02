class Location < ApplicationRecord
    belongs_to :route
    
    has_many :location_camps, class_name: "LocationCamp",
                            foreign_key: "location_id",
                            dependent: :destroy
end
