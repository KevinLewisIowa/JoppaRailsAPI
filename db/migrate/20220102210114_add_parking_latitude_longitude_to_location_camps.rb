class AddParkingLatitudeLongitudeToLocationCamps < ActiveRecord::Migration[6.1]
  def change
    add_column :location_camps, :parking_latitude, :decimal
    add_column :location_camps, :parking_longitude, :decimal
  end
end
