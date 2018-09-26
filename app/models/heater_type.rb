class HeaterType < ApplicationRecord
    has_one  :heater, class_name: "Heater",
                                         foreign_key: "heater_id",
                                         dependent: :destroy
end
