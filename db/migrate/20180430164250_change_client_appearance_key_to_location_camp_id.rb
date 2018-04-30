class ChangeClientAppearanceKeyToLocationCampId < ActiveRecord::Migration[5.0]
  def change
    rename_column :client_interactions, :location_id, :location_camp_id
  end
end
