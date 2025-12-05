class AddCampHeatRouteOnly < ActiveRecord::Migration[6.1]
  def change
    add_column :location_camps, :heat_route_only, :boolean
  end
end
