class ClientHeaterInteraction < ApplicationRecord
    belongs_to :client, :class_name => "Client"
    belongs_to :heater, :class_name => "Heater"
end
