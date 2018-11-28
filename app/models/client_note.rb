class ClientNote < ApplicationRecord
    belongs_to :client
    belongs_to :route_instance
end
