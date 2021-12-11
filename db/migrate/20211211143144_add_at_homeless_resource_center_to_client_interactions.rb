class AddAtHomelessResourceCenterToClientInteractions < ActiveRecord::Migration[6.1]
  def change
    add_column :client_interactions, :at_homeless_resource_center, :boolean
  end
end
