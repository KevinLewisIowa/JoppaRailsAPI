class HeaterType < ApplicationRecord
    belongs_to :heater, :class_name => "Heater"
end
