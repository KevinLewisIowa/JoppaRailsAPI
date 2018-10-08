class ClientTankInteraction < ApplicationRecord
    belongs_to :client, :class_name => "Client"
end
