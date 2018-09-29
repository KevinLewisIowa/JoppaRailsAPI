class AddStatusIdToClientTankInteractions < ActiveRecord::Migration[5.0]
  def change
    add_column :client_tank_interactions, :status_id, :integer
  end
end
