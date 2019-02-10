class AddLocationFieldsToLocationCamp < ActiveRecord::Migration[5.0]
  def change
    add_column :location_camps, :route_id, :integer
    add_column :location_camps, :position, :integer
    add_column :location_camps, :notes, :string
    add_column :location_camps, :longitude, :decimal
    add_column :location_camps, :latitude, :decimal
  end
end
