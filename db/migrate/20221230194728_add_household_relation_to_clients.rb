class AddHouseholdRelationToClients < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :household_relationship_type, :string
  end
end
