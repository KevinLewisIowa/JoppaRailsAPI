class AddHeatersOutHeatersInToRouteInstanceTankHoseInteractions < ActiveRecord::Migration[5.0]
  def change
    add_column :route_instance_tank_hose_interactions, :number_heaters_out, :integer
    add_column :route_instance_tank_hose_interactions, :number_heaters_in, :integer
  end
end
