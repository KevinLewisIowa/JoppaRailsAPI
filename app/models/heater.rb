class Heater < ApplicationRecord
    has_one  :client_heater_interaction, class_name: "ClientHeaterInteraction",
                                         foreign_key: "heater_id",
                                         dependent: :destroy
                                         
    belongs_to :heater_status
                                    
    belongs_to :heater_type
end
