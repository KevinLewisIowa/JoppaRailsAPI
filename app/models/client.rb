class Client < ApplicationRecord
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
                                
    has_many :camping_equipment_given_dates, class_name: "CampingEquipmentGivenDate",
                                            foreign_key: "client_id",
                                            dependent: :destroy
end
