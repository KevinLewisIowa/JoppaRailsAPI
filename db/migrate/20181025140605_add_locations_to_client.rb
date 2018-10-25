class AddLocationsToClient < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :current_camp_id, :integer
    add_column :clients, :previous_camp_id, :integer
  end
end
