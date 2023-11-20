class AddClientCoordinatesLatLong < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :latitude, :decimal
    add_column :clients, :longitude, :decimal
  end
end
