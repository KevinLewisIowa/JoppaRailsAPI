class HeaterType < ApplicationRecord
    #belongs_to :heater, :class_name => "Heater" #this breaks the seed, should be Heater has a heat type
end
