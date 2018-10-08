class Tank < ApplicationRecord
    #has_one  :client_tank_interaction, class_name: "ClientTankInteraction",
     #                                    foreign_key: "tank_id",
      #                                   dependent: :destroy
      #removing this because tanks don't have identification stuff
end
