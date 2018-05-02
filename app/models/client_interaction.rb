class ClientInteraction < ApplicationRecord
    belongs_to :client, :class_name => "Client"
    belongs_to :location_camp, :class_name => "LocationCamp"
end
