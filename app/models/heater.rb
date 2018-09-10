class Heater < ApplicationRecord
    has_one  :client_heater_interaction, class_name: "ClientHeaterInteraction",
                                         foreign_key: "heater_id",
                                         dependent: :destroy
                                         
    has_one  :heater_status, class_name: "HeaterStatus",
                                    foreign_key: "heater_status_id",
                                    dependent: :destroy
                                    
    has_one  :heater_type, class_name: "HeaterType",
                                    foreign_key: "heater_type_id",
                                    dependent: :destroy
end
