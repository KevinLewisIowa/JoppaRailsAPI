class LocationCamp < ApplicationRecord
    belongs_to :location
    
    has_many :client_interactions, class_name: "ClientInteraction",
                                    foreign_key: "location_camp_id",
                                    dependent: :destroy
end
