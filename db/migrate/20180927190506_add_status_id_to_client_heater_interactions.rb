class AddStatusIdToClientHeaterInteractions < ActiveRecord::Migration[5.0]
  def change
    add_column :client_heater_interactions, :status_id, :integer
  end
end
