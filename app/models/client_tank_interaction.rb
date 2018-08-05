class ClientTankInteraction < ApplicationRecord
    belongs_to :client, :class_name => "Client"
    belongs_to :tank, :class_name => "Tank"
end
