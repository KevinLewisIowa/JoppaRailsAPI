class AddPermanentCampFieldToLocationCamps < ActiveRecord::Migration[6.1]
  def change
    add_column :location_camps, :remain_on_route, :boolean
  end
end
