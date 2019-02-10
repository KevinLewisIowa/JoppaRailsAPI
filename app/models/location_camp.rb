class LocationCamp < ApplicationRecord
    belongs_to :route
    
    has_many :client_interactions, class_name: "ClientInteraction",
                                    foreign_key: "location_camp_id",
                                    dependent: :destroy
end
