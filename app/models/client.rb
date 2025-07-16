class Client < ApplicationRecord
    validates :first_name, uniqueness: { scope: [:last_name, :middle_name, :birth_date] }
    
    has_many :client_interactions, class_name: "ClientInteraction",
                                    foreign_key: "client_id",
                                    dependent: :destroy
                                    
    has_many :client_dislikes, class_name: "ClientDislike",
                                foreign_key: "client_id",
                                dependent: :destroy
                                
    has_many :client_likes, class_name: "ClientLike",
                            foreign_key: "client_id",
                            dependent: :destroy
                            
    has_many :goals_and_next_steps, class_name: "GoalsAndNextStep",
                                    foreign_key: "client_id",
                                    dependent: :destroy
                                    
    has_many :prayer_request_and_needs, class_name: "PrayerRequestAndNeed",
                                        foreign_key: "client_id",
                                        dependent: :destroy
                                        
    has_many :requested_item, class_name: "RequestedItem",
                                foreign_key: "client_id",
                                dependent: :destroy
                                
    has_many :client_pet, class_name: "ClientPet",
                                foreign_key: "client_id",
                                dependent: :destroy
                                
    has_many :client_tents, class_name: "ClientTent",
                            foreign_key: "client_id",
                            dependent: :destroy
                                
    has_many :camping_equipment_given_dates, class_name: "CampingEquipmentGivenDate",
                                            foreign_key: "client_id",
                                            dependent: :destroy
                                            
    has_one  :client_heater_interaction, class_name: "ClientHeaterInteraction",
                                         foreign_key: "client_id",
                                         dependent: :destroy
                                         
    has_one :location_camp, class_name: "LocationCamp",
                                        foreign_key: "current_camp_id"
                                         
    has_many :client_tank_interaction, class_name: "ClientTankInteraction",
                                         foreign_key: "client_id",
                                         dependent: :destroy
                                         
    has_many :client_note, class_name: "ClientNote",
                                         foreign_key: "client_id",
                                         dependent: :destroy
                                         
    has_many :client_dwelling, class_name: "ClientDwelling",
                                         foreign_key: "client_id",
                                         dependent: :destroy
                                         
    has_many :client_circle_of_friend, class_name: "ClientCircleOfFriend",
                                         foreign_key: "client_id",
                                         dependent: :destroy
end
